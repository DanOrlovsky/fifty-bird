PlayState = Class{ __includes=BaseState }

function PlayState:init() 
    self.bird = Bird()
    self.pipePairs = {}
    self.spawnTimer = 0
    self.score = 0
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
    self.sounds = {
        ['birdhit'] = love.audio.newSource('sounds/birdhit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static')
    }
end
local randomInterval = 2
function PlayState:update(dt)
    self.spawnTimer = self.spawnTimer + dt
    if self.spawnTimer > randomInterval then
        randomInterval = math.random(1.5, 3) 
        local y = math.max(-PIPE_HEIGHT + 10,
            math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y))
        self.spawnTimer = 0
    end
    
    self.bird:update(dt)

    for k, pair in pairs(self.pipePairs) do
        if not pair.hasScored then
            if self.bird.x > pair.x + PIPE_WIDTH then
                self.score = self.score + 1
                if self.score % 5 == 0 then 
                    self.sounds['score']:play()
                end
                pair.hasScored = true
            end
        end

        pair:update(dt)

        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then 
                self.sounds['birdhit']:play()
                gStateMachine:change('score', {
                    score = self.score
                })
            end
        end

        if pair.remove then 
            table.remove(self.pipePairs, k)
        end
    end
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        self.sounds['birdhit']:play()
        gStateMachine:change('score', {
            score = self.score
        })
    end
end


function PlayState:render()   
    for k, pipe in pairs(self.pipePairs) do
        pipe:render()
    end

    self.bird:render()
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

end