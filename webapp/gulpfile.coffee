# @file
# @author katharinegillis
# @date   12/30/15
# @brief  Defines the gulp build tasks.

gulp         = require 'gulp'
gutil        = require 'gulp-util'
gulpif       = require 'gulp-if'
streamify    = require 'gulp-streamify'
autoprefixer = require 'gulp-autoprefixer'
cssmin       = require 'gulp-cssmin'
less         = require 'gulp-less'
concat       = require 'gulp-concat'
plumber      = require 'gulp-plumber'
source       = require 'vinyl-source-stream'
browserify   = require 'browserify'
watchify     = require 'watchify'
uglify       = require 'gulp-uglify'
envify       = require 'envify/custom'
fs           = require 'fs'
join         = require('path').join

process.env.NODE_ENV = process.env.NODE_ENV or 'development'

# Load up the environmental variables for the dev environment.
if process.env.NODE_ENV is 'development'
	envFile = join __dirname, 'config/env/env.json'

	if fs.existsSync envFile
		env = fs.readFileSync envFile, 'utf-8'
		env = JSON.parse env
		for key, value of env
			process.env[key] = value

# Determine whether or not this is the production environment.
production = process.env.NODE_ENV is 'production'

# List out the browser app dependencies.
dependencies = [
]

# Compile the third-party JS libraries into a single file.
gulp.task 'vendor', () ->
	return gulp.src [
		'bower_components/jquery/dist/jquery.js'
	]
	.pipe concat('vendor.js')
	.pipe gulpif(production, uglify(mangle: false))
	.pipe gulp.dest('public/js')

# Bundle and minify the third-party JS libraries for faster performance.
gulp.task 'browserify-vendor', () ->
	return browserify()
		.require dependencies
		.bundle()
		.pipe source('vendor.bundle.js')
		.pipe gulpif(production, streamify(uglify(mangle: false)))
		.pipe gulp.dest('public/js')

# Compile the project files.
gulp.task 'browserify', ['browserify-vendor'], () ->
	return browserify 'app/main.cjsx'
		.external dependencies
		.transform 'coffee-reactify'
		.transform envify(
			_: 'purge'
			NODE_ENV: process.env.NODE_ENV,
			BASE_URL: process.env.BASE_URL
		)
		.bundle()
		.pipe source('bundle.js')
		.pipe gulpif(production, streamify(uglify(mangle: false)))
		.pipe gulp.dest('public/js')

# Compiles the project files and watches for changes and recompiles when changes happen.
gulp.task 'browserify-watch', ['browserify-vendor'], () ->
	rebundle = () ->
		start = Date.now()
		return bundler.bundle()
		.on 'error', (err) ->
			gutil.log gutil.colors.red(err.toString())
		.on 'end', () ->
			gutil.log gutil.colors.green('Finished rebundling in', (Date.now() - start) + 'ms.')
		.pipe source('bundle.js')
		.pipe gulp.dest('public/js')

	bundler = watchify browserify('app/main.cjsx', watchify.args)
	bundler.external dependencies
	bundler.transform 'coffee-reactify'
	bundler.transform envify(
		_: 'purge'
		NODE_ENV: process.env.NODE_ENV,
		BASE_URL: process.env.BASE_URL
	)
	bundler.on 'update', rebundle
	return rebundle()

# Compile the less stylesheets.
gulp.task 'styles', () ->
	return gulp.src 'app/stylesheets/main.less'
		.pipe plumber()
		.pipe less()
		.pipe autoprefixer()
		.pipe gulpif(production, cssmin())
		.pipe gulp.dest('public/css')

# Watch for changes in the less and recompile.
gulp.task 'watch', () ->
	gulp.watch 'app/stylesheets/**/*.less', ['styles']

# Compiled tasks.
gulp.task 'default', ['styles', 'vendor', 'browserify-watch', 'watch']
gulp.task 'build', ['styles', 'vendor', 'browserify']