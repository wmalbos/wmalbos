local newPlayer = {}

-- Sons
local sounds = {
    jump = love.audio.newSource('assets/sounds/sfx_movement_jump13.wav', 'static'),
    landing = love.audio.newSource('assets/sounds/sfx_movement_jump13_landing.wav', 'static')
}

-- Définition de la position du joueur
newPlayer.x = 0
newPlayer.y = 0

-- Définition de la vélocité verticale du joueur
newPlayer.vy = 0

-- Par défaut le joueur n'est pas en train de sauter
newPlayer.isJumping = false

-- Définition de la liste des images du joueur
newPlayer.listImages = {}

-- Chargement des images du joueur
local cpt
for cpt = 1, 8 do
    local newImage = love.graphics.newImage('assets/images/hero-day-' .. cpt .. '.png')
    table.insert(newPlayer.listImages, newImage)
end

-- Définition de l'image de départ
newPlayer.currentImage = 1

-- Définition de la taille du joueur
newPlayer.width = newPlayer.listImages[1]:getWidth()
newPlayer.height = newPlayer.listImages[1]:getHeight()


-- Action - Saut du joueur
function newPlayer.jump()

    if newPlayer.isJumping == false then

        -- Saut en cours
        newPlayer.isJumping = true

        -- Vélocité verticale
        newPlayer.vy = -200

        -- Effet sonore du saut
        sounds.jump:play()

    end

end

function newPlayer.run(_grounddPosition)

    -- Position du joueur sur le sol
    newPlayer.y = _grounddPosition

    -- Saut terminé
    newPlayer.isJumping = false

    -- Vélocité verticale
    newPlayer.vy = 0

    -- Effet sonore de la chute
    sounds.landing:play()

end

return newPlayer