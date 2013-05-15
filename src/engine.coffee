global = exports ? this

class global.GameEngine
    constructor: (id, gravity) ->
        ###
        Parameters
        ----------
        - `id` : the id of the canvas
        - `gravity` : a gravity vector on the form: `{x, y}`
        ###
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
        ###
        Starts the game loop.
        ###
        window.requestAnimationFrame(=> @run())

    run: ->
        ###
        Main game loop.
        ###
        # Perform game logic
        @logic()

        # Simulate physics
        @physics.simulate()

        # Render graphics
        @graphics.drawFrame()

        # Request next frame
        window.requestAnimationFrame(=> @run())

    createEntity: (pos, img, bodyParams) ->
        ###
        Creates an entity object.

        Parameters
        ----------
        - `pos` : a position on the form: `{x, y}`
        - `img` : an image object on the form: `{path}`
        - `bodyParams` : parameters for the BodyDef on the form:
            `{dyn, w, h, d, f, r}`

        Returns
        -------
        - `id` : the id of the entity object
        ###
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
        ###
        Removes an entity object.

        Parameters
        ----------
        - `id` : the id of the entity to remove
        ###
        entity = @entities[id]
        @physics.removeBody(entity.body) if entity.body?
        @graphics.removeSprite(entity.sprite) if entity.sprite?
        delete @entities[id]

    logic: ->
        ###
        Performs game logic.
        ###
    onKeyDown: (event) ->
        ###
        Handles `keydown` events.

        Parameters
        ----------
        - `event` : the event
        ###
    onKeyUp: (event) ->
        ###
        Handles `keyup` events.

        Parameters
        ----------
        - `event` : the event
        ###
    onMouseDown: (event) ->
        ###
        Handles `mousedown` events.

        Parameters
        ----------
        - `event` : the event
        ###
    onMouseMove: (event) ->
        ###
        Handles `mousemove` events.

        Parameters
        ----------
        - `event` : the event
        ###
    onMouseUp: (event) ->
        ###
        Handles `mouseup` events.

        Parameters
        ----------
        - `event` : the event
        ###
    onTouchEnd: (event) ->
        ###
        Handles `touchend` events.

        Parameters
        ----------
        - `event` : the event
        ###
    onTouchMove: (event) ->
        ###
        Handles `touchmove` events.

        Parameters
        ----------
        - `event` : the event
        ###
    onTouchStart: (event) ->
        ###
        Handles `touchstart` events.

        Parameters
        ----------
        - `event` : the event
        ###

