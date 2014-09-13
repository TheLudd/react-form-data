getValue = (el) ->
  el.value

module.exports =
  componentWillMount: -> @formData = {}
  updateFormData: (e) ->
    t = e.target
    key = t.getAttribute 'name'
    unless t.getAttribute('type') == 'checkbox'
      val = getValue t
    else
      val = t.checked
    @.formData[key] = val
