{Left, Right} = require 'fantasy-eithers'
{fromTryCatch} = require '../src/index'

describe "fromTryCatch", ->
  it "should return values on the right", ->
    expect(fromTryCatch((-> "A"))).to.eql(Right("A"))

  it "should catch exceptions and return them on the left", ->
    err = new Error("ATTEMPT")
    expect(fromTryCatch((-> throw err))).to.eql(Left(err))

