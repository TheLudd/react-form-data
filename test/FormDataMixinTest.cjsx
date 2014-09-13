# @cjsx React.DOM
React = require 'react/addons'
TestUtils = React.addons.TestUtils
FormDataMixin = require '../lib/FormDataMixin.coffee'
should = require 'should'

describe 'ReactFormMixin', ->

  form = React.createClass
    mixins: [ FormDataMixin ]
    render: ->
      <form id="f" method="post" onChange={@updateFormData}>
        <input ref="textInput" name="firstName" defaultValue="" />
        <textarea ref="textarea" name="description" defaultValue=""></textarea> 
        <select ref="select" name="qty" defaultValue="">
          <option value="">---</option>
          <option ref="o1" value="1">One</option>
          <option ref="o2" value="2">Two</option>
          <option ref="o3" value="3">Three</option>
        </select>
        <input type="checkbox" name="agree" ref="agree" />
        <input type="checkbox" name="disagree" ref="disagree" defaultChecked={true} />
      </form>
  component = TestUtils.renderIntoDocument form()

  testEditableField = (ref, name, newVal) ->
    editable = component.refs[ref].getDOMNode()
    editable.value = newVal
    TestUtils.Simulate.change editable
    component.formData[name].should.equal newVal

  testCheckbox = (refAndName, expectedVal) ->
    checkbox = component.refs[refAndName].getDOMNode()
    checkbox.checked = !checkbox.checked
    TestUtils.Simulate.change checkbox
    component.formData[refAndName].should.equal expectedVal

  it 'map text input name to value upon change', ->
    testEditableField 'textInput', 'firstName', 'Agamemnon'

  it 'should map textarea input name to input value', ->
    testEditableField 'textarea', 'description', 'this is a description'

  it 'should map select name to option value when option is selected', ->
    testEditableField 'select', 'qty', '2'

  it 'should map the name to true for a checked checkbox without value', ->
    testCheckbox 'agree', true

  it 'should map the name to false for an unchecked checkbox without value', ->
    testCheckbox 'disagree', false
