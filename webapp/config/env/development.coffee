# @file
# @author katharinegillis
# @date   12/24/15
# @brief  Development environment configuration.

# Module dependencies
fs     = require 'fs'
join   = require('path').join
winston = require 'winston'

# Adjust the environment based on values in the env.json file.
env = {}
envFile = join __dirname, 'env.json'

if fs.existsSync envFile
  env = fs.readFileSync envFile, 'utf-8'
  env = JSON.parse env
  for key, value of env
    process.env[key] = value

config = {}

# Expose the module.
module.exports = config