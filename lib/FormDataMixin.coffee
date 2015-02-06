isCheckbox = (el) -> el.getAttribute('type') == 'checkbox'

isMultiChoice = (checkbox) -> checkbox.getAttribute('value')?

toggleValue = (arr, val) ->
  valueIndex = arr.indexOf val
  if valueIndex != -1 then arr.splice valueIndex, 1 else arr.push val
  return arr

getValue = (el, currentValue) ->
  unless isCheckbox el
    return el.value
  else
    if isMultiChoice el
      currentValue ?= []
      return toggleValue currentValue, el.value
    else
      return el.checked

module.exports =

  componentWillMount: ->
    if @getInitialFormData?
      @formData = @getInitialFormData()
    else
      @formData = {}

  updateFormData: (e) ->
    t = e.target
    key = t.getAttribute 'name'
    @formData[key] = getValue t, @.formData[key]
    @formDataDidChange() if @formDataDidChange?

  setFormData: (key, value) ->
    @formData[key] = value

  clearFormData: -> @formData = {}
