local Player = {}

-- Sons que peut faire le personnage
Player.sounds = {
    death = love.audio.newSource('assets/sounds/player_death.wav', 'static'),
}

function Player.createPlayer(_listSprites)

    local newPlayer = {}

    newPlayer = Sprite.createSprite(_listSprites, 'human', 'player', 4)

    -- Position du personnage
    newPlayer.x = window.width / 2
    newPlayer.y = (window.height / 6) * 5

    -- le personnage est en vie
    newPlayer.isAlive = true

    -- Nombre de points de vie
    newPlayer.hp = 100

    -- Le personnage ce fait attaquer
    newPlayer.hurt = function(_damage)
        newPlayer.hp = newPlayer.hp - _damage

        if newPlayer.hp <= 0 then
            newPlayer.hp = 0
            newPlayer.isAlive = false
            newPlayer.isVisible = false

            Player.sounds.death:setVolume(0.4)
            Player.sounds.death:play()
        end
    end

    return newPlayer
end

return Player