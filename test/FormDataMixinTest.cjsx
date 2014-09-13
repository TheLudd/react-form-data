# @cjsx React.DOM
React = require 'react/addons'
TestUtils = React.addons.TestUtils
FormDataMixin = require '../lib/FormDataMixin.coffee'
should = require 'should'

describe 'ReactFormMixin', ->

  component = null

  TestForm = React.createClass
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
        <input type="checkbox" name="want" ref="money" value="money" />
        <input type="checkbox" name="want" ref="food" value="food" />
        <input type="checkbox" name="want" ref="love" value="love" />
        <input type="radio" name="favColor" ref="blue" value="blue" />
        <input type="radio" name="favColor" ref="green" value="green" />
      </form>

  beforeEach ->
    component = TestUtils.renderIntoDocument <TestForm />

  testEditableField = (ref, name, newVal) =>
    editable = component.refs[ref].getDOMNode()
    editable.value = newVal
    TestUtils.Simulate.change editable
    component.formData[name].should.equal newVal

  changeCheckable = (ref) =>
    checkbox = component.refs[ref].getDOMNode()
    checkbox.checked = !checkbox.checked
    TestUtils.Simulate.change checkbox

  testCheckable = (refAndName, expectedVal) =>
    changeCheckable refAndName
    component.formData[refAndName].should.equal expectedVal

  it 'map text input name to value upon change', ->
    testEditableField 'textInput', 'firstName', 'Agamemnon'

  it 'should map textarea input name to input value', ->
    testEditableField 'textarea', 'description', 'this is a description'

  it 'should map select name to option value when option is selected', ->
    testEditableField 'select', 'qty', '2'

  it 'should map the name to true for a checked checkbox without value', ->
    testCheckable 'agree', true

  it 'should map the name to false for an unchecked checkbox without value', ->
    testCheckable 'disagree', false

  it 'should add checkbox values to a list', ->
    changeCheckable 'money'
    component.formData.want.should.eql [ 'money' ]

  it 'should add multiple checkbox calues to a list', ->
    [ 'money', 'food' ].forEach changeCheckable
    component.formData.want.should.eql [ 'money', 'food' ]

  it 'should remove selected elements from the list', ->
    [ 'money', 'food', 'money' ].forEach changeCheckable
    component.formData.want.should.eql [ 'food' ]
      
  it 'should map name to value for selected radio', ->
    changeCheckable 'blue'
    component.formData.favColor.should.eql 'blue'

  it 'should change existing selected radio value', ->
    [ 'blue', 'green' ].forEach changeCheckable
    component.formData.favColor.should.eql 'green'

      
