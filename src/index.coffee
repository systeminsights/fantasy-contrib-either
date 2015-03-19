R = require 'ramda'
{Left, Right} = require 'fantasy-eithers'
{Some, None} = require 'fantasy-options'

# :: (b -> Boolean) -> Either a b -> Boolean
#
# Returns whether the either is a Right value satisfying the predicate.
#
exists = R.curry((p, e) ->
  e.fold(R.always(false), p))

# :: (b -> Boolean) -> Either a b -> Boolean
#
# Returns true if the either is Left or if the Right value satisfies the predicate.
#
forall = R.curry((p, e) ->
  e.fold(R.always(true), p))

# :: (b -> ()) -> Either a b -> ()
#
# Run the side-effect on the right side of the Either
#
foreach = R.curry((f, e) ->
  rightMap(f, e)
  undefined)

# :: (() -> a) -> Either Error a
#
# Run the given function, returning values on the Right, catching exceptions
# and returning them on the Left.
#
fromTryCatch = (f) ->
  try
    Right(f())
  catch e
    Left(e)

# :: b -> Either a b -> b
#
# Return the Right value of this either or the given value if Left.
#
getOrElse = R.curry((b, e) ->
  valueOr(R.always(b), e))

# :: Either a b -> Boolean
#
# Returns whether the Either is a Left
#
isLeft = (e) ->
  e.fold(R.always(true), R.always(false))

# :: Either a b -> Boolean
#
# Returns whether the Either is a Right
#
isRight = (e) ->
  e.fold(R.always(false), R.always(true))

# :: (a -> c) -> Either a b -> Either c b
leftMap = R.curry((f, e) ->
  e.bimap(f, R.identity))

# :: (b -> c) -> Either a b -> Either a c
rightMap = R.curry((f, e) ->
  e.bimap(R.identity, f))

# :: Either a b -> [b]
#
# Return an empty array when Left or a singleton array if Right.
toArray = (e) ->
  e.fold(R.always([]), R.of)

# :: Either a b -> Option b
#
# Return None if the Either is Left or Some(b) if it is Right.
#
toOption = (e) ->
  e.fold(R.always(None), Some)

# :: (a -> b) -> Either a b -> b
#
# Return the Right value of this either or run the given function on the Left.
#
valueOr = R.curry((f, e) ->
  e.fold(f, R.identity))

module.exports = {
  exists,
  forall,
  foreach,
  fromTryCatch,
  getOrElse,
  isLeft,
  isRight,
  leftMap,
  rightMap,
  toArray,
  toOption,
  valueOr
}

