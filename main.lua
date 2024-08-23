local intro = require("intro")
local icon = require("icons")
local animation = require("animation")
local hunger = require("hunger_meter")
local energy = require("energy_meter")
local happy = require("happiness_meter")
local eat = require("eat")
local med = require("med")
local cleaning = require("cleaning")
local game = require("game")
local saveData = require("saveData")

local background
local pixelFont
local bgnight

local introSource
local mainGameSource
local nightMusicSource


-- Helper function to load and verify audio sources
local function loadAudio(path, type)
    local success, audio = pcall(function()
        return love.audio.newSource(path, type)
    end)
    if success and audio then
        return audio
    else
        print("Error loading audio from " .. path)
        return nil
    end
end

function love.load()
    love.window.setMode(1600, 1033)
    love.window.setTitle("WEP✨")

    pixelFont = love.graphics.newFont("assets/fonts/pixelfont.otf", 20)

   

    -- Load assets and initialize modules
    intro.load(pixelFont)
    icon.load()
    animation.load()
    hunger.load()
    energy.load()
    happy.load()
    eat.load()
    med.load()
    cleaning.load()
    game.load()

    -- Load and verify audio sources
    local introMusic = 'audio/intro.mp3'
    local buttonMusic = 'audio/button.wav'
    local mainGameMusic = 'audio/maingame.mp3'
    local nightMusic = 'audio/snoring.mp3'

    introSource = loadAudio(introMusic, "stream")
    if introSource then
        introSource:setLooping(true)
        love.audio.play(introSource)
    end

    mainGameSource = loadAudio(mainGameMusic, "stream")
    if mainGameSource then
        mainGameSource:setLooping(true)
    end

    nightMusicSource = loadAudio(nightMusic, "stream")
    if nightMusicSource then
        nightMusicSource:setLooping(true)
    end

    background = love.graphics.newImage("assets/background.png")
    bgnight = love.graphics.newImage("assets/bgnight.png")

    local savedData = saveData.loadData()
    if savedData then
        local currentTime = os.time()
        local elapsedTime = currentTime - savedData.time

        hunger.setPercentage(savedData.hungerPercent, elapsedTime)
        energy.setPercentage(savedData.energyPercent, elapsedTime)
        happy.setPercentage(savedData.happyPercent, elapsedTime)
    end
end

function love.update(dt)
    if intro.isActive() then
        intro.update(dt)
    else
        if introSource and introSource:isPlaying() then
            introSource:stop()
            if mainGameSource then
                mainGameSource:play()
            end
        end

        if not icon.isLightOn() then
            if not nightMusicSource or not nightMusicSource:isPlaying() then
                if mainGameSource and mainGameSource:isPlaying() then
                    mainGameSource:pause()
                end
                if nightMusicSource then
                    nightMusicSource:play()
                end
            end
        else
            if nightMusicSource and nightMusicSource:isPlaying() then
                nightMusicSource:stop()
                if mainGameSource then
                    mainGameSource:play()
                end
            end
        end

        animation.update(dt)
        hunger.update(dt)
        energy.update(dt)
        happy.update(dt)
        eat.update(dt)
        med.update(dt)
        cleaning.update(dt) 
        game.update(dt)
    end
end

function love.draw()
    if intro.isActive() then
        love.graphics.clear(1, 1, 0.8)
        intro.draw()
    else
        if icon.isLightOn() then
            love.graphics.draw(background, 0, 0)
        else
            love.graphics.draw(bgnight, 0, 0) 
        end

        icon.draw()
        animation.draw()
        hunger.draw()
        energy.draw()
        happy.draw()
        eat.draw()
        med.draw()
        cleaning.draw()
        game.draw()

        love.graphics.setFont(pixelFont)
    end
end

function love.mousepressed(x, y, button)
    if intro.isActive() then
        intro.mousepressed(x, y, button)
    else
        if x >= icon.OKButton.x and x <= icon.OKButton.x + icon.OKButton.width and
           y >= icon.OKButton.y and y <= icon.OKButton.y + icon.OKButton.height then
            icon.stopMainGameMusic()
        end

        icon.mousepressed(x, y, button)
        local buttonMusicSource = loadAudio('audio/button.wav', "static")
        if buttonMusicSource then
            love.audio.play(buttonMusicSource)
        end

        if icon.isEatIconClicked() then
            eat.start()
        end
    end
end

function love.quit()
    local data = {
        time = os.time(),
        hungerPercent = hunger.percentage(),
        energyPercent = energy.percentage(),
        happyPercent = happy.percentage()
    }
    saveData.saveData(data)
end
