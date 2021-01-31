local player = {}

player.images = {}
player.images[1] = love.graphics.newImage('assets/images/player_1.png')
player.images[2] = love.graphics.newImage('assets/images/player_2.png')
player.images[3] = love.graphics.newImage('assets/images/player_3.png')
player.images[4] = love.graphics.newImage('assets/images/player_4.png')

player.currentImage = 1

player.x = 1 -- Column
player.y = 1 -- Line

-- Sons du personnage
player.sounds = {
    crash = love.audio.newSource('assets/sounds/explosion.wav', 'static')
}

function player.load(_y, _x)
    player.x = _x
    player.y = _y
end

function player.update(_map, dt)

    -- Choix de l'image du personnage
    player.currentImage = player.currentImage + (5 * dt)
    if math.floor(player.currentImage) > #player.images then
        player.currentImage = 1
    end

    -- Actions au clavier
    if love.keyboard.isDown('up', 'right', 'down', 'left') then

        if player.keyPressed == false then

            local old_x = player.x
            local old_y = player.y

            if love.keyboard.isDown('up') and player.y > 1 then
                player.y = player.y - 1
            end

            if love.keyboard.isDown('right') and player.x < _map.MAP_WIDTH then
                player.x = player.x + 1
            end

            if love.keyboard.isDown('down') and player.y < _map.MAP_HEIGHT then
                player.y = player.y + 1
            end

            if love.keyboard.isDown('left') and player.x > 1 then
                player.x = player.x - 1
            end

            -- Gestion des collisions
            local id = _map.values[player.y][player.x]

            if _map.isSolid(id) then
                print('Collision détectée !')

                player.sounds.crash:setVolume(0.2)
                player.sounds.crash:play()

                player.x = old_x
                player.y = old_y
            end


            player.keyPressed = true
        end

    else
        player.keyPressed = false
    end
end

function player.draw(_map)

    local x = (player.x - 1) * _map.TILE_WIDTH
    local y = (player.y - 1) * _map.TILE_HEIGHT

    love.graphics.draw(player.images[math.floor(player.currentImage)], x, y, 0, 2, 2)
end

return player