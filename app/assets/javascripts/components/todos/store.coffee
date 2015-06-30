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
    )

  _findTask: (task_id) ->
    for task in @tasks
      if task.id == task_id
        return task
    return null

#
# Todos Stores
#
# An object map of store names to store instances.
@Todos.Stores =
  TodosStore: new TodosStore()
