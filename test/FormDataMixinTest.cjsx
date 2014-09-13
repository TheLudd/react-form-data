# @cjsx React.DOM
React = require 'react/addons'
TestUtils = React.addons.TestUtils
should = require 'should'

describe 'ReactFormMixin', ->

  form = React.createClass
    componentWillMount: -> @formData = {}
    handleChange: (e) ->
      t = e.target
      key = t.getAttribute 'name'
      val = t.value
      @.formData[key] = val
    render: ->
      <form id="f" method="post" onChange={@handleChange}>
        <input ref="textInput" name="firstName" defaultValue="" />
        <textarea ref="textarea" name="description" defaultValue=""></textarea> 
      </form>
  component = TestUtils.renderIntoDocument form()

  testEditableField = (ref, name, newVal) ->
    editable = component.refs[ref].getDOMNode()
    editable.value = newVal
    TestUtils.Simulate.change editable
    component.formData[name].should.equal newVal

  it 'map text input name to value upon change', ->
    testEditableField 'textInput', 'firstName', 'Agamemnon'

  it 'should map textarea input name to input value', ->
    testEditableField 'textarea', 'description', 'this is a description'
