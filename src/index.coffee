
GPS    = require './gps'
gps    = new GPS
fs     = require 'fs'
Log    = require 'log'
log    = new Log 'info', fs.createWriteStream('my.log')
SX127x = require('sx127x')
sx127x = new SX127x({
    frequency: 915e6
    resetPin: 24
    dio0Pin: 25
  })

gpsData = ''

gps.onData (data) ->
  gpsData = data
  log.info data

sx127x.open (err) ->
  console.log 'open', if err then err else 'success'
  throw err if err?

  setInterval (->
    console.log { gpsData }
    sx127x.write new Buffer(gpsData), (err) ->
      console.log '\u0009', if err then err else 'success'
      return
    return
  ), 3000

process.on 'SIGINT', ->
  sx127x.close (err) ->
    console.log 'close', if err then err else 'success'
    process.exit()
