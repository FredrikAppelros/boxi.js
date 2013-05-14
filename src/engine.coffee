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
        canvas.addEventListener('touchend', (event) => @onTouchEnd(event))
        canvas.addEventListener('touchmove', (event) => @onTouchMove(event))
        canvas.addEventListener('touchstart', (event) => @onTouchStart(event))
        # Disable context menu
        canvas.addEventListener('contextmenu', (event) -> event.preventDefault())

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

    createEntity: (pos, img, bodyParams) ->
        # Create backend objects
        if img?
            sprite = @graphics.createSprite(img)
        if bodyParams?
            body = @physics.createBody(pos, bodyParams)

        # Create the entity
        if sprite? or body?
            entity = new PhysicalEntity(pos.x, pos.y, sprite, body)
        else
            entity = new Entity(pos.x, pos.y)

        @entities[entity.id] = entity
        return entity.id

    removeEntity: (id) ->
        entity = @entities[id]
        @physics.removeBody(entity.body) if entity.body?
        @graphics.removeSprite(entity.sprite) if entity.sprite?
        delete @entities[id]

    logic: ->
    onKeyDown: (event) ->
    onKeyUp: (event) ->
    onMouseDown: (event) ->
    onMouseMove: (event) ->
    onMouseUp: (event) ->
    onTouchEnd: (event) ->
    onTouchMove: (event) ->
    onTouchStart: (event) ->

