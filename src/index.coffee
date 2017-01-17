raspi  = require 'raspi-io'
five   = require 'johnny-five'
SX127x = require('sx127x')
sx127x = new SX127x({
    frequency: 915e6
    resetPin: 24
    dio0Pin: 25
  })

board = new five.Board({
  io: new raspi({ includePins: ['P1-8', 'P1-10']})
})

gpsData  = ""

board.on 'ready', () ->
  gps = new five.GPS({
    pins: ['P1-8', 'P1-10']
  })

  gps.on 'data', (data) ->
    { latitude, longitude, altitude, speed, time } = data
    gpsData = "lat:#{latitude},lon:#{longitude},a:#{altitude},s:#{speed},t:#{time}\r\n"

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
