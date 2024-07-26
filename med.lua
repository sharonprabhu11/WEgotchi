local med = {}

local pillSprites = {}
local injectionSprites = {}
local girlMedSprites = {}
local healthyGirlSprite

local currentPillSprite
local currentInjectionSprite
local currentGirlMedSprite
local currentHealthyGirlSprite

local pillIndex = 1
local injectionIndex = 1
local girlMedIndex = 1

local pillSpeed = 0.15
local injectionSpeed = 0.15
local girlMedSpeed = 0.2

local pillTimer = 0
local injectionTimer = 0
local girlMedTimer = 0

local showPill = false
local showInjection = false
local showGirlMed = false
local showGirlHealthy = false

local medDuration = 3
local medTimer = 0

local jumpYPositions = {}
local jumpTimer = 0
local jumpDuration = 0.75
local jumpIndex = 1

local ouchSound = '/audio/ouch.mp3'


-- New variables for music management
local mainGameSource
local medGameSource
local ouchSource

function med.load()
    background = love.graphics.newImage("assets/background.png")
    healthyGirlSprite = love.graphics.newImage("assets/medicine/healthygirl.png")
    
    for i = 1, 6 do
        table.insert(pillSprites, love.graphics.newImage("assets/medicine/pill (".. i ..").png"))
    end

    for i = 1, 5 do
        table.insert(injectionSprites, love.graphics.newImage("assets/medicine/injection (" .. i .. ").png"))
    end

    for i = 1, 4 do
        table.insert(girlMedSprites, love.graphics.newImage("assets/medicine/girlmed (" .. i .. ").png"))
    end

    currentPillSprite = pillSprites[1]
    currentInjectionSprite = injectionSprites[1]
    currentGirlMedSprite = girlMedSprites[1]

    -- jump positions array
    satisfiedY = 425  
    
    for y = 425, 325, -5 do
        table.insert(jumpYPositions, y)
    end
    
    for y = 325, 425, 5 do
        table.insert(jumpYPositions, y)
    end

    -- Initialize sound sources
    ouchSource = love.audio.newSource(ouchSound, "static")
end

function med.start(mainGameMusicSource)
    local randomChoice = love.math.random(1, 2)
    
    if randomChoice == 1 then
        showPill = true
    else
        showInjection = true
    end
    
    showGirlMed = true
    medTimer = 0

    -- Pause main game music
    mainGameSource = mainGameMusicSource
    if mainGameSource and mainGameSource:isPlaying() then
        mainGameSource:pause()
    end

    -- Play ouch sound
    ouchSource:play()

    
  
end

function med.update(dt)
    if showPill or showInjection or showGirlMed then
        medTimer = medTimer + dt
        if medTimer >= medDuration then
            showPill = false
            showInjection = false
            showGirlMed = false
            showGirlHealthy = true
            jumpTimer = 0
            jumpIndex = 1

            -- Stop medical game music
            if medGameSource then
                medGameSource:stop()
            end

            -- Resume main game music
            if mainGameSource then
                mainGameSource:play()
            end
        end
    end

    if showPill then
        pillTimer = pillTimer + dt
        if pillTimer >= pillSpeed then
            pillTimer = pillTimer - pillSpeed
            pillIndex = pillIndex % #pillSprites + 1
            currentPillSprite = pillSprites[pillIndex]
        end
    end

    if showInjection then
        injectionTimer = injectionTimer + dt
        if injectionTimer >= injectionSpeed then
            injectionTimer = injectionTimer - injectionSpeed
            injectionIndex = injectionIndex % #injectionSprites + 1
            currentInjectionSprite = injectionSprites[injectionIndex]
        end
    end

    if showGirlMed then
        girlMedTimer = girlMedTimer + dt
        if girlMedTimer >= girlMedSpeed then
            girlMedTimer = girlMedTimer - girlMedSpeed
            girlMedIndex = girlMedIndex % #girlMedSprites + 1
            currentGirlMedSprite = girlMedSprites[girlMedIndex]
        end
    end

    if showGirlHealthy then
        jumpTimer = jumpTimer + dt
        local progress = jumpTimer / jumpDuration
        local positionIndex = math.floor(progress * (#jumpYPositions - 1)) + 1
        satisfiedY = jumpYPositions[positionIndex]

        if jumpTimer >= jumpDuration then
            showGirlHealthy = false  
        end
    end
end

function med.draw()
    if showGirlMed then
        love.graphics.draw(background, 0, 0)
        love.graphics.draw(currentGirlMedSprite, 550, 425)
    end

    if showPill then
        love.graphics.draw(currentPillSprite, 910, 600, 0, 0.15)
    end

    if showInjection then
        love.graphics.draw(currentInjectionSprite, 900, 600, 0, 0.15)
    end

    if showGirlHealthy then
        love.graphics.draw(background, 0, 0)
        love.graphics.draw(healthyGirlSprite, 550, satisfiedY)
    end
end

return med
