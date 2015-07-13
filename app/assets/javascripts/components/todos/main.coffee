# @cjsx

@Todos ||= {}

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Constants = @Todos.Constants

@Todos.Main = React.createClass
  mixins: [FluxMixin, StoreWatchMixin('TodosStore')]

  getStateFromFlux: ->
    flux = @getFlux()
    flux.store('TodosStore').getState()

  componentWillMount: ->
    @getFlux().actions.fetchTasks()

  render: ->
    <div className='Todos'>
      <div className='Todos-title'>
        <h1>TODO LIST</h1>
      </div>
      <div className='Todos-container'>
        <NewTodo ref='newTodo' onCreateTask={@onCreateTask} />
        <TodoList tasks={@state.tasks} onChangeTask={@onChangeTask} onDeleteTask={@onDeleteTask}/>
      </div>
    </div>

  onChangeTask: (task) ->
    @getFlux().actions.updateTask(task)

  onCreateTask: (taskName) ->
    @getFlux().actions.createTask(taskName, () =>
      @refs.newTodo.clearInput()
    )

  onDeleteTask: (task) ->
    @getFlux().actions.deleteTask(task)

NewTodo = React.createClass
  propTypes: ->
    tasks: React.PropTypes.arrayOf(React.PropTypes.object).isRequired
    onCreateTask: React.PropTypes.object

  render: ->
    <div className='NewTodo-container'>
      <input type='text' ref='taskNameField' />
      <button className="btn btn-default" onClick={@onClick}>Add</button>
    </div>

  clearInput: ->
    React.findDOMNode(@refs.taskNameField).value = ''

  onClick: ->
    taskName = React.findDOMNode(@refs.taskNameField).value
    if taskName != '' && @props.onCreateTask then @props.onCreateTask(taskName)

  #_getTaskNameField: ->
  #  $(this.getDOMNode()).find('input.NewTodo-taskname')

TodoList = React.createClass
  propTypes: ->
    tasks: React.PropTypes.arrayOf(React.PropTypes.object).isRequired
    onChangeTask: React.PropTypes.object
    onDeleteTask: React.PropTypes.object

  render: ->
    <div className='TodoList-container'>
      <table className='table table-hover'>
        <thead>
          <tr>
            <th className='TodoList-th-done'>Done</th>
            <th className='TodoList-th-task'>Task</th>
            <th className='TodoList-th-edit'>EDIT</th>
          </tr>
        </thead>
        <tbody>
          {@render_tasks()}
        </tbody>
      </table>
    </div>

  render_tasks: ->
    for task in @props.tasks
      <TodoTask key={task.id} task={task} onChangeTask={@props.onChangeTask} onDeleteTask={@props.onDeleteTask}/>

TodoTask = React.createClass
  propTypes: ->
    task: React.PropTypes.object.isRequired
    onChangeTask: React.PropTypes.object
    onDeleteTask: React.PropTypes.object

  render: ->
    task = @props.task
    taskClass = if task.done then 'done' else ''
    <tr className='TodoList-tr'>
      <td className='TodoList-td-done'>
        <input
          type='checkbox'
          defaultChecked={task.done}
          onChange={@onChange}
        />
      </td>
      <td className="TodoList-td-task #{taskClass}">{task.name}</td>
      <td>
        <button
          type='button'
          className='btn btn-danger'
          onClick={@onDeleteTask}>DELETE</button>
      </td>
    </tr>

  onChange: (event) ->
    task = @props.task
    task.done = !task.done
    if @props.onChangeTask
      @props.onChangeTask(task)

  onDeleteTask: (event) ->
    task = @props.task
    if task != '' && @props.onDeleteTask then @props.onDeleteTask(task)