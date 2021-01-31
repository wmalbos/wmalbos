-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
love.graphics.setDefaultFilter("nearest")

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

local window = {
    width = 0,
    height = 0,
}

local game = require('Game')


function setWindowConfiguration()

    -- Attribution de la taille de l'application
    love.window.setMode(1024, 768)

    --
    love.graphics.setFont(love.graphics.newFont(24))

    -- On récupère la taille de la fenetre
    window.width = love.graphics.getWidth()
    window.height = love.graphics.getHeight()

end

function love.load()

    -- configuration de la fenetre
    setWindowConfiguration()

    -- Chargement de la carte
    game.load()
end

function love.update(dt)

    game.update(dt)

end

function love.draw()

    game.draw()
end
