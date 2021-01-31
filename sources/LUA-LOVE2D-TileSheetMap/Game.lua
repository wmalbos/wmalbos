local Game = {}

Game.map = require('Map')

Game.TileSheet = {}
Game.TileTypes = {}
Game.TileTextures = {}


-- Charge la map et les tiles
function Game.load()

    print('Game: Chargement des textures ...')

    -- On récupère la TileSheet
    Game.TileSheet = love.graphics.newImage(Game.map.tilesheet)

    -- On définit le nombre de colonnes é lignes
    local nbColumns = Game.TileSheet:getWidth() / Game.map.TILE_WIDTH
    local nbRows = Game.TileSheet:getHeight() / Game.map.TILE_HEIGHT

    -- Compteur des Tiles
    local id = 1

    -- Attribution des Tiles
    Game.TileTextures[0] = nil
    local row, column

    for row = 1, nbRows do
        for column = 1, nbColumns do
            Game.TileTextures[id] = love.graphics.newQuad((column - 1) * Game.map.TILE_WIDTH, (row - 1) * Game.map.TILE_HEIGHT,
                Game.map.TILE_WIDTH, Game.map.TILE_HEIGHT,
                Game.TileSheet:getWidth(), Game.TileSheet:getHeight())
            id = id + 1
        end
    end

    -- Chargement des types de tiles
    Game.setTileTypes()

    print('Game: Chargement des textures terminé !')
end

-- Définition des types de tile
function Game.setTileTypes()

    Game.TileTypes[10] = "Herbe"
    Game.TileTypes[11] = "Herbe"
    Game.TileTypes[13] = "Sable"
    Game.TileTypes[14] = "Sable"
    Game.TileTypes[15] = "Sable"
    Game.TileTypes[19] = "Eau"
    Game.TileTypes[20] = "Eau"
    Game.TileTypes[21] = "Eau"
    Game.TileTypes[37] = "Lave"
    Game.TileTypes[55] = "Arbre"
    Game.TileTypes[58] = "Arbre"
    Game.TileTypes[61] = "Arbre"
    Game.TileTypes[68] = "Arbre"
    Game.TileTypes[169] = "Pierre"
    Game.TileTypes[129] = "Pierre"
end

-- Dessine la map
function Game.draw()

    local row, column

    for row = 1, Game.map.MAP_HEIGHT do
        for column = 1, Game.map.MAP_WIDTH do

            local id = Game.map.values[row][column]
            local texQuad = Game.TileTextures[id]

            if texQuad ~= nil then
                love.graphics.draw(Game.TileSheet, texQuad, (column - 1) * Game.map.TILE_WIDTH, (row - 1) * Game.map.TILE_HEIGHT)
            end
        end
    end



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

        love.graphics.print("Ligne: " .. tostring(mouseRow) .. " | Colonne: " .. tostring(mouseColumn) .. " | Type: " .. tostring(Game.TileTypes[id]), 1, 1)
    end
end

return Game