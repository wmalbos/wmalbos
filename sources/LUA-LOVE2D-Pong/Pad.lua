local Pad = {}

Pad.DEFAULT = {
    WIDTH = 20,
    HEIGHT = 80,
    X = 0,
    Y = 0
}

-- Création et initialisation d'un PAD
function Pad.createPad(_x, _y, _width, _height)

    local newPad = {}

    newPad.x = _x
    newPad.y = _y
    newPad.width = _width or Pad.DEFAULT.WIDTH
    newPad.height = _height or Pad.DEFAULT.HEIGHT

    return newPad
end

function Pad.down(_pad)

    if _pad.y < love.graphics.getHeight() - _pad.height then
        _pad.y = _pad.y + 2
    end

end

function Pad.up(_pad)

    if _pad.y > 0 then
        _pad.y = _pad.y - 2
    end

end

function Pad.draw(_pad)
    love.graphics.rectangle("fill", _pad.x, _pad.y, _pad.width, _pad.height)
end

return Pad