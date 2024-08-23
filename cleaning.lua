local cleaning = {}

local girlSprites = {}
local soapSprites = {}
local bubbleSprites = {}
local happyGirlSprite

local currentGirlSprite
local currentSoapSprite
local currentBubbleSprite
local currentHappyGirlSprite

local girlIndex = 1
local soapIndex = 1
local bubbleIndex = 1

local girlSpeed = 0.2
local soapSpeed = 0.15
local bubbleSpeed = 0.2

local girlTimer = 0
local soapTimer = 0
local bubbleTimer = 0

local showGirl = false
local showSoap = false
local showBubbles = false
local showGirlHappy = false

local cleaningDuration = 3
local cleaningTimer = 0

local jumpYPositions = {}
local jumpTimer = 0
local jumpDuration = 0.75
local jumpIndex = 1

function cleaning.load()
    
    background = love.graphics.newImage("assets/background.png")
    happyGirlSprite = love.graphics.newImage("assets/medicine/healthygirl.png")
    
    for i = 1, 2 do
        table.insert(girlSprites, love.graphics.newImage("assets/newcleaning/girl (" .. i .. ").png"))
    end


    for i = 1, 2 do
        table.insert(soapSprites, love.graphics.newImage("assets/newcleaning/soap (" .. i .. ").png"))
    end

    for i = 1, 3 do
        table.insert(bubbleSprites, love.graphics.newImage("assets/newcleaning/bubble (" .. i .. ").png"))
    end

    currentGirlSprite = girlSprites[1]

    currentSoapSprite = soapSprites[1]
    currentBubbleSprite = bubbleSprites[1]

    -- jump positions array
    satisfiedY = 425  
    
    for y = 425, 325, -5 do
        table.insert(jumpYPositions, y)
    end
    
    for y = 325, 425, 5 do
        table.insert(jumpYPositions, y)
    end
end

function cleaning.start()
    showGirl = true
    showSoap = true
    showBubbles = true
    cleaningTimer = 0
end

function cleaning.update(dt)
    if showGirl or showSoap or showBubbles then
        cleaningTimer = cleaningTimer + dt
        if cleaningTimer >= cleaningDuration then
            showGirl = false
            showSoap = false
            showBubbles = false
            showGirlHappy = true
            jumpTimer = 0
            jumpIndex = 1
        end
    end

    if showGirl then
        girlTimer = girlTimer + dt
        if girlTimer >= girlSpeed then
            girlTimer = girlTimer - girlSpeed
            girlIndex = girlIndex % #girlSprites + 1
            currentGirlSprite = girlSprites[girlIndex]
        end
    end


    if showSoap then
        soapTimer = soapTimer + dt
        if soapTimer >= soapSpeed then
            soapTimer = soapTimer - soapSpeed
            soapIndex = soapIndex % #soapSprites + 1
            currentSoapSprite = soapSprites[soapIndex]
        end
    end

    if showBubbles then
        bubbleTimer = bubbleTimer + dt
        if bubbleTimer >= bubbleSpeed then
            bubbleTimer = bubbleTimer - bubbleSpeed
            bubbleIndex = bubbleIndex % #bubbleSprites + 1
            currentBubbleSprite = bubbleSprites[bubbleIndex]
        end
    end

    if showGirlHappy then
        jumpTimer = jumpTimer + dt
        local progress = jumpTimer / jumpDuration
        local positionIndex = math.floor(progress * (#jumpYPositions - 1)) + 1
        satisfiedY = jumpYPositions[positionIndex]

        if jumpTimer >= jumpDuration then
            showGirlHappy = false  
        end
    end
end

function cleaning.draw()
    if showGirl then
        love.graphics.draw(currentGirlSprite, 550, 425)
    end

    if showSoap then
        love.graphics.draw(currentSoapSprite, 700, 350, 0, 0.5)
    end

    if showBubbles then
        love.graphics.draw(currentBubbleSprite, 600, 430, 0, 0.6)
    end

    if showGirlHappy then
        love.graphics.draw(background, 0, 0)
        love.graphics.draw(happyGirlSprite, 550, satisfiedY)
    end
end

return cleaning

