global = exports ? this

# Simplify namespace
b2Vec2 = Box2D.Common.Math.b2Vec2
b2World = Box2D.Dynamics.b2World
b2Body = Box2D.Dynamics.b2Body
b2FixtureDef = Box2D.Dynamics.b2FixtureDef
b2BodyDef = Box2D.Dynamics.b2BodyDef
b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape

INTERVAL    = 1 / 60
SCALE       = 30

class global.PhysicsEngine
    constructor: (gravity) ->
        ###
        Parameters
        ----------
        - `gravity` : a gravity vector on the form: `{x, y}`
        ###
        @world = new b2World(new b2Vec2(gravity.x, gravity.y), true)

    simulate: ->
        ###
        Simulates a single step.
        ###
        # Perform simulation
        @world.Step(INTERVAL, 8, 3)
        @world.ClearForces()

        # Update entities
        b = @world.GetBodyList()
        loop
            break unless b?
            entity = b.GetUserData()
            if entity? and b.IsAwake()
                state = {
                    x: b.GetPosition().x * SCALE,
                    y: b.GetPosition().y * SCALE,
                    a: b.GetAngle()
                }
                entity.update(state)
            b = b.GetNext()

    createBody: (pos, bodyParams) ->
        ###
        Creates a body object.

        Parameters
        ----------
        - `pos` : a position on the form: `{x, y}`
        - `bodyParams` : parameters for the BodyDef on the form:
            `{dyn, w, h, d, f, r}`

        Returns
        -------
        - `body` : the body object
        ###
        fixDef = new b2FixtureDef
        bodyDef = new b2BodyDef
        fixDef.shape = new b2PolygonShape
        fixDef.shape.SetAsBox(0.5 * bodyParams.w / SCALE, 0.5 * bodyParams.h / SCALE)
        fixDef.density = bodyParams.d
        fixDef.friction = bodyParams.f
        fixDef.restitution = bodyParams.r
        bodyDef.type = if bodyParams.dyn then b2Body.b2_dynamicBody else b2Body.b2_staticBody
        bodyDef.position.x = pos.x / SCALE
        bodyDef.position.y = pos.y / SCALE
        body = @world.CreateBody(bodyDef)
        body.CreateFixture(fixDef)
        return body

    removeBody: (body) ->
        ###
        Removes a body object.

        Parameters
        ----------
        - `body` : the body to remove
        ###
        @world.DestroyBody(body)

