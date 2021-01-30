-- Permet d'afficher des traces dans la console pendant l'execution
io.stdout:setvbuf('no')

-- Empeche Löve2D de filtrer les contours des images quand elles sont redimentionnees
love.graphics.setDefaultFilter("nearest")

-- Fenetre
local window = {
    width = 0,
    height = 0,
}

-- Player
local player = require('Player')

-- MusicManager
local musicManager = require('MusicManager')

-- Zones
local zoneCool = {
    name = "COOL",
    image = love.graphics.newImage('assets/images/forest.png'),
    music = love.audio.newSource('assets/sounds/cool.mp3', 'stream'),
}

local zoneTechno = {
    name = "TECHNO",
    image = love.graphics.newImage('assets/images/volcano.png'),
    music = love.audio.newSource('assets/sounds/techno.mp3', 'stream')
}

-- Paramètres du jeu
local game = {
    groundPosition = 0,
    backgroundImage = '',
    backgroundPosition = 1,
}

-- Configuration de la fenetre du jeu
function setWindowSettings()

    -- Mode 512x256 doublé
    love.window.setMode(512 * 2, 256 * 2)

    -- Titre du jeu
    love.window.setTitle("Infinite Music Runner")

    window.width = love.graphics.getWidth() / 2
    window.height = love.graphics.getHeight() / 2
end


-- Initialisation du jeu
function love.load()

    -- Configuration de la fenetre
    setWindowSettings()

    -- Création du joueur
    game.groundPosition = window.height - 25 -- Position du sol
    player.y = game.groundPosition
    player.x = window.width / 4

    -- Creation du MusicManager
    musicManager.addMusic(zoneCool.music)
    musicManager.addMusic(zoneTechno.music)
    musicManager.playMusic(1)
end

-- Boucle infinie du jeu
function love.update(dt)

    -- Déplacement horizontale du joueur
    if love.keyboard.isDown('right') and player.x < window.width then
        player.x = player.x + (2 * 60 * dt)
    elseif love.keyboard.isDown('left') and player.x > 0 then
        player.x = player.x - (2 * 60 * dt)
    end

    -- Applique la vélocité verticale
    player.y = player.y + player.vy * dt

    -- Applique la gravité
    if player.isJumping  then
        player.vy = player.vy + 600 * dt
    end

    -- Stoppe le héro au sol si il est tombé plus bas que la ligne de sol
    if player.isJumping  and player.y > game.groundPosition then
        player.run(game.groundPosition)
    end


    -- Choix de l'image du joueur
    player.currentImage = player.currentImage + 12 * dt
    if player.currentImage > #player.listImages then
        player.currentImage = 1
    end

    -- Scrolling infini du fond
    game.backgroundPosition = game.backgroundPosition - 30 * dt
    if game.backgroundPosition <= 0 - zoneCool.image:getWidth() then
        game.backgroundPosition = 1
    end

    -- Choix de la musique à jouer
    if player.x < window.width / 2 and musicManager.currentMusic ~= 1 then
        musicManager.playMusic(1)
    elseif player.x >= window.width / 2 and musicManager.currentMusic ~= 2 then
        musicManager.playMusic(2)
    end

    musicManager.update()
end

-- Dessin du jeu
function love.draw()

    -- On sauvegarde les paramètres d'affichage
    love.graphics.push()

    -- On double la taille des pixels
    love.graphics.scale(2, 2)

    -- Choix de l'image de fond
    if player.x > window.width / 2 then
        game.backgroundImage = zoneCool.image
    else
        game.backgroundImage = zoneTechno.image
    end

    -- Réaffichage du fond s'il y a de l'espace
    if game.backgroundPosition < 1 then
        love.graphics.draw(game.backgroundImage, game.backgroundPosition + zoneCool.image:getWidth(), 1)
    end


    -- Affichage de l'image de fond
    love.graphics.draw(game.backgroundImage, game.backgroundPosition, 1)

    -- Affichage du joueur
    local pImage = math.floor(player.currentImage)
    love.graphics.draw(player.listImages[pImage], player.x - (player.width / 2), player.y - (player.height / 2))

    -- Affichage de la ligne centrale
    love.graphics.setColor(1, 0.4, 0.4)
    love.graphics.line(window.width / 2, 0, window.width / 2, window.height)

    -- Affichage des noms
    love.graphics.setColor(1, 1, 1) -- Pour Love 11.0 et supérieur
    love.graphics.print(zoneCool.name, window.width / 4, 10)
    love.graphics.print(zoneTechno.name, (window.width / 4) * 3, 10)

    -- On restaure les paramètres d'affichage
    love.graphics.pop()
end

-- Listener des touches
function love.keypressed(key)

    -- Action sur la touche "Flèche haut" ou "Espace" ou (+ compatibilité Löve 0.9)
    if (key == "up" or key == "space" or key == " ") then
        player.jump()
    end
end