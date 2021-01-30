-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
love.graphics.setDefaultFilter("nearest")

-- Returns the distance between two points.
function math.dist(x1, y1, x2, y2) return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5 end

-- Returns the angle between two points.
function math.angle(x1, y1, x2, y2) return math.atan2(y2 - y1, x2 - x1) end

-- Définition de la fenetre de l'application
window = {
    width = 0,
    height = 0,
}

-- définition du jeu ZombiesAttack
local Game = require('Game')

-- Définition de la configuration de la fenetre
function setWindowConfiguration()

    love.window.setTitle("Zombies Attack")

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