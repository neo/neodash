class Dashing.Interestings extends Dashing.Widget
  refresh: ->
    interestings = @get('interestings')

    if interestings
      $el = $(this.node)
      $el.find('#nothing').remove()

      ol = $el.find('#interestings')
      ol.empty()
      ol.append interestings

  ready: ->
    @refresh()

  onData: (data) ->
    if data.interesting == 'clear'
      @set('interestings', undefined)

      $el = $(this.node)
      $el.append "<p id='nothing'>Nothing to see here.</p>"

      ol = $el.find('#interestings')
      ol.empty()

    else
      interestings = @get('interestings')
      if interestings
        interestings += '<li>' + data.interesting + '</li>'
      else
        interestings  = '<li>' + data.interesting + '</li>'

      @set('interestings', interestings)

      @refresh()
