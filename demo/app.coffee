React = require 'react'
Form = require '../test/TestForm.cjsx'

window.init = -> React.renderComponent <Form />, document.body

