@Todos ||= {}

#
# Todos Constants
#

@Todos.Constants =
  # Action Identifiers
  FETCH_TASKS: 'FETCH_TASKS'
  UPDATE_TASK_VALUE: 'UPDATE_TASK_VALUE'

  # URLs
  FETCH_TASKS_URL: '/tasks'
  CREATE_TASK_URL: '/tasks'
  UPDATE_TASK_URL: '/tasks/:id'
