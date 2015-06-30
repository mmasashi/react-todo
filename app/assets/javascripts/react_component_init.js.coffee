# @cjsx

jQuery ->
  if $('#js-todos').size()
    # Create flux object
    flux = new Fluxxor.Flux(Todos.Stores, Todos.Actions)

    el = $('#js-todos')

    React.render(
      <Todos.Main flux={flux} />
    , el.get(0))
