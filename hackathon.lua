-- hackathon.lua

local hackathon = {}

function hackathon.load()
    hackathon.choices = {"Planning", "Integration", "Testing", "Game Logic Development"}
    hackathon.correctOrder = {"Planning", "Game Logic Development", "Integration", "Testing"}
    hackathon.currentOrder = {}
    hackathon.isRunning = true
end

function hackathon.showChoices()
    print("Arrange the steps in the correct order:")
    for i, choice in ipairs(hackathon.choices) do
        print(i .. ". " .. choice)
    end
end

function hackathon.getInput()
    print("Enter the order of the steps by number (eg: 1 2 3 4):")
    local input = io.read()
    hackathon.currentOrder = {}
    for num in input:gmatch("%d") do
        table.insert(hackathon.currentOrder, hackathon.choices[tonumber(num)])
    end
end

function hackathon.checkOrder()
    for i, choice in ipairs(hackathon.correctOrder) do
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

