PipePair = Class{}

local PIPE_SPEED = 60

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 32
    self.hasScored = false
    self.y = y
    -- RANDOMIZE PIPE GAP
    local gapSpread = math.random(64, 120)
    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + gapSpread)
    }
    
    self.remove = false
end 

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then 
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else 
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end