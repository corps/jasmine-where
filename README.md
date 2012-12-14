jasmine-where
=============

    describe "containing chained symbols relating in an order different than their definition", ->
      where "b", -> @c + 1
      where "c", -> 2

      it "expectation blocks understand their relationship and gives the expected value", ->
        expect(@b).toEqual(3)

A let like constructor and tools for writing nice looking coffeescript jasmine tests.

See the where_spec.js.coffee for details, but the gist of where behaviors is as so:

* Their value is accessible as an attribute on the currentSpec object.  This includes the clauses it, where, and beforeEach.
* Unlike beforeEach, *they are not called until they are first acccessed*, and even then *only the closest defined function is executed to determine its value*.
* Their value is determined from a function, and then memoized.
* You can chain them together in any order, without worrying about their dependent declarations.
* You can overwrite their values manually anytime.
