local Map = {}

-- Constantes
Map.MAP_WIDTH = 32
Map.MAP_HEIGHT = 23

Map.TILE_WIDTH = 32
Map.TILE_HEIGHT = 32

-- Variables
Map.name = 'Carte n°1'
Map.tilesheet = 'assets/images/tilesheet.png'

Map.TileSheet = {}
Map.TileTextures = {}
Map.TileTypes = {}

Map.values = {
    { 10, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 13, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 },
    { 10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 15, 15, 15, 68, 15, 15 },
    { 10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 169, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 },
    { 10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 68, 15, 15, 15, 15, 15, 15 },
    { 10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 61, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 },
    { 10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 68, 15, 129, 15 },
    { 10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 61, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 },
    { 10, 10, 10, 10, 10, 13, 13, 13, 13, 13, 13, 13, 10, 10, 10, 10, 10, 169, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15 },
    { 10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 13, 14, 14, 14, 14, 14, 14, 14, 15, 129 },
    { 10, 10, 10, 10, 10, 10, 10, 10, 13, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 14 },
    { 10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 },
    { 10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 58, 10, 10, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 1, 1 },
    { 10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37 },
    { 13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 55, 10, 10, 10, 55, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 1, 37, 37, 37 },
    { 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 55, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37 },
    { 10, 10, 10, 10, 13, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37, 37 },
    { 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 169, 10, 10, 1, 37, 37, 37, 37, 37, 37, 37 },
    { 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37 },
    { 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37 },
    { 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 1, 37, 37, 37, 37, 37, 37, 37 },
    { 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 1, 37, 37, 37, 37, 37, 37 },
    { 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37, 37 },
    { 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37 }
}

-- Brouillard de guerre
Map.fog = {}

-- Charge les composants de la carte
function Map.load()

    -- On récupère la TileSheet
    Map.TileSheet = love.graphics.newImage(Map.tilesheet)

    -- On définit le nombre de colonnes é lignes
    local nbColumns = Map.TileSheet:getWidth() / Map.TILE_WIDTH
    local nbRows = Map.TileSheet:getHeight() / Map.TILE_HEIGHT

    -- Compteur des Tiles
    local id = 1

    -- Attribution des Tiles
    Map.TileTextures[0] = nil
    local row, column

    for row = 1, nbRows do
        for column = 1, nbColumns do
            Map.TileTextures[id] = love.graphics.newQuad((column - 1) * Map.TILE_WIDTH, (row - 1) * Map.TILE_HEIGHT,
                Map.TILE_WIDTH, Map.TILE_HEIGHT,
                Map.TileSheet:getWidth(), Map.TileSheet:getHeight())
            id = id + 1
        end
    end

    -- Chargement des types de tiles
    Map.setTileTypes()

    -- Création du brouillard de guerre
    Map.fog = {}

    local row, column

    for row = 1, Map.MAP_HEIGHT do
        Map.fog[row] = {}
        for column = 1, Map.MAP_WIDTH do
            Map.fog[row][column] = 1
        end
    end
end


-- Affiche la carte
function Map.draw()

    local row, column

    for row = 1, Map.MAP_HEIGHT do
        for column = 1, Map.MAP_WIDTH do

            local id = Map.values[row][column]
            local texQuad = Map.TileTextures[id]

            if texQuad ~= nil then

                local x = (column - 1) * Map.TILE_WIDTH
                local y = (row - 1) * Map.TILE_HEIGHT

                love.graphics.draw(Map.TileSheet, texQuad, x, y)

                if Map.fog[row][column] > 0 then

                    love.graphics.setColor(0, 0, 0, Map.fog[row][column])
                    love.graphics.rectangle('fill', x, y, Map.TILE_WIDTH, Map.TILE_HEIGHT)
                    love.graphics.setColor(1, 1, 1)
                end
            end
        end
    end
end

-- Définition des types de tile
function Map.setTileTypes()

    Map.TileTypes[10] = "Herbe"
    Map.TileTypes[11] = "Herbe"
    Map.TileTypes[13] = "Sable"
    Map.TileTypes[14] = "Sable"
    Map.TileTypes[15] = "Sable"
    Map.TileTypes[19] = "Eau"
    Map.TileTypes[20] = "Eau"
    Map.TileTypes[21] = "Eau"
    Map.TileTypes[37] = "Lave"
    Map.TileTypes[55] = "Arbre"
    Map.TileTypes[58] = "Arbre"
    Map.TileTypes[61] = "Arbre"
    Map.TileTypes[68] = "Arbre"
    Map.TileTypes[142] = "Arbre"
    Map.TileTypes[169] = "Pierre"
    Map.TileTypes[129] = "Pierre"
    Map.TileTypes[1] = "Pierre"
end

-- Retourne si la case est une case "Solide"
function Map.isSolid(_id)
    local tileType = Map.TileTypes[_id]

    if tileType == "Eau" or tileType == "Arbre" or tileType == "Pierre" then
        return true
    end

    return false
end

function Map.clearFog(_y, _x)

    local row, column

    for row = 1, Map.MAP_HEIGHT do
        for column = 1, Map.MAP_WIDTH do

            if column > 0 and column < Map.MAP_WIDTH and row > 0 and row < Map.MAP_HEIGHT then

                local distance = math.dist(column, row, _x, _y)

                if distance < 5 then

                    if distance > 2 then
                        local alpha = distance / 5

                        if Map.fog[row][column] > alpha then
                            Map.fog[row][column] = alpha
                        end

                    else
                        Map.fog[row][column] = 0
                    end
                end
            end
        end
    end
end

return Map