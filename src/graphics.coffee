global = exports ? this

class global.GraphicsEngine
    constructor: (canvas) ->
        ###
        Parameters
        ----------
        - `canvas` : the canvas object
        ###
        # TODO add fullscreen support

        # Create a renderer
        @renderer = PIXI.autoDetectRenderer(canvas.width, canvas.height, canvas)

        # Create a texture cache
        @textures = {}

        # Build the stage
        @stage = new PIXI.Stage

    drawFrame: ->
        ###
        Renders a single frame.
        ###
        @renderer.render(@stage)

    createSprite: (img) ->
        ###
        Creates a sprite object.

        Parameters
        ----------
        - `img` : an image object on the form: `{path}`

        Returns
        -------
        - `sprite` : the sprite object
        ###
        @textures[img.path] = PIXI.Texture.fromImage(img.path) unless @textures[img.path]
        sprite = new PIXI.Sprite(@textures[img.path])
        sprite.anchor.x = sprite.anchor.y = 0.5
        @stage.addChild(sprite)
        return sprite

    removeSprite: (sprite) ->
        ###
        Removes a sprite object.

        Parameters
        ----------
        - `sprite` : the sprite to remove
        ###
        @stage.removeChild(sprite)

