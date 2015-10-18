###
luftzug\jspatterns

Licensed under the MIT license
For full copyright and license information, please see the LICENSE file

@author     Yoav Luft <yoav.luft@gmail.com>
@copyright  2015 Yoav Luft
@link       
@license    http://choosealicense.com/licenses/MIT  MIT License
###

should = require 'should'
patterns = require '../src/jspatterns'


describe 'Function guard predicate', () ->

  describe '#guard', () ->

    it 'should return a wrapped function', () ->

      fn = () ->
        'result'
      wrapped = patterns.guard (() -> true), fn
      wrapped.should.be.a.Function()

      res = wrapped()
      res.should.match 'result'

    it 'should run function only if predicate is true', () ->
      fn = patterns.guard ((a) -> a == 1), ((a) -> a + 2)
      res = fn 1
      res.should.equal 3

    it 'should return the NoMatch object if predicate is false', () ->
      fn = patterns.guard ((a) -> a == 1), ((a) -> a + 2)
      res = fn 2
      res.should.equal patterns.NoMatch

    it 'should return NoMatch if wrong number of arguments', () ->
      fn = patterns.guard ((a) -> a == 1), ((a) -> a + 2)
      res = fn()
      res.should.equal patterns.NoMatch
      res = fn 1, 'hello'
      res.should.equal patterns.NoMatch

    it 'should use Any to accept any argument (but not undefined)', () ->
      fn = patterns.guard patterns.Any, ((x) -> x + ' mmmkay')
      res = fn 1
      res.should.equal '1 mmmkay'
      res = fn()
      res.should.equal patterns.NoMatch
      res = fn 1, 'hello'
      res.should.equal patterns.NoMatch

    it 'should match '
