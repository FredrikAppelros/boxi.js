global = exports ? this

class global.GameEngine
    constructor: (id, gravity) ->
        @graphics = new GraphicsEngine(id)
        @physics = new PhysicsEngine(gravity)
        @entities = {}

    start: ->
        window.requestAnimationFrame(=> @run())

    run: ->
        # Perform game logic
        @logic()

        # Simulate physics
        @physics.simulate()

        # Render graphics
        @graphics.drawFrame()

        # Request next frame
        window.requestAnimationFrame(=> @run())

    logic: ->

    createEntity: (pos, img, body) ->
        if img?
            sprite = @graphics.createSprite(img)
            entity = new SpriteEntity(pos.x, pos.y, sprite)
        else
            entity = new Entity(pos.x, pos.y)
        @entities[entity.id] = entity
        @physics.createBody(pos, body, entity) if body?

