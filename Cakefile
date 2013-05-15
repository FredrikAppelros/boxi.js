{exec} = require 'child_process'

task 'build', 'Compiles the project', ->
    exec 'coffee
        --compile
        --join js/boxi.dev.js
        src/', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr

task 'minify', 'Minimizes the code', ->
    exec 'closure
        --compilation_level SIMPLE_OPTIMIZATIONS
        --js js/boxi.dev.js
        --js_output_file js/boxi.js', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr

task 'doc', 'Build the documentation for the project', ->
    exec 'coffeedoc
        --output doc/
        --renderer gfm
        --hide-private
        src/', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr

task 'clean', 'Removes generated files', ->
    exec 'rm -r js/ doc/', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
