local energy = {}

local icon = require("icons")

local energy_meter = {}
local energy_meter_percent = 100
local current_energy_meter_sprite

function energy.load()
    for i = 1, 5 do
        energy_meter[i] = love.graphics.newImage("assets/meters/energy_meter (" .. i .. ").png")
    end
    current_energy_meter_sprite = energy_meter[1]
end

function energy.update(dt)
    if not icon.isLightOn() then
        increaseEnergy(5)
    end

    if icon.isMedIconClicked() then
        increaseEnergy(100)
        icon.resetMedIconClicked()
    end

    local decrease_rate = 2
    energy_meter_percent = energy_meter_percent - dt * decrease_rate
    if energy_meter_percent < 0 then
        energy_meter_percent = 0
    end

    local meter_index = math.ceil((energy_meter_percent / 100) * #energy_meter)
    if meter_index < 1 then
        meter_index = 1
    elseif meter_index > #energy_meter then
        meter_index = #energy_meter
    end

    current_energy_meter_sprite = energy_meter[meter_index]
end

function increaseEnergy(amount)
    energy_meter_percent = energy_meter_percent + amount
    if energy_meter_percent > 100 then
        energy_meter_percent = 100
    end
end

function energy.percentage()
    return energy_meter_percent
end

function energy.draw()
    love.graphics.draw(current_energy_meter_sprite, 1212, 13, 0, 0.85)
end

return energy
