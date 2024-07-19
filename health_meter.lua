local meters = {}

local icon = require("icons")

local health_meter = {}
local health_meter_percent = 100
local current_meter_sprite

function meters.load()
    for i = 1, 5 do
        health_meter[i] = love.graphics.newImage("assets/meters/hunger_meter (" .. i .. ").png")
    end
    current_meter_sprite = health_meter[1]
end

function meters.update(dt)

    if icon.isEatIconClicked() then
        increaseHealth(100)
        icon.resetEatIconClicked()  
    end

    if not icon.isLightOn() then
        increaseHealth(5)
    end

    local decrease_rate = 10
    health_meter_percent = health_meter_percent - dt * decrease_rate
    if health_meter_percent < 0 then
        health_meter_percent = 0
    end

    local meter_index = math.ceil((1 - health_meter_percent / 100) * #health_meter)
    if meter_index < 1 then
        meter_index = 1
    elseif meter_index > #health_meter then
        meter_index = #health_meter
    end

    current_meter_sprite = health_meter[meter_index]
end

function increaseHealth(amount)
    health_meter_percent = health_meter_percent + amount
    if health_meter_percent > 100 then
        health_meter_percent = 100
    end
end

function meters.draw()
    love.graphics.draw(current_meter_sprite, 1125, 13, 0, 0.85)
end

return meters
