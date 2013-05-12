global = exports ? this

class global.GraphicsEngine
    constructor: (id) ->
        # Create a renderer
        canvas = document.querySelector("##{id}")
        @renderer = PIXI.autoDetectRenderer(canvas.width, canvas.height, canvas)

        # Create a texture cache
        @textures = {}

        # Build the stage
        @stage = new PIXI.Stage

    drawFrame: ->
        @renderer.render(@stage)

    createSprite: (img) ->
        @textures[img.path] = PIXI.Texture.fromImage(img.path) unless @textures[img.path]
        sprite = new PIXI.Sprite(@textures[img.path])
        sprite.anchor.x = sprite.anchor.y = 0.5
        @stage.addChild(sprite)
        return sprite

