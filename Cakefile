{exec} = require 'child_process'

task 'build', 'Builds the project', ->
    exec 'coffee --compile --join js/boxi.js src/', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
