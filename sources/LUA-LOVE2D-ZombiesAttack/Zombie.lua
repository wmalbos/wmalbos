local Zombie = {}

-- Etats du zombie
Zombie.ZOMBIE_STATES = {
    NONE = 'none',
    WALK = 'Marche',
    ATTACK = 'Détection',
    BITE = 'Attaque',
    CHANGE_DIRECTION = 'change_direction',
}

-- Images d'un zombie
Zombie.images = {
    alert = love.graphics.newImage('assets/images/alert.png')
}

-- Sons que peux faire un zombie
Zombie.sounds = {
    bite = love.audio.newSource('assets/sounds/zombie_bite.wav', 'static'),
}

-- Nouveau zombie
function Zombie.createZombie(_listSprites)

    local newZombie = Sprite.createSprite(_listSprites, 'zombie', 'monster', 2)

    -- Position du zombie
    newZombie.x = math.random(10, window.width - 10)
    newZombie.y = math.random(10, window.height - 100)

    -- Etat du zombie
    newZombie.state = Zombie.ZOMBIE_STATES.NONE

    -- Vitesse du zombie
    newZombie.speed = math.random(5, 50) / 200

    -- Portée de détection de l'humain
    newZombie.range = math.random(10, 150)

    -- Cible du zombie
    newZombie.target = nil

    return newZombie
end

-- Mise à jours du zombie
function Zombie.updateZombie(_zombie, _entities)

    if _zombie.state == Zombie.ZOMBIE_STATES.NONE then

        -- Le zombie ce met à marcher dans une autre direction par defaut
        _zombie.state = Zombie.ZOMBIE_STATES.CHANGE_DIRECTION

    elseif _zombie.state == Zombie.ZOMBIE_STATES.WALK then

        -- Le zombie recherche une proie
        Zombie.actionWalking(_zombie, _entities)

    elseif _zombie.state == Zombie.ZOMBIE_STATES.ATTACK then

        -- Proie trouvée - le zombie avance vers elle
        Zombie.actionAttack(_zombie)

    elseif _zombie.state == Zombie.ZOMBIE_STATES.BITE then

        -- Le zombie attaque la proie
        Zombie.actionBite(_zombie)

    elseif _zombie.state == Zombie.ZOMBIE_STATES.CHANGE_DIRECTION then

        -- Le zombie change de direction
        Zombie.actionChangeDirection(_zombie)
    end
end

-- Le zombie recherche une proie
function Zombie.actionWalking(_zombie, _entities)

    -- Collision avec les bords de l'écran
    local collide = false

    if _zombie.x < 0 then
        _zombie.x = 0
        collide = true
    end

    if _zombie.x > window.width then
        _zombie.x = window.width
        collide = true
    end

    if _zombie.y < 0 then
        _zombie.y = 0
        collide = true
    end

    if _zombie.y > window.height then
        _zombie.y = window.height
        collide = true
    end

    if collide then
        _zombie.state = Zombie.ZOMBIE_STATES.CHANGE_DIRECTION
    end

    -- Recherche des humains
    for i, sprite in ipairs(_entities) do

        if sprite.type == 'human' and sprite.isAlive then
            local distance = math.dist(_zombie.x, _zombie.y, sprite.x, sprite.y)

            if distance < _zombie.range then
                _zombie.state = Zombie.ZOMBIE_STATES.ATTACK
                _zombie.target = sprite
            end
        end
    end
end

-- Proie trouvée - le zombie avance vers elle
function Zombie.actionAttack(_zombie)

    if _zombie.target == nil then

        _zombie.state = Zombie.ZOMBIE_STATES.CHANGE_DIRECTION

    elseif math.dist(_zombie.x, _zombie.y, _zombie.target.x, _zombie.target.y) > _zombie.range
            and _zombie.target.type == 'human'
            and _zombie.target.isAlive then

        _zombie.state = Zombie.ZOMBIE_STATES.CHANGE_DIRECTION

    elseif math.dist(_zombie.x, _zombie.y, _zombie.target.x, _zombie.target.y) < 5
            and _zombie.target.type == 'human'
            and _zombie.target.isAlive then

        _zombie.state = Zombie.ZOMBIE_STATES.BITE

        -- On change la vélocité car le zombie attaque sans bouger
        _zombie.vx = 0
        _zombie.vy = 0

    else

        if _zombie.target.isAlive then

            -- Valeur aléatoire derecherche autour de la cible ( effet de titube + acharnement lors de la morsure )
            local destX, destY

            destX = math.random(_zombie.target.x - 10, _zombie.target.x + 10)
            destY = math.random(_zombie.target.y - 10, _zombie.target.y + 10)

            -- Direction de la cible
            local angle = math.angle(_zombie.x, _zombie.y, destX, destY)

            _zombie.vx = _zombie.speed * 60 * math.cos(angle) * 2
            _zombie.vy = _zombie.speed * 60 * math.sin(angle) * 2

        else

            -- Direction de la cible
            local angle = math.angle(_zombie.x, _zombie.y, math.random(0, window.width), math.random(0, window.height))

            _zombie.vx = _zombie.speed * 60 * math.cos(angle)
            _zombie.vy = _zombie.speed * 60 * math.sin(angle)
            _zombie.state = Zombie.ZOMBIE_STATES.CHANGE_DIRECTION
        end
    end
end

-- Le zombie attaque la proie
function Zombie.actionBite(_zombie)

    if math.dist(_zombie.x, _zombie.y, _zombie.target.x, _zombie.target.y) > 5 then
        _zombie.state = Zombie.ZOMBIE_STATES.ATTACK
    else
        _zombie.target.hurt(0.1)

        Zombie.sounds.bite:setVolume(0.4)
        Zombie.sounds.bite:play()

        if _zombie.target.isAlive == false then
            _zombie.state = Zombie.ZOMBIE_STATES.CHANGE_DIRECTION
        end
    end
end

-- Le zombie change de direction
function Zombie.actionChangeDirection(_zombie)

    local angle = math.angle(_zombie.x, _zombie.y, math.random(0, window.width), math.random(0, window.height))

    _zombie.vx = _zombie.speed * 60 * math.cos(angle)
    _zombie.vy = _zombie.speed * 60 * math.sin(angle)

    _zombie.state = Zombie.ZOMBIE_STATES.WALK
end

-- Affichage du zombie
function Zombie.drawZombie(_zombie)

    if _zombie.state == Zombie.ZOMBIE_STATES.ATTACK then
        love.graphics.draw(Zombie.images.alert, _zombie.x - Zombie.images.alert:getWidth() / 2, _zombie.y - _zombie.height - 2)
    end

    if _zombie.state == Zombie.ZOMBIE_STATES.BITE then
        love.graphics.draw(Zombie.images.alert, _zombie.x - Zombie.images.alert:getWidth() / 2, _zombie.y - _zombie.height - 2)
    end
end

return Zombie