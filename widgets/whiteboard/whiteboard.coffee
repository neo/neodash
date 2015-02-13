class Dashing.Whiteboard extends Dashing.Widget
    refreshWhiteboard: ->
        $el = $(this.node)
        content = @get("whiteboard-content")
        $el.find('div').html content

    ready: ->
        @refreshWhiteboard()

    onData: (data) ->
        @set("whiteboard-content", data.content)
        @refreshWhiteboard()
