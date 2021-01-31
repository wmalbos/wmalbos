local Ball = {}

Ball.DEFAULT = {
    WIDTH = 20,
    HEIGHT = 20,
    SPEED_X = 2,
    SPEED_Y = 2
}

function Ball.createBall(_x, _y, _width, _height, _speedX, _speedY)

    local newBall = {}

    newBall.x = _x
    newBall.y = _y
    newBall.width = _width or Ball.DEFAULT.WIDTH
    newBall.height = _height or Ball.DEFAULT.HEIGHT
    newBall.speedX = _speedX or Ball.DEFAULT.SPEED_X
    newBall.speedY = _speedY or Ball.DEFAULT.SPEED_Y

    return newBall

end

function Ball.move(_ball, _pads, _padsCounter)

    _ball.x = _ball.x + _ball.speedX
    _ball.y = _ball.y + _ball.speedY


    if _ball.x < 0 then
        _ball.speedX = _ball.speedX * -1
    end

    if _ball.x > love.graphics.getWidth() - _ball.width then
        _ball.speedX = _ball.speedX * -1
    end

    if _ball.y < 0 then
        _ball.speedY = _ball.speedY * -1
    end

    if _ball.y > love.graphics.getHeight() - _ball.height then
        _ball.speedY = _ball.speedY * -1
    end


    for i = 1, _padsCounter do

        local pad = _pads[i - 1]

        if _ball.x <= pad.x + pad.width and _ball.x >= pad.x then
            if _ball.y + _ball.height > pad.y and _ball.y < pad.y + pad.height then
                _ball.speedX = _ball.speedX * -1
            end
        end

        if _ball.x + _ball.width  <= pad.x + pad.width and _ball.x + _ball.width  >= pad.x then
            if _ball.y + _ball.height > pad.y and _ball.y < pad.y + pad.height then
                _ball.speedX = _ball.speedX * -1
            end
        end

    end
end


function Ball.draw(_ball)

    love.graphics.rectangle("fill", _ball.x, _ball.y, _ball.width, _ball.height)

end

return Ball