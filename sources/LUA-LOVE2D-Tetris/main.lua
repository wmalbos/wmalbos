-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
love.graphics.setDefaultFilter("nearest")

-- Fenetre
local window = {}
window.width = 0
window.height = 0;

-- Grille de jeu
local grid = {}
grid.width = 10
grid.height = 20
grid.cells = {}
grid.cell_size = 0

-- Liste des tetrominos
local tetros = {}
tetros[1] = {}
tetros[1].shape = {
    {
        { 0, 0, 0, 0 },
        { 1, 1, 1, 1 },
        { 0, 0, 0, 0 },
        { 0, 0, 0, 0 }
    },
    {
        { 0, 0, 1, 0 },
        { 0, 0, 1, 0 },
        { 0, 0, 1, 0 },
        { 0, 0, 1, 0 }
    }
}
tetros[1].color = { 255 / 255, 0, 0 }

tetros[2] = {}
tetros[2].shape = {
    {
        { 0, 0, 0, 0 },
        { 0, 1, 1, 0 },
        { 0, 1, 1, 0 },
        { 0, 0, 0, 0 }
    }
}
tetros[2].color = { 0, 71 / 255, 222 / 255 }

tetros[3] = {}
tetros[3].shape = {
    {
        { 0, 0, 0 },
        { 1, 1, 1 },
        { 0, 0, 1 }
    },
    {
        { 0, 1, 0 },
        { 0, 1, 0 },
        { 1, 1, 0 }
    },
    {
        { 1, 0, 0 },
        { 1, 1, 1 },
        { 0, 0, 0 }
    },
    {
        { 0, 1, 1 },
        { 0, 1, 0 },
        { 0, 1, 0 }
    }
}
tetros[3].color = { 222 / 255, 184 / 255, 0 }

tetros[4] = {}
tetros[4].shape = {
    {
        { 0, 0, 0 },
        { 1, 1, 1 },
        { 1, 0, 0 }
    },
    {
        { 1, 1, 0 },
        { 0, 1, 0 },
        { 0, 1, 0 }
    },
    {
        { 0, 0, 1 },
        { 1, 1, 1 },
        { 0, 0, 0 }
    },
    {
        { 1, 0, 0 },
        { 1, 0, 0 },
        { 1, 1, 0 }
    }
}
tetros[4].color = { 222 / 255, 0, 222 / 255 }

tetros[5] = {}
tetros[5].shape = {
    {
        { 0, 0, 0 },
        { 0, 1, 1 },
        { 1, 1, 0 }
    },
    {
        { 0, 1, 0 },
        { 0, 1, 1 },
        { 0, 0, 1 }
    },
    {
        { 0, 0, 0 },
        { 0, 1, 1 },
        { 1, 1, 0 }
    },
    {
        { 0, 1, 0 },
        { 0, 1, 1 },
        { 0, 0, 1 }
    }
}
tetros[5].color = { 255 / 255, 151 / 255, 0 }

tetros[6] = {}
tetros[6].shape = {
    {
        { 0, 0, 0 },
        { 1, 1, 1 },
        { 0, 1, 0 }
    },
    {
        { 0, 1, 0 },
        { 1, 1, 0 },
        { 0, 1, 0 }
    },
    {
        { 0, 1, 0 },
        { 1, 1, 1 },
        { 0, 0, 0 }
    },
    {
        { 0, 1, 0 },
        { 0, 1, 1 },
        { 0, 1, 0 }
    }
}
tetros[6].color = { 71 / 255, 184 / 255, 0 }

tetros[7] = {}
tetros[7].shape = {
    {
        { 0, 0, 0 },
        { 1, 1, 0 },
        { 0, 1, 1 }
    },
    {
        { 0, 1, 0 },
        { 1, 1, 0 },
        { 1, 0, 0 }
    },
    {
        { 0, 0, 0 },
        { 1, 1, 0 },
        { 0, 1, 1 }
    },
    {
        { 0, 1, 0 },
        { 1, 1, 0 },
        { 1, 0, 0 }
    }
}
tetros[7].color = { 0, 184 / 255, 151 / 255 }

-- Tetrominos courrant
local current_tetros = {}
current_tetros.id = 1
current_tetros.rotation = 1
current_tetros.position = { x = 0, y = 0 }

-- Sac
local bag = {}

-- Options du jeu
local drop_speed
local timer_drop
local debug = true

-- Jeu
local game_state
local score
local level
local level_max = 20
local total_lines

-- Sons
local sndMusicMenu
local sndMusicGame
local sndMusicGameOver
local sndLine
local sndLevel

