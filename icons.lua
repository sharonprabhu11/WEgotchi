local icon = {}

local iconSprites = {}
local iconPositions = {}
local iconSelected = 1
local iconScale = 0.35

local buttonLeft = {
    x = 100,
    y = 900,
    width = 50,
    height = 50
}

local buttonRight = {
    x = 300,
    y = 900,
    width = 50,
    height = 50
}

function icon.load()
    iconSprites = {
        love.graphics.newImage("assets/icons/clean.png"),
        love.graphics.newImage("assets/icons/food.png"),
        love.graphics.newImage("assets/icons/game.png"),
        love.graphics.newImage("assets/icons/medicine.png")
    }

    local iconSpacing = 320
    local iconX = 50
    for i, iconImg in ipairs(iconSprites) do
        table.insert(iconPositions, { x = iconX, y = 0 })
        iconX = iconX + iconSpacing
    end
end

function icon.draw()
    for i, iconImg in ipairs(iconSprites) do
        local scale = iconScale
        if i == iconSelected then
            scale = iconScale * 1.1
        end
        love.graphics.draw(iconImg, iconPositions[i].x, iconPositions[i].y, 0, scale)
        if i == iconSelected then
            love.graphics.rectangle("line", iconPositions[i].x, iconPositions[i].y + 10, iconImg:getWidth() * scale, iconImg:getHeight() * scale)
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", buttonLeft.x, buttonLeft.y, buttonLeft.width, buttonLeft.height)

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", buttonRight.x, buttonRight.y, buttonRight.width, buttonRight.height)
end

function icon.selectNext()
    iconSelected = iconSelected + 1
    if iconSelected > #iconSprites then
        iconSelected = 1
    end
end

function icon.selectPrevious()
    iconSelected = iconSelected - 1
    if iconSelected < 1 then
        iconSelected = #iconSprites
    end
end

function icon.mousepressed(x, y, button)
    if button == 1 then
        if x >= buttonLeft.x and x <= buttonLeft.x + buttonLeft.width and
           y >= buttonLeft.y and y <= buttonLeft.y + buttonLeft.height then
            icon.selectPrevious()
        end

        if x >= buttonRight.x and x <= buttonRight.x + buttonRight.width and
           y >= buttonRight.y and y <= buttonRight.y + buttonRight.height then
            icon.selectNext()
        end
    end
end

return icon
