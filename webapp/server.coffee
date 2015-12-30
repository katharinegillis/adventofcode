# @file
# @author katharinegillis
# @date   12/24/15
# @brief  Configure the server and start it.

# Module dependencies.
fs      = require 'fs'
join    = require('path').join
express = require 'express'
Promise = require 'bluebird'

config  = require './config/config'

# Create the server.
app = express();
port = process.env.PORT or 3000

# Bootstrap the models.
models = {}
for file in fs.readdirSync(join(__dirname, 'models'))
  if file.indexOf('.coffee') isnt -1
    model = require(join(__dirname, 'models', file))(app)
    Promise.promisifyAll model
    models[model.name] = model
app.set 'models', models

# Bootstrap the application settings.
require('./config/express')(app)

# Bootstrap the routes.
require('./config/routes')(app)

# Start the server.
app.listen port
console.log 'Express app started on ' + port

# Expose the module.
module.exports = app