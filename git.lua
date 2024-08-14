local args = {...}

-- Manually specify git repo. Very tedious...
local repoName = "automatey"
local repoURL = "https://raw.githubusercontent.com/Samwhamtymam/automatey/main/"
local repoStructure = {
        "README.md",
        "turtle/miner.lua"
}
if fs.isDir(repoName) then
    print("Repo already exists, updating files inside...")
else
    print("Creating repo " .. repoName)
    fs.makeDir(repoName)
end

-- Complete new clone if nothing specified
if #args == 0 then
    print("Cloning entire repo " .. repoURL .. ": ")
    for i = 1,#repoStructure do
        local fDir = repoStructure[i]
        local fPath = fs.combine(repoName, fDir)
        local subDir = fs.combine(repoName, fs.getDir(fDir))
        if not fs.isDir(subDir) then
            print(" - Making new subdirectory: " .. subDir)
            fs.makeDir(subDir)
        end
        local consoleOutput = " - Pulling /" .. subDir .. ": "
        -- Check url
        local goAhead = true
        local url = repoURL .. fDir
        local urlValid, msg = http.checkURL(url)
        if not urlValid then
            consoleOutput = consoleOutput .. "URL INVALID! " .. msg
            goAhead = false
        end
        if not goAhead then
            print(consoleOutput)
        else
            -- Get http response
            local response = http.get(url)
            if not response then
                consoleOutput = consoleOutput .. "Could not connect to URL: Possible 404 error or connection timeout."
                goAhead = false
            elseif type(response) == "string" then
                consoleOutput = consoleOutput .. "Could not connect to URL: " .. response
                goAhead = false
            end
            if not goAhead then
                print(consoleOutput)
            else
                -- Actually do something
                local rawTxt = response.readAll()
                local f = fs.open(fPath, "w")
                f.write(rawTxt)
                f.close()

                consoleOutput = consoleOutput .. "Done!"
                print(consoleOutput)
            end
        end
    end

-- Certain files specified
elseif #args > 0 then

end

-- Update this script
local fPath = "git.lua"
print("Updating this git.lua script:")
local consoleOutput = " - Pulling /" .. fs.combine(repoName, fPath) .. " remote into " .. fPath .. ": "
-- Check url
local goAhead = true
local url = repoURL .. fPath
local urlValid, msg = http.checkURL(url)
if not urlValid then
    consoleOutput = consoleOutput .. "URL INVALID! " .. msg
    goAhead = false
end
if not goAhead then
    print(consoleOutput)
else
    -- Get http response
    local response = http.get(url)
    if not response then
        consoleOutput = consoleOutput .. "Could not connect to URL: Possible 404 error or connection timeout."
        goAhead = false
    elseif type(response) == "string" then
        consoleOutput = consoleOutput .. "Could not connect to URL: " .. response
        goAhead = false
    end
    if not goAhead then
        print(consoleOutput)
    else
        -- Actually do something
        local rawTxt = response.readAll()
        local f = fs.open(fPath, "w")
        f.write(rawTxt)
        f.close()

        consoleOutput = consoleOutput .. "Done!"
        print(consoleOutput)
    end
end
