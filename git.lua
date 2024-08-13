local args = {...}

local repoURL = "https://raw.githubusercontent.com/Samwhamtymam/automatey/main/"
local repoStructure = {
        "README.md",
        "turtle/miner.lua"
}

if #args == 0 then
    print("Pulling entire repo: " .. repoURL)
    for i = 1,#repoStructure do
        local f = repoStructure[i]
        local consoleOutput = " - Pulling " .. f .. ": "
        -- Check url
        local goAhead = true
        local url = repoURL .. f
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
                --local rawTxt = response.readAll()
                print(consoleOutput .. "Done!")
            end
        end
    end
end 