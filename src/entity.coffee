global = exports ? this

counter = 0

class global.Entity
    constructor: (@x, @y) ->
        @id = counter
        counter++

    update: (state) ->
        @x = state.x
        @y = state.y

class global.PhysicalEntity extends Entity
    constructor: (x, y, @sprite, @body) ->
        super(x, y)
        @body.SetUserData(this) if @body?
        # TODO add visibility flag and sync with sprite

    update: (state) ->
        super(state)
        if @sprite?
            @sprite.position.x = state.x
            @sprite.position.y = state.y
            @sprite.rotation = state.a

