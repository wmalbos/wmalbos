-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Définition de la fenetre de l'application
window = {
    width = 0,
    height = 0,
}

-- définition du jeu ZombiesAttack
local Game = require('Game')

-- Définition de la configuration de la fenetre
function setWindowConfiguration()

    love.window.setTitle("-- PONG --")

    window.width = love.graphics:getWidth() / 2
    window.height = love.graphics:getHeight() / 2

end

function love.load()

    -- Configuration de la fenetre
    setWindowConfiguration()

    -- Chargement du jeu
    Game.load()

end

function love.update(dt)

    -- Mise à jour du jeu
    Game.update(dt)

end

function love.draw()

    -- Affichage du jeu
    Game.draw()

end