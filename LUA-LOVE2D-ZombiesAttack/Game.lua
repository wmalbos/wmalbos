local Game = {}

Sprite = require('Sprite')
Player = require('Player')
Zombie = require('Zombie')


-- Nombre de zombie
Game.ZOMBIES_NUMBER = 100

-- Personnage
Game.player = {}

-- Liste des différents sprites ( zombies / personnage / ... )
Game.listSprites = {}


-- Chargement du jeu
function Game.load()

    -- Création du personnage
    Game.player = Player.createPlayer(Game.listSprites)

    -- Création des zombies
    for nbZombies = 1, Game.ZOMBIES_NUMBER do
        Zombie.createZombie(Game.listSprites)
    end
end

-- Mise à jour du jeu
function Game.update(dt)

    for i, sprite in ipairs(Game.listSprites) do

        -- Sprite active
        sprite.currentFrame = sprite.currentFrame + (5 * dt)

        if sprite.currentFrame >= #sprite.images + 1 then -- +1 car on utilise la partie entière - ex: 4,1
            sprite.currentFrame = 1
        end

        -- Application de la vélocité
        sprite.x = sprite.x + sprite.vx * dt
        sprite.y = sprite.y + sprite.vy * dt

        -- Mise en action du zombie qui est dans "sprite"
        if sprite.type == 'zombie' then
            Zombie.updateZombie(sprite, Game.listSprites)
        end
    end

    -- Actions sur le personnage
    if love.keyboard.isDown('up') then
        Game.player.y = Game.player.y - 1
    end

    if love.keyboard.isDown('right') then
        Game.player.x = Game.player.x + 1
    end

    if love.keyboard.isDown('down') then
        Game.player.y = Game.player.y + 1
    end

    if love.keyboard.isDown('left') then
        Game.player.x = Game.player.x - 1
    end
end


-- Affichage du jeu
function Game.draw()

    love.graphics.push()
    love.graphics.scale(2, 2)

    love.graphics.print('Points de vie : ' .. tostring(math.floor(Game.player.hp)), 1, 1)

    for i, sprite in ipairs(Game.listSprites) do

        if sprite.isVisible then

            local frame = sprite.images[math.floor(sprite.currentFrame)]
            love.graphics.draw(frame, sprite.x - sprite.width / 2, sprite.y - sprite.height / 2)

            if sprite.type == 'zombie' then

                if love.keyboard.isDown('d') then
                    love.graphics.print(sprite.state, sprite.x - 10, sprite.y - sprite.height - 10)
                end

                Zombie.drawZombie(sprite)
            end

        end
    end

    love.graphics.pop()
end

return Game