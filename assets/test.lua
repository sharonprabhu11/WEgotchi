local animation = require("animation")

local backgroundImage

local iconSprites = {}
local iconPositions = {}
local iconSelected = 1
local iconScale = 0.35

-- nav button
local buttonLeft = {}
local buttonRight = {}

function love.load()
    love.window.setMode(1600, 1033)
    love.window.setTitle("WEP✨")
    backgroundImage = love.graphics.newImage("assets/background.png")

    animation.load()

    iconSprites = {
        love.graphics.newImage("assets/icons/clean.png"),
        love.graphics.newImage("assets/icons/food.png"),
        love.graphics.newImage("assets/icons/game.png"),
        love.graphics.newImage("assets/icons/medicine.png")
    }

    local iconSpacing = 320
    local iconX = 50
    for i, icon in ipairs(iconSprites) do
        table.insert(iconPositions, { x = iconX, y = 0 })
        iconX = iconX + iconSpacing
    end

    buttonLeft = {
        x = 100,
        y = 900,
        width = 50,
        height = 50
    }

    buttonRight = {
        x = 300,
        y = 900,
        width = 50,
        height = 50
    }
end

function love.update(dt)
    animation.update(dt)
end

function love.draw()
    love.graphics.draw(backgroundImage, 0, 0)
    
    animation.draw()

    for i, icon in ipairs(iconSprites) do
        local scale = iconScale
        if i == iconSelected then
            scale = iconScale * 1.1
        end
        love.graphics.draw(icon, iconPositions[i].x, iconPositions[i].y, 0, scale)
        if i == iconSelected then
            love.graphics.rectangle("line", iconPositions[i].x, iconPositions[i].y, icon:getWidth() * scale, icon:getHeight() * scale)
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", buttonLeft.x, buttonLeft.y, buttonLeft.width, buttonLeft.height)
    love.graphics.printf("<<", buttonLeft.x, buttonLeft.y + buttonLeft.height / 2 - 6, buttonLeft.width, "center")

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", buttonRight.x, buttonRight.y, buttonRight.width, buttonRight.height)
    love.graphics.printf(">>", buttonRight.x, buttonRight.y + buttonRight.height / 2 - 6, buttonRight.width, "center")
end

function love.mousepressed(x, y, button)
    if button == 1 then
        if x >= buttonLeft.x and x <= buttonLeft.x + buttonLeft.width and
           y >= buttonLeft.y and y <= buttonLeft.y + buttonLeft.height then
            iconSelected = iconSelected - 1
            if iconSelected < 1 then
                iconSelected = #iconSprites
            end
        end

        if x >= buttonRight.x and x <= buttonRight.x + buttonRight.width and
           y >= buttonRight.y and y <= buttonRight.y + buttonRight.height then
            iconSelected = iconSelected + 1
            if iconSelected > #iconSprites then
                iconSelected = 1
            end
        end
    end
end
