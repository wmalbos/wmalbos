-- Cette ligne permet d'afficher des traces dans la console pendant l'execution
io.stdout:setvbuf('no')

local windowWidth = 0
local windowHeight = 0

-- Raquette
local pad = {
    x = 0,
    y = 0,
    width = 80,
    height = 20
}

-- Balle
local ball = {
    x = 0,
    y = 0,
    radius = 10,
    glue = false, -- La balle est collé à la raquette
    vx = 0, -- Vitesse en x
    vy = 0, -- Vitesse en y
}

-- Briques
local tile = {}

-- Niveau
local level = {}


function start()
    ball.glue = true
    level = {}

    local row, column

    for row = 1, 6 do
        level[row] = {}
        for column = 1, 15 do
            level[row][column] = 1
        end
    end
end

function love.load()

    windowWidth = love.graphics.getWidth() -- Largeur de l'écran
    windowHeight = love.graphics.getHeight() -- hauteur de l'éceran

    pad.y = windowHeight - (pad.height + 10) -- Position y de la Raquette

    tile.height = 25
    tile.width = windowWidth / 15

    start() -- Initialisation
end

function love.update(dt)

    -- On récupère la postion X de la souris
    pad.x = love.mouse.getX()

    -- On check si la balle doit $etre collé à la raquette
    if (ball.glue == true) then
        ball.x = pad.x
        ball.y = pad.y - pad.height / 2 - ball.radius
    else
        ball.x = ball.x + ball.vx * dt -- Position + nombre de pixel en x parcouru en dt
        ball.y = ball.y + ball.vy * dt -- Position + nombre de pixel en y parcouru en dt
    end


    -- Collision avec une brique
    local column = math.floor(ball.x / tile.width) + 1
    local row = math.floor(ball.y / tile.height) + 1

    if row >= 1 and row <= #level and column >= 1 and column <= 15 then
        if level[row][column] == 1 then
            ball.vy = 0 - ball.vy
            level[row][column] = 0
        end
    end

    -- Collision avec un bords de l'écran
    if ball.x > windowWidth then
        ball.vx = 0 - ball.vx
        ball.x = windowWidth -- Pour éviter que la ball soit enprisonné hors de l'écran
    end

    if ball.x < 0 then
        ball.vx = 0 - ball.vx
        ball.x = 0 -- Pour éviter que la ball soit enprisonné hors de l'écran
    end

    if ball.y < 0 then
        ball.vy = 0 - ball.vy
        ball.y = 0 -- Pour éviter que la ball soit enprisonné hors de l'écran
    end

    -- Perdu 1 vie
    if ball.y > windowHeight then
        ball.glue = true
    end

    -- Test sur la collision entre la balle et la raquette
    local positionCollisionPad = pad.y - (pad.height / 2) - ball.radius

    if ball.y > positionCollisionPad then
        local dist = math.abs(pad.x - ball.x)
        if dist < pad.width / 2 then
            ball.vy = 0 - ball.vy
            ball.y = positionCollisionPad
        end
    end
end

function love.draw()

    -- Briques
    local tileX, tileY = 0, 0 -- Position du dessin de briques
    local row, column

    for row = 1, 6 do
        tileX = 0

        for column = 1, 15 do

            if level[row][column] == 1 then
                love.graphics.rectangle('fill', tileX + 1, tileY + 1, tile.width - 2, tile.height - 2)
            end

            tileX = tileX + tile.width
        end

        tileY = tileY + tile.height
    end

    -- Raquette
    love.graphics.rectangle('fill', pad.x - (pad.width / 2), pad.y - (pad.height / 2), pad.width, pad.height)

    -- Balle
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end

function love.mousepressed(x, y, n)

    -- Décollage de la balle au premier clic
    if ball.glue == true then
        ball.glue = false
        ball.vx = 200
        ball.vy = -200
    end
end

function love.keypressed(key)
end