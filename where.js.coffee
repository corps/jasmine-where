beforeEach ->
  alreadyDefined = []
  suite = @suite
  while suite?
    if suite.wheres_?
      for symbol of suite.wheres_
        continue if symbol in alreadyDefined
        alreadyDefined.push(symbol)
        ((suite, symbol) =>
          f = => suite.wheres_[symbol].apply(this)
          Object.defineProperty this, symbol,
            get: ->
              tap f(), (v) ->
                f = -> v
            set: (v) ->
              f = -> v
        )(suite, symbol)
    suite = suite.parentSuite

window.where = where = (symbol, definition) ->
  s = jasmine.getEnv().currentSuite
  throw "Where called outside of a declaring suite!" unless s?
  s.wheres_ = s.wheres_ || {}
  s.wheres_[symbol] = -> definition.apply(this)

window.subject = (f) -> where "subject", f
