http = require 'http'
browserify = require 'browserify'

html = '''
<html>
  <head>
  </head>
  <body onload="init()">
    Browserifying. Hold on...
    <script src="/js"></script>
  </body>
</html>
'''

http.Server (req, res) ->
  if req.url == '/js'
    b = browserify()
    b.add __dirname + '/app.coffee'
    b.transform 'coffee-reactify'
    b.bundle (e, out) ->
      console.log e if e?
      res.setHeader 'Content-Type', 'application/javascript'
      res.end out
  else
    res.end html
.listen 3000, (e) ->
  if e?
    console.err e
  else
    console.log 'Demo server running on port 3000'