-- Polices
local fontMenu
local fontScore
local fontPlay

-- Menu
local menuSin = 0

-- Gestion du sac de pièces
function initBag()
    bag = {}
    for i = 1, #tetros do
        for j = 1, 8 do
            table.insert(bag, i)
        end
    end
end

-- Nouvelle pièce de jeu
function spawnShape()
    -- On retire la premi!re pièce du sac
    local new_bag = math.random(1, #bag)
    local new_shape_id = bag[new_bag]
    table.remove(bag, new_bag)
    -- Remplissage du sac
    if #bag == 0 then
        initBag()
    end

    current_tetros.id = new_shape_id
    current_tetros.rotation = 1

    local tetros_width = #tetros[current_tetros.id].shape[current_tetros.rotation][1]
    current_tetros.position.x = (math.floor((grid.width - tetros_width) / 2)) + 1
    current_tetros.position.y = 1

    if collide() then
        startGameOver()
    end
end

-- Affichage d'un tetrominos
function drawShape(pShape, pColor, pPositionX, pPositionY)
    -- Attribution de la couleur
    love.graphics.setColor(pColor[1], pColor[2], pColor[3])
    -- Parcours de la pièce
    for line = 1, #pShape do
        for column = 1, #pShape[line] do
            -- Position initial de la
            local x = (column - 1) * grid.cell_size
            local y = (line - 1) * grid.cell_size
            -- Ajout de la position de la pièce
            x = x + (pPositionX - 1) * grid.cell_size
            y = y + (pPositionY - 1) * grid.cell_size
            -- Ajout de l'offset de la grille
            x = x + grid.offset_x
            y = y + grid.offset_y
            -- Dessin de la pièce
            if pShape[line][column] == 1 then
                love.graphics.rectangle("fill", x, y, grid.cell_size - 1, grid.cell_size - 1)
            end
        end
    end
end

-- Initialisation de la grille de jeu
function initGrid()
    grid.cell_size = window.height / grid.height
    grid.offset_x = (window.width / 2) - (grid.cell_size * grid.width) / 2
    grid.offset_y = 0

    grid.cells = {}
    for line = 1, grid.height do
        grid.cells[line] = {}
        for column = 1, grid.width do
            grid.cells[line][column] = 0
        end
    end
end

-- Affichage de la grille de jeu
function drawGrid()
    local width = grid.cell_size
    local height = grid.cell_size
    local x, y
    local id
    -- Parcours de la grille de jeu
    for line = 1, grid.height do
        for column = 1, grid.width do
            -- Position initial de la case
            x = (column - 1) * width
            y = (line - 1) * height
            -- Ajout de l'offset de la grille
            x = x + grid.offset_x
            y = y + grid.offset_y
            -- On récupère l'id de la pièce  déjà placée si elle existe
            id = grid.cells[line][column]
            -- Attribution de la couleur de la case
            if id == 0 then
                love.graphics.setColor(1, 1, 1, 0.2)
            else
                local color = tetros[id].color
                love.graphics.setColor(color[1], color[2], color[3])
            end
            -- Affichage de la case
            love.graphics.rectangle("fill", x, y, width - 1, height - 1)
        end
    end
end

-- Recherche de collision
function collide()
    local shape = tetros[current_tetros.id].shape[current_tetros.rotation]

    for line = 1, #shape do
        for column = 1, #shape[line] do
            local lineInGrid = (line - 1) + current_tetros.position.y
            local columnInGrid = (column - 1) + current_tetros.position.x

            if shape[line][column] == 1 then
                -- Case de la pièce hors grille ( gauche / droite )
                if columnInGrid <= 0 or columnInGrid > grid.width then
                    return true
                end
                -- Case de la pièce hors de la grille ( bas )
                if lineInGrid > grid.height then
                    return true
                end
                -- Case de la grille non vide
                if grid.cells[lineInGrid][columnInGrid] ~= 0 then
                    return true
                end
            end
        end
    end
    -- Aucune collision détectée
    return false
end

-- Transfert de la pièce sur la grille
function transferShapeToGrid()
    local shape = tetros[current_tetros.id].shape[current_tetros.rotation]

    for line = 1, #shape do
        for column = 1, #shape[line] do
            local lineInGrid = (line - 1) + current_tetros.position.y
            local columnInGrid = (column - 1) + current_tetros.position.x

            if shape[line][column] == 1 then
                -- Copie de la cellule sur la grille
                grid.cells[lineInGrid][columnInGrid] = current_tetros.id
            end
        end
    end
end

-- Suppression d'une ligne de la grille
function removeLine(pLine)
    for line = pLine, 2, -1 do
        for column = 1, grid.width do
            grid.cells[line][column] = grid.cells[line - 1][column]
        end
    end
end

-- Modification du score en fonction de la ligne
function calculateScoreWithLines(pNbLines)
    total_lines = total_lines + pNbLines
    if pNbLines == 1 then
        score = score + (100 * level)
    elseif pNbLines == 2 then
        score = score + (300 * level)
    elseif pNbLines == 3 then
        score = score + (400 * level)
    elseif pNbLines == 4 then
        score = score + (800 * level)
    end
end

-- Initialisation du jeu
function startGame()
    love.graphics.setFont(fontScore)
    game_state = "play"

    -- Initialisation des variables
    score = 0
    level = 1
    total_lines = 9

    drop_speed = .3
    timer_drop = 0

    -- Sons
    sndMusicMenu:stop()
    sndMusicGameOver:stop()
    sndMusicGame:play()

    -- Initialisation de la grille et des pièces
    initGrid()
    initBag()
    spawnShape()
end

-- Initialisation du menu
function startMenu()
    love.graphics.setFont(fontMenu)
    game_state = "menu"

    sndMusicGameOver:stop()
    sndMusicGame:stop()
    sndMusicMenu:play()
end

-- Initialisation du GameOver
function startGameOver()
    love.graphics.setFont(fontMenu)
    game_state = "game_over"

    sndMusicGame:stop()
    sndMusicGameOver:play()
end

-- Gestion de l'augmentation des niveaux
function manage_levels()
    local new_level = math.floor(total_lines / 10) + 1
    if new_level <= level_max then
        if new_level ~= level then
            sndLevel:play()
            level = new_level
            drop_speed = drop_speed - 0.08
        end
    end
end

-- Mise à jour des données de jeu
function updateGame(dt)

    -- Prochain mouvement
    timer_drop = timer_drop - dt
    if timer_drop <= 0 then
        -- Descente de la pièce
        current_tetros.position.y = current_tetros.position.y + 1
        timer_drop = drop_speed
        -- Vérification des collisions
        if collide() then
            current_tetros.position.y = current_tetros.position.y - 1
            -- Sauvegarde de la pièce
            transferShapeToGrid()
            -- Nouvelle pièce
            spawnShape()
        end
    end


    local complete_line
    local nb_lines = 0

    -- Recherche d'une ligne complète
    for line = 1, grid.height do
        complete_line = true
        for column = 1, grid.width do
            if grid.cells[line][column] == 0 then
                complete_line = false
            end
        end
        -- Suppression de la ligne
        if complete_line then
            nb_lines = nb_lines + 1
            removeLine(line)
        end
    end

    if nb_lines > 0 then
        sndLine:play()
    end

    -- Modification du score
    calculateScoreWithLines(nb_lines)
    manage_levels()
end

-- Mise à jour des données du menu
function updateMenu(dt)
    initGrid()

    menuSin = menuSin + 5 * 30 * dt
end

-- Détection des touches du jeu
function inputGame(key)
    local shape = tetros[current_tetros.id].shape[current_tetros.rotation]

    -- Sauvegarde de l'état courant
    local old_position_x = current_tetros.position.x
    local old_position_y = current_tetros.position.y
    local old_rotation = current_tetros.rotation

    -- Quitte l'application
    if key == "escape" then
        love.event.quit()
    end

    -- Mouvement de la pièce
    if key == "right" then
        current_tetros.position.x = current_tetros.position.x + 1
    end

    if key == "left" then
        current_tetros.position.x = current_tetros.position.x - 1
    end

    if key == "up" then
        current_tetros.rotation = current_tetros.rotation + 1
        if current_tetros.rotation > #tetros[current_tetros.id].shape then
            current_tetros.rotation = 1
        end
    end

    -- Test de collision avec le nouvelle état de la pièce
    if collide() then
        current_tetros.position.x = old_position_x
        current_tetros.position.y = old_position_y
        current_tetros.rotation = old_rotation
    end

    -- Mouvement vertical de la pièce
    if key == "down" then
        current_tetros.position.y = current_tetros.position.y + 1
    end

    if collide() then
        current_tetros.position.y = old_position_y
        transferShapeToGrid()
        spawnShape()
    end

    -- Touches de debug
    if debug then
        if key == "n" then
            spawnShape()
        end
    end
end

-- Détection des touches du menu
function inputMenu(key)
    if key == "return" then
        startGame()
    end
end

-- Détection des touches lors du GameOver
function inputGameOver(key)
    if key == "return" then
        startGame()
    end
end

-- Affichage du jeu
function drawGame()
    local shape = tetros[current_tetros.id].shape[current_tetros.rotation]
    local color = tetros[current_tetros.id].color

    drawShape(shape, color, current_tetros.position.x, current_tetros.position.y)

    local position_y = 100
    local sHeight = fontScore:getHeight("X") -- Pour ce décaler d'un caractère en hauteur
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("SCORE", 50, position_y)
    position_y = position_y + sHeight
    love.graphics.print(tostring(score), 50, position_y)
    position_y = position_y + sHeight
    position_y = position_y + sHeight
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("LEVEL", 50, position_y)
    position_y = position_y + sHeight
    love.graphics.print(tostring(level), 50, position_y)
    position_y = position_y + sHeight
    position_y = position_y + sHeight
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("LINES", 50, position_y)
    position_y = position_y + sHeight
    love.graphics.print(tostring(total_lines), 50, position_y)
end

-- Affichage du menu
function drawMenu()
    local color
    local id_color = 1
    local sMessage = "Tetris"
    local sWidth = fontMenu:getWidth(sMessage)
    local sHeight = fontMenu:getHeight(sMessage)
    local x = (window.width - sWidth) / 2
    local y = 0

    -- Affichage de la courbe sinusoidale
    for column = 1, sMessage:len() do
        color = tetros[id_color].color
        love.graphics.setColor(color[1], color[2], color[3])
        local char = string.sub(sMessage, column, column)
        y = math.sin((x + menuSin) / 50) * 30 -- 30 = amplitude
        love.graphics.print(char, x, y + (window.height - sHeight) / 3)
        x = x + fontMenu:getWidth(char)
        id_color = id_color + 1
        if id_color > #tetros then
            id_color = 1
        end
    end

    -- Afficahge des instructions
    sMessage = "PRESS ENTER"
    sWidth = fontMenu:getWidth(sMessage)
    sHeight = fontMenu:getHeight(sMessage)

    love.graphics.setColor(255, 255, 255)
    love.graphics.print(sMessage, (window.width - sWidth) / 2, (window.height - sHeight) / 1.5)
end

-- Afficahge de l'écran "GameOver"
function drawGameOver()
    local sMessage = "GAME OVER"
    local sWidth = fontMenu:getWidth(sMessage)
    local sHeight = fontMenu:getHeight(sMessage)

    love.graphics.setColor(255, 255, 255)
    love.graphics.print(sMessage, (window.width - sWidth) / 2, (window.height - sHeight) / 2)
end

function love.load()

    -- Attribution de la seed random
    math.randomseed(os.time())

    -- Fenêtre
    window.width = love.graphics.getWidth()
    window.height = love.graphics.getHeight()

    love.window.setTitle("Tetris | Classic")

    -- Polices
    fontMenu = love.graphics.newFont("assets/fonts/blocked.ttf", 50)
    fontScore = love.graphics.newFont("assets/fonts/blocked.ttf", 30)
    fontPlay = love.graphics.newFont("assets/fonts/blocked.ttf", 30)

    -- Sons
    sndMusicMenu = love.audio.newSource("assets/sounds/tetris-gameboy-01.mp3", "stream")
    sndMusicMenu:setLooping(true)
    sndMusicMenu:setVolume(.1)

    sndMusicGame = love.audio.newSource("assets/sounds/tetris-gameboy-02.mp3", "stream")
    sndMusicGame:setLooping(true)
    sndMusicGame:setVolume(.1)

    sndMusicGameOver = love.audio.newSource("assets/sounds/tetris-gameboy-04.mp3", "stream")
    sndMusicGameOver:setLooping(true)
    sndMusicGameOver:setVolume(.1)

    sndLine = love.audio.newSource("assets/sounds/line.wav", "static")
    sndLine:setVolume(.5)

    sndLevel = love.audio.newSource("assets/sounds/levelup.wav", "static")
    sndLevel:setVolume(.5)

    -- Touches
    love.keyboard.setKeyRepeat(true)

    startMenu()
end

function love.update(dt)
    if game_state == "menu" then
        updateMenu(dt)
    elseif game_state == "play" then
        updateGame(dt)
    elseif game_state == "game_over" then
    end
end

function love.draw()
    drawGrid()

    if game_state == "menu" then
        drawMenu()
    elseif game_state == "play" then
        drawGame()
    elseif game_state == "game_over" then
        drawGameOver()
    end
end

function love.keypressed(key)
    if game_state == "menu" then
        inputMenu(key)
    elseif game_state == "play" then
        inputGame(key)
    elseif game_state == "game_over" then
        inputGameOver(key)
    end
end