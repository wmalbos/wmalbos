-- Affichage des traces consoles lors de l'execution de l'application
io.stdout:setvbuf('no')

local windowWidth, windowHeight = 0, 0

local gravity = 0.6

local window = {
    width = 0,
    height = 0,
}
-- Vaisseau
local lander = {
    x = 0,
    y = 0,
    radius = 270,
    vx = 0, -- Vélocité dans la direction x
    vy = 0, -- Vélocité dans la direction y
    engineOn = false,
    speed = 3,
    imgShip = love.graphics.newImage('images/ship.png'),
    imgEngine = love.graphics.newImage('images/engine.png'),
}

function love.load()

    -- Fenetre
    window.width = love.graphics.getWidth()
    window.height = love.graphics.getHeight()

    -- Position initiale du vaisseau
    lander.x = window.width / 2
    lander.y = window.height / 2
end

function love.update(dt)

    -- Application d'une gravité
    lander.vy = lander.vy + (gravity * dt)


    local radianRadius = math.rad(lander.radius)
    local force = {
        x = math.cos(radianRadius) * lander.speed * dt,
        y = math.sin(radianRadius) * lander.speed * dt,
    }


    if love.keyboard.isDown("up") then
        lander.engineOn = true

        if math.abs(force.x) < 0.001 then force.x = 0 end
        if math.abs(force.y) < 0.001 then force.y = 0 end

        lander.vx = lander.vx + force.x
        lander.vy = lander.vy + force.y
    else
        lander.engineOn = false
    end

    if love.keyboard.isDown("right") then
        lander.radius = lander.radius + (90 * dt) -- 90° par seconde

        if lander.radius > 360 then lander.radius = 0 end
    end

    if love.keyboard.isDown("down") then

        lander.vx = lander.vx - force.x
        lander.vy = lander.vy - force.y
    end

    if love.keyboard.isDown("left") then
        lander.radius = lander.radius - (90 * dt) -- 90° par seconde

        if lander.radius < 0 then lander.radius = 360 end
    end


    if math.abs(lander.vx) > 1 then
        if lander.vx > 0 then lander.vx = 1 else lander.vx = -1 end
    end

    if math.abs(lander.vy) > 1 then
        if lander.vy > 0 then lander.vy = 1 else lander.vy = -1 end
    end


    -- Déplacement du vaisseau
    lander.x = lander.x + lander.vx
    lander.y = lander.y + lander.vy
end

function love.draw()

    -- Vaisseau
    love.graphics.draw(lander.imgShip, lander.x, lander.y,
        math.rad(lander.radius), 1, 1, lander.imgShip:getWidth() / 2, lander.imgShip:getHeight() / 2)

    -- Moteur du vaisseau
    if lander.engineOn == true then
        love.graphics.draw(lander.imgEngine, lander.x, lander.y,
            math.rad(lander.radius), 1, 1, lander.imgEngine:getWidth() / 2, lander.imgEngine:getHeight() / 2)
    end


    -- Affichage du debug à l'écran
    local sDebug = ''
    sDebug = sDebug .. " gravité=" .. tostring(gravity)
    sDebug = sDebug .. " angle=" .. tostring(lander.radius)
    sDebug = sDebug .. " vx=" .. tostring(lander.vx)
    sDebug = sDebug .. " vy=" .. tostring(lander.vy)

    love.graphics.print(sDebug, 0, 0)
end
