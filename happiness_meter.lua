local happiness = {}

local icon = require("icons")

local happiness_meter = {}
local happiness_meter_percent = 100
local current_happiness_meter_sprite

local windowWidth, windowHeight

function happiness.load()
    for i = 1, 5 do
        happiness_meter[i] = love.graphics.newImage("assets/meters/happiness_meter (" .. i .. ").png")
    end
    current_happiness_meter_sprite = happiness_meter[1]
    windowWidth, windowHeight = love.graphics.getDimensions()
end

function happiness.update(dt)
    if icon.isFunIconClicked() then
        increaseHappiness(20)
        icon.resetFunIconClicked()
    end

    local decrease_rate = 1.5
    happiness_meter_percent = happiness_meter_percent - dt * decrease_rate
    if happiness_meter_percent < 0 then
        happiness_meter_percent = 0
    end

    local meter_index = math.ceil((happiness_meter_percent / 100) * #happiness_meter)
    if meter_index < 1 then
        meter_index = 1
    elseif meter_index > #happiness_meter then
        meter_index = #happiness_meter
    end

    current_happiness_meter_sprite = happiness_meter[meter_index]
end

function increaseHappiness(amount)
    happiness_meter_percent = happiness_meter_percent + amount
    if happiness_meter_percent > 100 then
        happiness_meter_percent = 100
    end
end

function happiness.draw()
    love.graphics.push()
    love.graphics.scale(windowWidth / 1920, windowHeight / 1080) -- Assuming original design resolution is 1920x1080
    love.graphics.draw(current_happiness_meter_sprite, 1212, 85, 0, 0.85)
    love.graphics.pop()
end

return happiness

