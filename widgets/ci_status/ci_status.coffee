class Dashing.CiStatus extends Dashing.Widget
  # Expected data format:
  #
  # - title:       [string] display title
  # - logo:        [url:opt] path to background logo asset
  # - builds[]:
  #   - id:        [string] globally unique identifier (URI will do nicely)
  #   - success:   [boolean] successful build?
  #   - ongoing:   [boolean] is this still building?
  #   - timestamp: [integer] build start time in millis since epoch
  #   - duration:  [integer] build duration in millis
  #   - author:    [string:opt] author of latest changeset
  #   - comment:   [string:opt] comment of latest changeset

  ready: ->
    @_setNodeStatus(null)

  receiveData: (data) ->
    @_prepareBuildData(data.builds)
    @mixin(data)
    @_setNodeStatus(data.builds?[0])

  _prepareBuildData: (builds) ->
    for build in builds
      build.status =
        if build.ongoing then 'ongoing'
        else if build.success then 'success'
        else 'failure'

      build.author = @_extractAuthor(build.author)

      build.comment =
        if build.comment? then build.comment.split("\n")[0][0...50]
        else "(no changes)"

      build.duration_text =
        if build.ongoing then "(building...)"
        else "(built in #{@_duration(build.duration, 1)})"

  _setNodeStatus: (build) ->
    $(@node).removeClass('ongoing failure success')
    if build?
      $(@node).addClass(build.status)
      @set('updated', @_timeAgo(build.timestamp) + ' ago')
      @set('last_build', build)

  _timeAgo: (millis) ->
    @_duration(Date.now() - millis)

  _duration: (span, digits) ->
    SECOND = 1000
    MINUTE = 60 * SECOND
    HOUR   = 60 * MINUTE
    DAY    = 24 * HOUR

    if ((days = span / DAY) && days > 1)
      days.toFixed(digits) + 'd'
    else if ((hours = span/HOUR) && hours > 1)
      hours.toFixed(digits) + 'h'
    else if ((minutes = span/MINUTE) && minutes > 1)
      minutes.toFixed(digits) + 'm'
    else
      seconds = span/SECOND
      seconds.toFixed(digits) + 's'

  _extractAuthor: (author) ->
    return "" unless author

    if author.match(/^pair\+/)
      return author.replace(/^pair\+/, '').replace(/\@.*/,'').split('+').join(' & ')

    author
