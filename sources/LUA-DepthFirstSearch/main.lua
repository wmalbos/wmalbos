-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
love.graphics.setDefaultFilter("nearest")

local nb_column = 0
local nb_line = 0
local cs = 10 -- cell_size

local grid = {} -- Grille de l'algorithme
local gridDisplay = {} -- Grille affichée à l'écran
local replay = {} -- Sauvegarde des mouvements

local start_x = 10
local start_y = 10
local currentPos = 0
local waitTimer = 0
local waitSpeed = .1

local explored = 0 -- Nombre de case explorer

-- Options
local option_lines = false
local option_fullscreen = false
local option_final_result = false
local option_stepbystep = false

-- Activation de la case ( pLine, pColumn)
-- Sauvegarde pour le replay
function activeCurrentBlock(pLine, pColumn)
    table.insert(replay, { type = "dig", line = pLine, column = pColumn })
    grid[pLine][pColumn] = "floor"
end

-- Retourne les directions possibles à partir de la case ( pLine, pColumn )
function getNextDirections(pLine, pColumn)
    local freeDirs = {}
    -- test de la direction "up"
    if pLine > 2 then
        if grid[pLine - 2][pColumn] == "wall" then
            table.insert(freeDirs, "up")
        end
    end
    -- test de la direction "right"
    if pColumn < nb_column - 2 then
        if grid[pLine][pColumn + 2] == "wall" then
            table.insert(freeDirs, "right")
        end
    end
    -- test de la direction "bottom"
    if pLine < nb_line - 2 then
        if grid[pLine + 2][pColumn] == "wall" then
            table.insert(freeDirs, "down")
        end
    end
    -- test de la direction "left"
    if pColumn > 2 then
        if grid[pLine][pColumn - 2] == "wall" then
            table.insert(freeDirs, "left")
        end
    end
    return freeDirs
end

-- Algorithme d'exploration de la grille
function explore(pLine, pColumn)
    -- Activation de la case courante
    activeCurrentBlock(pLine, pColumn)
    explored = explored + 1
    -- Exploration des autres chemins à partir de la case courante
    while explored < (nb_line * nb_column) / 2 do
        -- Récupération des directions utilisables
        local next_directions = getNextDirections(pLine, pColumn)
        if #next_directions ~= 0 then
            -- Choix aléatoire de la prochaine direction à prendre
            local direction = next_directions[love.math.random(1, #next_directions)]
            if direction == "up" then
                activeCurrentBlock(pLine - 1, pColumn)
                explore(pLine - 2, pColumn)
            elseif direction == "right" then
                activeCurrentBlock(pLine, pColumn + 1)
                explore(pLine, pColumn + 2)
            elseif direction == "down" then
                activeCurrentBlock(pLine + 1, pColumn)
                explore(pLine + 2, pColumn)
            elseif direction == "left" then
                activeCurrentBlock(pLine, pColumn - 1)
                explore(pLine, pColumn - 2)
            end
        else
            break;
        end
        -- Sauvegarde du block actuel pour le replay
        table.insert(replay, { type = "dig", line = pLine, column = pColumn })
    end
end

function initialize()
    -- Fix the random seed
    --  love.math.setRandomSeed(1)

    explored = 0;
    currentPos = 1;

    grid = {}
    gridDisplay = {}
    replay = {}

    -- On veux un nombre impair de lignes pour éviter d'avoir une colonne vide en bas
    nb_column = math.floor(love.graphics.getWidth() / cs)
    if nb_column % 2 == 0 then nb_column = nb_column  end
    nb_line = math.floor(love.graphics.getHeight() / cs)
    if nb_line % 2 == 0 then nb_line = nb_line  end

    -- Remplissage de la grille
    for line = 1, nb_line do
        grid[line] = {}
        gridDisplay[line] = {}
        for column = 1, nb_column do
            grid[line][column] = "wall"
            gridDisplay[line][column] = "wall"
        end
    end

    -- Exploration
    explore(start_x, start_y)
end


function love.load()
    love.window.setTitle("Algorithme - Parcours en profondeur")
    love.window.setFullscreen(option_fullscreen)
    love.keyboard.setKeyRepeat(true)

    initialize()
end

function love.update(dt)
    if option_stepbystep == false then
        waitTimer = waitTimer + dt
        if currentPos <= #replay - 1 and waitTimer >= waitSpeed then
            waitTimer = 0
            local currentCell = replay[currentPos]
            if currentCell.type == "dig" then
                gridDisplay[currentCell.line][currentCell.column] = "floor"
            elseif currentCell.type == "wall" then
                gridDisplay[currentCell.line][currentCell.column] = "wall"
            end
            currentPos = currentPos + 1
        end
    end
end

function love.draw()

    -- Parcours de la grille
    for line = 1, nb_line do
        for column = 1, nb_column do
            local currentCell = replay[currentPos]
            local cell
            if option_final_result then
                cell = grid[line][column]
            else
                cell = gridDisplay[line][column]
            end

            if cell == "wall" then
                love.graphics.setColor(.5, .5, .5)
                love.graphics.rectangle("fill", cs * (column - 1), cs * (line - 1), cs, cs)
            end

            if cell == "floor" then
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", cs * (column - 1), cs * (line - 1), cs, cs)
            end

            if line == currentCell.line and column == currentCell.column then
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", cs * (column - 1), cs * (line - 1), cs, cs)
            end

            if option_lines then
                love.graphics.setColor(.2, .2, .2)
                love.graphics.line(cs * (column - 1), cs * (line - 1), cs * (column - 1), cs * nb_line)
            end
        end

        if option_lines then
            love.graphics.setColor(.2, .2, .2)
            love.graphics.line(0, cs * (line - 1), cs * nb_column, cs * (line - 1))
        end
    end
end

function love.keypressed(key)

    --      f | Mode plein écran
    --      l | Affichage du quatrillage
    --      p | Affichage du résultat final
    --  space | Mode pas à pas
    --      s | Quitter le mode pas à pas
    -- escape | Quitte l'application

    if key == "space" then
        if currentPos <= #replay - 1 then
            local currentCell = replay[currentPos]
            if currentCell.type == "dig" then
                gridDisplay[currentCell.line][currentCell.column] = "floor"
            elseif currentCell.type == "wall" then
                option_stepbystep = true
                gridDisplay[currentCell.line][currentCell.column] = "wall"
            end
            currentPos = currentPos + 1
        end
    elseif key == "s" then
        option_stepbystep = not option_stepbystep
    elseif key == "f" then
        option_fullscreen = not option_fullscreen
        love.window.setFullscreen(option_fullscreen)
        initialize()
    elseif key == "p" then
        option_final_result = not option_final_result
    elseif key == "l" then
        option_lines = not option_lines
    elseif key == "escape" then
        love.event.quit()
    end
end