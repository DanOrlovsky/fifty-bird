CountDownState = Class{ __includes = BaseState }

COUNTDOWN_TIME = 0.75

function CountDownState:init()
    self.count = 3
    self.timer = 0
    self.sounds = {
        ['countdown'] = love.audio.newSource('sounds/countdowntime.wav', 'static'),
        ['start'] = love.audio.newSource('sounds/game_start.wav', 'static')
    }
    self.sounds['countdown']:play()

end

function CountDownState:update(dt)
    self.timer = self.timer + dt
    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1
        if self.count == 0 then
            self.sounds['start']:play()
            gStateMachine:change('play')
        else
            self.sounds['countdown']:play()
        end
    end
end

function CountDownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), 0, 100, VIRTUAL_WIDTH, 'center') 
end