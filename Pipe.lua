Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('pipe.png')

local PIPE_SCROLL = -60

PIPE_HEIGHT = 288
PIPE_WIDTH = 70

function Pipe:init(location, y)
    self.x = VIRTUAL_WIDTH
    self.y = y

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_IMAGE:getHeight()

    self.location = location
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x,
        (self.location == 'top' and self.y + PIPE_HEIGHT or self.y),
        0, 1, self.location == 'top' and -1 or 1)
end