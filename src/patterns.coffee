NoMatch = {}

guard = (predicates, wrapped) ->
    predicate = bakePredicates predicates
    ->
      if predicate(arguments...) then wrapped(arguments...) else NoMatch

Any = ->



patterns =
  NoMatch: NoMatch

  guard: guard

  Any: Any


bakeFunctionPredicate = (predicate) ->
  if predicate == Any
    ->
      arguments.length == 1
  else
    predicate

bakePredicates = (predicates) ->
  switch (typeof predicates)
    when 'function' then bakeFunctionPredicate predicates
    else patterns.NoMatch


module.exports = patterns
