raspi  = require 'raspi-io'
five   = require 'johnny-five'
_      = require 'lodash'

class GPS
  constructor: () ->
    @gpsHandlers = []
    board = new five.Board({
      io: new raspi({ includePins: ['P1-8', 'P1-10'] })
    })

    board.on 'ready', () =>
      gps = new five.GPS({
        pins: ['P1-8', 'P1-10']
      })

      gps.on 'data', @handleGps

  onData: (fn) =>
    @gpsHandlers.push fn

  handleGps: (data) =>
    { latitude, longitude, altitude, speed, time } = data
    time = parseFloat time
    gpsData = "[#{latitude},#{longitude},#{altitude},#{speed},#{time}]"

    _.each @gpsHandlers, (handler) => handler(gpsData)

module.exports = GPS
