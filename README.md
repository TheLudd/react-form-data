# react-form-data
React form data is a React mixin that will allow you to get data from an html form in a nice javascript object format. 
## installation
```bash
npm i react-form-data -S
```
or if you prefer the verbose format:
```bash
npm install react-form-data --save
```

## usage
  1. Create a component containing form elements.
  2. Add the form data mixin to the component
  3. On an element wrapping all input elements, bind the ```onChange``` handler to ```this.updateFormData```
  4. You will now have access to the form data by accessing ```this.formData```

### example
```
var React = require('react');
var FormData = require('react-form-data');
var MyForm = React.createClass({
  mixins: [ FormData ],
  handleSubmit: function() {
     var url = 'urlToSendDataTo';
     myRequestLib.post(url, this.formData);
  },
  render: function() {
    return (
      <form onChange={this.updateFormData} onSubmit={this.handleSubmit}>
          //input elements
      </form>
    )
  }
});
```
## input elements
Formdata supports ```input```, ```textarea``` and ```select``` elements. The name of an element is used as key in the created object and the value is fetched form the entered text, the selected ```option``` element or the defined ```value``` on the checked radio button.

### checkboxes
Checkboxes can be used in two different ways.
  1. A single checkbox can tie ```true``` or ```faslse``` to its key.
  2. Several checkboxes can be used to tie an array of values to the same key.

To use case 1, don't give the checkbox a value:
```
  <input type="checkbox" name="acceptTerms" />
```
```this.formData.acceptTerms``` will be true or false depending on if the checkbox is checked or not.

To use case 2, create several checkboxes with the same name but different values:
```
  <input type="checkbox" name="skills" value="javascript" />
  <input type="checkbox" name="skills" value="coffeescript" />
  <input type="checkbox" name="skills" value="haskell" />
```
```this.formData.skills``` will be an array of the checked values. E.g. ```[ 'javascript', 'coffeescript' ]```
## methods
When adding the mixin to your component, these methods will be available on it:
### getInitialFormData()
Implement this method to let ```this.formData``` be a non empty object in its initial state. Useful when you want to edit an existing entity. Any changes to the form will be added to this object.
### formDataDidChange(formData)
Called whenever there is a change to the form. The argument is the form data object as it is after the change was made.

## demo
This repository contains a demo. To run it, clone the repo and execute ```npm run demo```. You can now view the demo by visiting [http://localhost:3000](http://localhost:3000)
