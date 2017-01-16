raspi  = require 'raspi-io'
five   = require 'johnny-five'
SX127x = require('sx127x')

board = new five.Board({
  io: new raspi()
})

sx127x = new SX127x({
    frequency: 915e6
    resetPin: 24
    dio0Pin: 25
  })

count = 0
gpsData   = ""

board.on 'ready', () ->
  gps = new five.GPS({
    pins: {rx: 'P1-8', tx: 'P1-10'}
  })

  gps.on 'change', () ->
    console.log 'lat: ', @.latitude
    console.log 'lon: ', @.longitude
    gpsData = "lat:#{@.latitude}//lon:#{@.longitude}"

sx127x.open (err) ->
  console.log 'open', if err then err else 'success'
  throw err if err?

  setInterval (->
    console.log 'write: hello ' + count
    sx127x.write new Buffer(gpsData), (err) ->
      console.log '\u0009', if err then err else 'success'
      return
    return
  ), 1000

process.on 'SIGINT', ->
  sx127x.close (err) ->
    console.log 'close', if err then err else 'success'
    process.exit()
