# @file
# @author katharinegillis
# @date   12/30/15
# @brief  Defines the gulp build tasks.

gulp         = require 'gulp'
gutil        = require 'gulp-util'
gulpif       = require 'gulp-if'
steramify    = require 'gulp-streamify'
autoprefixer = require 'gulp-autoprefixer'
cssmin       = require 'gulp-cssmin'
less         = require 'gulp-less'
concat       = require 'gulp-concat'
plumber      = require 'gulp-plumber'
source       = require 'vinyl-source-stream'
coffee       = require 'gulp-coffee'
browserify   = require 'browserify'
watchify     = require 'watchify'
uglify       = require 'gulp-uglify'

# Determine whether or not this is the production environment.
production = process.env.NODE_ENV is 'production'

# List out the browser app dependencies.
dependencies = [
	'alt',
	'react',
	'react-dom',
	'react-router',
	'underscore'
]

# Compile the third-party JS libraries into a single file.
gulp.task 'vendor', () ->
	return gulp.src [
		'bower_components/jquery/dist/jquery.js'
	]
	.pipe concat('vendor.js')
	.pipe gulpif(production, uglify(mangle: false))
	.pipe gulp.dest('public/js')