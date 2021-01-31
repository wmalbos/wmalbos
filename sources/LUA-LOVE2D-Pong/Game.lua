local Game = {}

Pad = require('Pad')
Ball = require('Ball')

-- Raquettes du jeu 0 = Gauche / 1 = Droite
Game.PAD_LEFT = 0
Game.PAD_RIGHT = 1

Game.padsNumber = 2
Game.pads = {}

-- Ball de jeu
Game.ballsNumber = 1
Game.balls = {}

-- Chargement du jeu
function Game.load()

    -- Création des différents pad
    Game.pads[Game.PAD_LEFT] = Pad.createPad(0, (love.graphics.getHeight() / 2) - (Pad.DEFAULT.HEIGHT / 2))
    Game.pads[Game.PAD_RIGHT] = Pad.createPad(love.graphics.getWidth() - Pad.DEFAULT.WIDTH, (love.graphics.getHeight() / 2) - (Pad.DEFAULT.HEIGHT / 2))

    Game.balls[0] = Ball.createBall((love.graphics.getWidth() / 2) - (Ball.DEFAULT.WIDTH / 2), (love.graphics.getHeight() / 2) - (Ball.DEFAULT.HEIGHT / 2))
end

-- Mise à jour du jeu
function Game.update(dt)

    -- Mise à jour du jeu
    for i = 1, Game.ballsNumber do
        Ball.move(Game.balls[i - 1], Game.pads, Game.padsNumber)
    end


    -- Gestion des controls

    if love.keyboard.isDown("a") then
        Pad.up(Game.pads[Game.PAD_LEFT])
    end

    if love.keyboard.isDown("q") then
        Pad.down(Game.pads[Game.PAD_LEFT])
    end

    if love.keyboard.isDown("z") then
        Pad.up(Game.pads[Game.PAD_RIGHT])
    end

    if love.keyboard.isDown("s") then
        Pad.down(Game.pads[Game.PAD_RIGHT])
    end

end

-- Affichage du jeu
function Game.draw()

    -- Dessin des pads
    Pad.draw(Game.pads[Game.PAD_LEFT])
    Pad.draw(Game.pads[Game.PAD_RIGHT])

    -- Dessin des balls
    for i = 1, Game.ballsNumber do
        Ball.draw(Game.balls[i - 1])
    end

end

return Game