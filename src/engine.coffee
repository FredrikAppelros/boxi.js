global = exports ? this

class global.GameEngine
    constructor: (id, gravity) ->
        body    = document.querySelector('body')
        canvas  = document.querySelector("##{id}")
        @graphics   = new GraphicsEngine(canvas)
        @physics    = new PhysicsEngine(gravity)
        @entities   = {}
        # TODO add visibleEntities and populate with entities that are
        # within view and visible

        # Add event handlers
        body.addEventListener('keydown', (event) => @onKeyDown(event))
        body.addEventListener('keyup', (event) => @onKeyUp(event))
        canvas.addEventListener('mousedown', (event) => @onMouseDown(event))
        canvas.addEventListener('mousemove', (event) => @onMouseMove(event))
        canvas.addEventListener('mouseup', (event) => @onMouseUp(event))

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

    createEntity: (pos, img, body) ->
        if img?
            sprite = @graphics.createSprite(img)
            entity = new SpriteEntity(pos.x, pos.y, sprite)
        else
            entity = new Entity(pos.x, pos.y)
        @entities[entity.id] = entity
        @physics.createBody(pos, body, entity) if body?

    logic: ->
    onKeyDown: (event) ->
    onKeyUp: (event) ->
    onMouseDown: (event) ->
    onMouseMove: (event) ->
    onMouseUp: (event) ->

