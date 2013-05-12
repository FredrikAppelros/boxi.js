global = exports ? this

counter = 0

class global.Entity
    constructor: (@x, @y) ->
        @id = counter
        counter++

    update: (state) ->
        @x = state.x
        @y = state.y

class global.SpriteEntity extends Entity
    constructor: (x, y, sprite) ->
        super(x, y)
        @sprite = sprite
        # TODO add visibility flag and sync with sprite

    update: (state) ->
        super(state)
        @sprite.position.x = state.x
        @sprite.position.y = state.y
        @sprite.rotation = state.a

