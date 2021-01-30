local Sprite = {}

function Sprite.createSprite(_listSprites, _type, _imageFile, _nbFrames)

    local newSprite = {}

    -- Type de sprite ( zombie, human, ... )
    newSprite.type = _type

    -- Visibilité à l'écran du sprite
    newSprite.isVisible = true

    -- Liste des images du sprite
    newSprite.images = {}

    local i
    for i = 1, _nbFrames do
        local filename = 'assets/images/' .. _imageFile .. '_' .. i .. '.png'
        newSprite.images[i] = love.graphics.newImage(filename)
    end

    -- Image active
    newSprite.currentFrame = 1

    -- Position du personnage
    newSprite.x = 0
    newSprite.y = 0

    -- Vélocité du personnage
    newSprite.vx = 0
    newSprite.vy = 0

    -- On récupère la taille d'une image
    newSprite.width = newSprite.images[1]:getWidth()
    newSprite.height = newSprite.images[1]:getHeight()

    -- Ajout à la liste des sprites du jeu
    table.insert(_listSprites, newSprite)

    return newSprite
end

return Sprite