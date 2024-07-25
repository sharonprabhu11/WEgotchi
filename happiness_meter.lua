local happy = {}

local icon = require("icons")
local game = require("game")

local happy_meter = {}
local happy_meter_percent = 100
local current_happy_meter_sprite

function happy.load()
    for i = 1, 5 do
        happy_meter[i] = love.graphics.newImage("assets/meters/happiness_meter (" .. i .. ").png")
    end
    current_happy_meter_sprite = happy_meter[1]
end

function happy.update(dt)
    if icon.isGameIconClicked() then
        increaseHappy(100)
        icon.resetGameIconClicked()
    end

    if icon.isCleanIconClicked() then
        increaseHappy(100)
        icon.resetCleanIconClicked()
    end

    local decrease_rate = 2
    happy_meter_percent = happy_meter_percent - dt * decrease_rate
    if happy_meter_percent < 0 then
        happy_meter_percent = 0
    end

    local meter_index = math.ceil((1 - happy_meter_percent / 100) * #happy_meter)
    if meter_index < 1 then
        meter_index = 1
    elseif meter_index > #happy_meter then
        meter_index = #happy_meter
    end

    current_happy_meter_sprite = happy_meter[meter_index]
end

function increaseHappy(amount)
    happy_meter_percent = happy_meter_percent + amount
    if happy_meter_percent > 100 then
        happy_meter_percent = 100
    end
end

function happy.percentage()
    return happy_meter_percent
end

function happy.setPercentage(percent, elapsedTime)
    local decrease_rate_per_second = 2 / 60
    happy_meter_percent = percent - (elapsedTime * decrease_rate_per_second)
    if happy_meter_percent < 0 then
        happy_meter_percent = 0
    elseif happy_meter_percent > 100 then
        happy_meter_percent = 100
    end
end

function happy.draw()
    love.graphics.draw(current_happy_meter_sprite, 1310, 10, 0, 0.85)
end

return happy

