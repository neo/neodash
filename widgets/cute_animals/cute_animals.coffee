class Dashing.CuteAnimals extends Dashing.Widget
    refreshCuteAnimals: (url)->
        $el = $(this.node)
        console.log(url)
        $('#cute-animal-img').attr "src", url

    ready: ->
        @refreshCuteAnimals('http://c1.staticflickr.com/9/8364/8428132309_7a9861845d.jpg')

    onData: (data) ->
        console.log(data.image_url)
        @refreshCuteAnimals(data.image_url)
