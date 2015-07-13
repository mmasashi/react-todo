@Todos ||= {}

Constants = @Todos.Constants

#
# Todos Store
#

TodosStore = Fluxxor.createStore
  initialize: ->
    @_initializePersistentState()
    @_bindActionsToHandlers()

  getState: ->
    state = @_getPersistentState()
    #$.extend(state, @_getEphemeralState())

  onFetchTasks: (tasks) ->
    @tasks = tasks
    @emit('change')

  onUpdateTaskValue: (newTask) ->
    task = @_findTask(newTask.id)
    if task
      $.extend(task, newTask)
    else
      @tasks.unshift(newTask)
    @emit('change')

  onDeleteTaskValue: (task) ->
    @_deleteTask(task.id)
    @emit('change')

  _initializePersistentState: ->
    # Task
    #  id: <Integer>
    #  name: <String>
    #  done: <Boolean>
    @tasks = []

  _getPersistentState: ->
    tasks: @tasks

  _bindActionsToHandlers: ->
    @bindActions(
      Constants.FETCH_TASKS, @onFetchTasks
      Constants.UPDATE_TASK_VALUE, @onUpdateTaskValue
      Constants.DELETE_TASK_VALUE, @onDeleteTaskValue
    )

  _findTask: (task_id) ->
    for task in @tasks
      if task.id == task_id
        return task
    return null

  _deleteTask: (task_id) ->
    for task, i in @tasks
      if task.id == task_id
        @tasks.splice(i,1)
        return

#
# Todos Stores
#
# An object map of store names to store instances.
@Todos.Stores =
  TodosStore: new TodosStore()
