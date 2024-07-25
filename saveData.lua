local json = require('dkjson')

local function saveData(data)
    local file = io.open("save_data.txt", "w")
    if file then
        file:write(json.encode(data))
        file:close()
    else
        print("Error: Could not open save_data.txt for writing.")
    end
end

local function loadData()
    local file = io.open("save_data.txt", "r")
    if file then
        local content = file:read("*a")
        file:close()
        return json.decode(content)
    end
    return nil
end

return {
    saveData = saveData,
    loadData = loadData
}

