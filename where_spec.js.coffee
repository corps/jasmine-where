describe "when where is called inside a describe block", ->
  where "a", -> 1
  beforeEach ->
    @beforeValue = @a

  it "a spec and beforeEach level property is defined whose reference returns the value returned by the given block", ->
    expect(@a).toEqual(1)
    expect(@beforeValue).toEqual(1)

  it "a spec and beforeEach level property is defined that when set with = is overriden with that value", ->
    @a = 5
    expect(@a).toEqual(5)
    expect(@beforeValue).toEqual(1)

  describe "containing chained symbols relating in an order different than their definition", ->
    where "b", -> @c + 1
    where "c", -> 2

    it "expectation blocks understand their relationship and gives the expected value", ->
      expect(@b).toEqual(3)

    it "expectation blocks use the value defined at the top level for the unoverrided value", ->
      expect(@a).toEqual(1)
      expect(@beforeValue).toEqual(1)

  describe "referring to a symbol defined by a where at a higher level than the current suite", ->
    where "b", -> @a + 5

    it "expectation blocks use the definition given by the where in that ancestor suite", ->
      expect(@b).toEqual(6)

  describe "overriding a symbol defined by another where in a higher level suite", ->
    where "a", -> 2

    it "expectation blocks and all levels of beforeEach blocks use the overriding value", ->
      expect(@a).toEqual(2)
      expect(@beforeValue).toEqual(2)

  describe "and the symbol defined by that where is not referred to", ->
    where "someVal", -> @called = true

    it "the given definition block is not called", ->
      expect(@called).not.toEqual(true)

  describe "referred to inside a expectation block", ->
    where "someVal", -> @count = (@count || 0) + 1; "b"

    it "has its block called only once and that returned value cached for subsequent references", ->
      expect(@someVal).toEqual("b")
      expect(@someVal).toEqual("b")
      expect(@someVal).toEqual("b")
      expect(@count).toEqual(1)

  describe "and refers to a spec's member variable", ->
    where "d", -> @specVal + 2
    it "uses the currently running Spec as this for determining that member's value", ->
      @specVal = 97
      expect(@d).toEqual(99)

