-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

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
end

function love.draw()

    game.draw()
end
