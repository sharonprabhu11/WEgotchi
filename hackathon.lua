--HACKATHON MINI GAME

local hackathon = {}

function hackathon.load()
    --setting seed
    math.randomseed(os.time())
    --Sample prompts not what will actually be used
    hackathon.prompts = {
        {
            choices = {"Planning", "Integration", "Testing", "Game Logic Development"},
            correctOrder = {"Planning", "Game Logic Development", "Integration", "Testing"}
        },
        {
            choices = {"Design", "Prototyping", "Implementation", "Review"},
            correctOrder = {"Design", "Prototyping", "Implementation", "Review"}
        },
        {
            choices = {"Idea Generation", "Market Research", "Development", "Launch"},
            correctOrder = {"Idea Generation", "Market Research", "Development", "Launch"}
        }
    }

    hackathon.currentPrompt = hackathon.prompts[math.random(#hackathon.prompts)]
    hackathon.currentOrder = {}
    hackathon.isRunning = true
end

function hackathon.showChoices()
    print("Arrange the steps in the correct order:")
    for i, choice in ipairs(hackathon.currentPrompt.choices) do
        print(i .. ". " .. choice)
    end
end

function hackathon.getInput()
    print("Enter the order of the steps by number (eg:1 2 3 4):")
    local input = io.read()
    hackathon.currentOrder = {}
    for num in input:gmatch("%d") do
        table.insert(hackathon.currentOrder, hackathon.currentPrompt.choices[tonumber(num)])
    end
end

function hackathon.checkOrder()
    for i, choice in ipairs(hackathon.currentPrompt.correctOrder) do
        if hackathon.currentOrder[i] ~= choice then
            return false
        end
    end
    return true
end

function hackathon.run()
    hackathon.load()
    while hackathon.isRunning do
        hackathon.showChoices()
        hackathon.getInput()
        if hackathon.checkOrder() then
            print("Great job! You've arranged the steps correctly.")
            hackathon.isRunning = false
        else
            print("The order is incorrect. Please try again.")
        end
    end
end

return hackathon
