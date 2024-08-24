local eat = {}

local chaiSprites = {}
local cookiesSprites = {}
local girlEatSprites = {}
local satisfiedGirlSprite

local currentChaiSprite
local currentCookiesSprite
local currentGirlEatSprite
local currentSatisfiedGirlSprite

local chaiIndex = 1
local cookiesIndex = 1
local girlEatIndex = 1

local chaiSpeed = 0.15
local cookiesSpeed = 0.15
local girlEatSpeed = 0.2

local chaiTimer = 0
local cookiesTimer = 0
local girlEatTimer = 0

local showChai = false
local showCookies = false
local showGirlEat = false
local showGirlSatisfied = false

local eatDuration = 3
local eatTimer = 0

local jumpYPositions = {}
local jumpTimer = 0
local jumpDuration = 0.75
local jumpIndex = 1

local eatSound = '/audio/eating.mp3'
local eatSoundSource = nil

function eat.load()
    background = love.graphics.newImage("assets/background.png")
    satisfiedGirlSprite = love.graphics.newImage("assets/eat/satisfied.png")

    for i = 1, 4 do
        table.insert(chaiSprites, love.graphics.newImage("assets/eat/chai (" .. i .. ").png"))
    end

    for i = 1, 6 do
        table.insert(cookiesSprites, love.graphics.newImage("assets/eat/cookie (" .. i .. ").png"))
    end

    for i = 1, 4 do
        table.insert(girlEatSprites, love.graphics.newImage("assets/eat/girl_eat (" .. i .. ").png"))
    end

    currentChaiSprite = chaiSprites[1]
    currentCookiesSprite = cookiesSprites[1]
    currentGirlEatSprite = girlEatSprites[1]

    -- jump positions array
    satisfiedY = 425  

    for y = 425, 325, -5 do
        table.insert(jumpYPositions, y)
    end

    for y = 325, 425, 5 do
        table.insert(jumpYPositions, y)
    end
end

function eat.start()
    local randomChoice = love.math.random(1, 2)
    
    if randomChoice == 1 then
        showChai = true
    else
        showCookies = true
    end
    
    showGirlEat = true
    eatTimer = 0


    if mainGameSource and mainGameSource:isPlaying() then
        mainGameSource:pause()
    end

    if not eatSoundSource or not eatSoundSource:isPlaying() then
        eatSoundSource = love.audio.newSource(eatSound, "stream")
        eatSoundSource:setLooping(true)
        eatSoundSource:play()
    end
end

function eat.update(dt)
    if showChai or showCookies or showGirlEat then
        eatTimer = eatTimer + dt
        if eatTimer >= eatDuration then
            showChai = false
            showCookies = false
            showGirlEat = false
            showGirlSatisfied = true
            jumpTimer = 0
            jumpIndex = 1

            if eatSoundSource and eatSoundSource:isPlaying() then
                eatSoundSource:stop()
            end

            if mainGameSource then
                mainGameSource:play()
            end
        end
    end

    if showChai then
        chaiTimer = chaiTimer + dt
        if chaiTimer >= chaiSpeed then
            chaiTimer = chaiTimer - chaiSpeed
            chaiIndex = chaiIndex % #chaiSprites + 1
            currentChaiSprite = chaiSprites[chaiIndex]
        end
    end

    if showCookies then
        cookiesTimer = cookiesTimer + dt
        if cookiesTimer >= cookiesSpeed then
            cookiesTimer = cookiesTimer - cookiesSpeed
            cookiesIndex = cookiesIndex % #cookiesSprites + 1
            currentCookiesSprite = cookiesSprites[cookiesIndex]
        end
    end

    if showGirlEat then
        girlEatTimer = girlEatTimer + dt
        if girlEatTimer >= girlEatSpeed then
            girlEatTimer = girlEatTimer - girlEatSpeed
            girlEatIndex = girlEatIndex % #girlEatSprites + 1
            currentGirlEatSprite = girlEatSprites[girlEatIndex]
        end
    end

    if showGirlSatisfied then
        jumpTimer = jumpTimer + dt
        local progress = jumpTimer / jumpDuration
        local positionIndex = math.floor(progress * (#jumpYPositions - 1)) + 1
        satisfiedY = jumpYPositions[positionIndex]

        if jumpTimer >= jumpDuration then
            showGirlSatisfied = false  
        end
    end
end

function eat.draw()
    if showGirlEat then
        love.graphics.draw(background, 0, 0)
        love.graphics.draw(currentGirlEatSprite, 550, 425)
    end

    if showChai then
        love.graphics.draw(currentChaiSprite, 910, 600, 0, 0.15)
    end

    if showCookies then
        love.graphics.draw(currentCookiesSprite, 900, 600, 0, 0.15)
    end

    if showGirlSatisfied then
        love.graphics.draw(background, 0, 0)
        love.graphics.draw(satisfiedGirlSprite, 550, satisfiedY)
    end
end

return eat
