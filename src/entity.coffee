global = exports ? this

counter = 0

class global.Entity
    ###
    Top-level class for all entities.
    ###
    constructor: (@x, @y) ->
        ###
        Parameters
        ----------
        - `x` : the X-coordinate of the entity
        - `y` : the Y-coordinate of the entity
        ###
        @id = counter
        counter++

    update: (state) ->
        ###
        Updates the state of the entity.

        Parameters
        ----------
        - `state` : the state of the entity on the form: `{x, y}`
        ###
        @x = state.x
        @y = state.y

class global.PhysicalEntity extends Entity
    ###
    Class for all entities with a physical presence. This means that
    the entity can either be seen, felt or both.
    ###
    constructor: (x, y, @sprite, @body) ->
        ###
        Parameters
        ----------
        - `x` : the X-coordinate of the entity
        - `y` : the Y-coordinate of the entity
        - `sprite` : the sprite associated with the entity
        - `body` : the body associated with the entity
        ###
        super(x, y)
        @body.SetUserData(this) if @body?
        # TODO add visibility flag and sync with sprite

    update: (state) ->
        ###
        Updates the state of the entity.

        Parameters
        ----------
        - `state` : the state of the entity on the form:
            `{x, y, a}`
        ###
        super(state)
        if @sprite?
            @sprite.position.x = state.x
            @sprite.position.y = state.y
            @sprite.rotation = state.a

