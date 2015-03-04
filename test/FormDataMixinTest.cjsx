# @cjsx React.DOM
TestUtils = require('react/addons').addons.TestUtils
TestForm = require './TestForm.cjsx'
should = require 'should'

describe 'ReactFormMixin', ->

  component = null

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

  it 'should allow manual setting of values', ->
    component.setFormData 'foo', 'bar'
    component.formData.foo.should.equal 'bar'

  it 'should allow clearing of values', ->
    component.clearFormData()
    component.formData.should.eql {}

  it 'should ignore input fields without name', ->
    noName = component.refs.noName.getDOMNode()
    noName.value = 'foo'
    TestUtils.Simulate.change noName
    component.formData.should.eql { disagree: true }

