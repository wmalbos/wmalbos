local Game = {}

-- Définition de la carte
Game.map = require('Map')

-- Définition du joueur
Game.player = require('Player')


function Game.load()

    Game.map.load()

    Game.player.load(14, 1)

    -- Effacement du brouillard de guerre
    Game.map.clearFog(Game.player.y, Game.player.x)

end

function Game.update(dt)

    Game.player.update(Game.map, dt)

    -- Effacement du brouillard de guerre
    Game.map.clearFog(Game.player.y, Game.player.x)

end

function Game.draw()

    Game.map.draw()
    Game.player.draw(Game.map)

    -- Récupération des coordonnées de la souris
    local mouse = {
        x = 0,
        y = 0,
    }

    mouse.x = love.mouse.getX()
    mouse.y = love.mouse.getY()

    local mouseRow = math.floor(mouse.y / Game.map.TILE_HEIGHT) + 1
    local mouseColumn = math.floor(mouse.x / Game.map.TILE_WIDTH) + 1

    if mouseRow > 0 and mouseColumn > 0 and mouseRow <= Game.map.MAP_HEIGHT and mouseColumn <= Game.map.MAP_WIDTH then
        local id = Game.map.values[mouseRow][mouseColumn]

        love.graphics.print("Ligne: " .. tostring(mouseRow) .. " | Colonne: " .. tostring(mouseColumn) .. " | Type: " .. tostring(Game.map.TileTypes[id]), 5, Game.map.MAP_HEIGHT * Game.map.TILE_HEIGHT)
    end

end

return Game