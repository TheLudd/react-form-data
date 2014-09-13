React = require 'react/addons'
FormDataMixin = require '../lib/FormDataMixin.coffee'

TestForm = React.createClass
  getInitialState: -> formData: disagree: true
  formDataDidChange: -> @setState formData: @formData
  mixins: [ FormDataMixin ]
  render: ->
    <div>
      <form method="post" onChange={@updateFormData}>
        First Name
        <input ref="textInput" name="firstName" defaultValue="" />
        <br/>
        Description
        <textarea ref="textarea" name="description" defaultValue=""></textarea> 
        <br/>
        Qty
        <select ref="select" name="qty" defaultValue="">
          <option value="">---</option>
          <option ref="o1" value="1">One</option>
          <option ref="o2" value="2">Two</option>
          <option ref="o3" value="3">Three</option>
        </select>
        <br/>
        Agree?
        <input type="checkbox" name="agree" ref="agree" />
        <br/>
        Disagree?
        <input type="checkbox" name="disagree" ref="disagree" defaultChecked={true} />
        <br/>
        What do you want?
        <br/>
        Money
        <input type="checkbox" name="want" ref="money" value="money" />
        Food
        <input type="checkbox" name="want" ref="food" value="food" />
        Love
        <input type="checkbox" name="want" ref="love" value="love" />
        <br/>
        Favourite color?
        Blue
        <input type="radio" name="favColor" ref="blue" value="blue" />
        Green
        <input type="radio" name="favColor" ref="green" value="green" />
      </form>
      <pre>{JSON.stringify(@state.formData, undefined, 2)}</pre>
    </div>

module.exports = TestForm
