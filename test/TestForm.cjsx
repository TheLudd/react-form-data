React = require 'react/addons'
FormDataMixin = require '../lib/FormDataMixin.coffee'

TestForm = React.createClass
  mixins: [ FormDataMixin ]
  render: ->
    <form method="post" onChange={@updateFormData}>
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

module.exports = TestForm
