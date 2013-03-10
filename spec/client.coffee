jscov = require 'jscov'
should = require 'should'
client = require(jscov.cover('..', 'lib', 'client'))
config = require('../config/config.json')

describe 'construct', ->

  it "should return an error if given an invalid endpoint", (done) ->
    c = client.construct({ endpoint: 'foobar' })
    c 'authPassword', {
      app: 'locke'
      email: config.username
      password: 'apa'
      secondsToLive: 10
    }, (err, data) ->
      err.should.eql new Error()
      done()

  it "should return an error if given an invalid endpoint", (done) ->
    c = client.construct({ endpoint: config.locke })
    c 'authPassword', {
      app: 'locke'
      email: config.username
      password: 'apa'
      secondsToLive: 10
    }, (err, data) ->
      err.should.eql new Error()
      err.message.should.eql 'Incorrect password'
      done()

  it "should return some data if given a valid endpoint", (done) ->
    c = client.construct({ endpoint: config.locke })
    c 'authPassword', {
      app: 'locke'
      email: config.username
      password: config.password
      secondsToLive: 10
    }, (err, data) ->
      should.not.exist err
      Object.keys(data).should.eql ['token', 'validated']
      done()
