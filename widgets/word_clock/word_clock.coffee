class Dashing.WordClock extends Dashing.Widget
  startClock: ->
    for location in @locations
      date = new timezoneJS.Date(new Date(), location.zone)
      location.time = [date.getHours(), date.getMinutes(), date.getSeconds()].map (n)->
        ('0' + n).slice(-2)
      .join(':')
      minutes = 60 * date.getHours() + date.getMinutes()
      totalWidth = document.querySelector('.hours').clientWidth - 1
      offset = (minutes / (24.0 * 60)) * totalWidth

      clock = document.querySelector("." + location.display_location)
      if(clock)
        ['-webkit-transform', '-moz-transform', '-o-transform', '-ms-transform', 'transform'].forEach (vendor) ->
          clock.style[vendor] = "translateX(" + offset + "px)"

          if(location.primary)
            @set('time', location.time)
        , @

    setTimeout @startClock.bind(@), 1000

  setupHours: ->
    hours = []
    for h in [0..23]
      do (h) ->
        hours[h] = {}
        hours[h].dark = h< 7 || h>= 19
        hours[h].name = if h == 12 then h else h%12
    @set('hours', hours)

  ready: ->
    @setupHours()
    @startClock()
