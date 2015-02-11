class Dashing.Xkcd extends Dashing.Widget

    refreshImage: ->
        $el = $(this.node)

        # Remove the old image
        $el.find('img').remove()

        # Load the new image
        image_url = @get("comic_image")
        $img = $('<img src=' + image_url + '/>')
        $el.append $img

    ready: ->
        @refreshImage()

    onData: (data) ->
        @set("comic_title", data.title)
        @set("comic_image", data.image)
        @refreshImage()
