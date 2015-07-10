@Todos ||= {}

Constants = @Todos.Constants

#
# Todos Actions
#
# An object map of action names to action functions.
#
# See: http://fluxxor.com/documentation/actions.html

@Todos.Actions =
  fetchTasks: (callback) ->
    $.getJSON(Constants.FETCH_TASKS_URL, (data) =>
      @dispatch(Constants.FETCH_TASKS, data)
      callback() if callback?
    ).fail((jqXHR, textStatus, errorThrown) ->
      @dispatch(Constants.FETCH_TASKS, [])
    )

  createTask: (taskName, callback) ->
    url = Constants.CREATE_TASK_URL
    data =
      _method: 'POST'
      task:
        name: taskName
    $.ajax(
      url: url
      type: 'POST'
      data: data
    ).done((data, textStatus, jqXHR) =>
      @dispatch(Constants.UPDATE_TASK_VALUE, data)
      callback() if callback?
    )

  updateTask: (task, callback) ->
    @dispatch(Constants.UPDATE_TASK_VALUE, task)
    url = Constants.UPDATE_TASK_URL.replace(/:id/, task.id)
    data =
      _method: 'PUT'
      task: task
    $.ajax(
      url: url
      type: 'POST'
      data: data
      #beforeSend: (xhr) =>
    ).done((data, textStatus, jqXHR) =>
      callback() if callback?
    )

  deleteTask: (task, callback) ->
    @dispatch(Constants.DELETE_TASK_VALUE, task)
    url = Constants.DELETE_TASK_URL.replace(/:id/, task.id)
    data =
      _method: 'DELETE'
      task: task
    $.ajax(
      url: url
      type: 'POST'
      data: data
    ).done((data, textStatus, jqXHR) =>
      @dispatch(Constants.DELETE_TASK_VALUE, data)
      callback() if callback?
    )