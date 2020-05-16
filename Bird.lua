
Bird = Class{}

local GRAVITY = 20
local isAlive = true

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height /  2)
    self.sounds = {
        ['bird_jump'] = love.audio.newSource('sounds/birdjump.wav', 'static')
    }
    self.dy = 0
end

function Bird:update(dt)
    if not isAlive then return end
    
    if love.keyboard.wasPressed('space') or 
        love.mouse.wasPressed(1) then
        self.dy = -4
        self.sounds['bird_jump']:play()
    end

    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy 
    if self.y < 0 then 
        self.y = 0
    end

end

function Bird:collides(pipe)
    if(self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end
    return false
end

function Bird:render()
    if isAlive then
        love.graphics.draw(self.image, self.x, self.y)
    end
end