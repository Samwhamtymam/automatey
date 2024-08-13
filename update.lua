local args = {...}

if #args > 1 then
    print("Please provide a single URL only!")
    return 0
end

local url = args[1]

local urlValid, msg = http.checkURL(url)
if not urlValid then
    error("Invalid URL: " .. msg)
end


-- Get http response

local response = http.get(url)
if not response then
    error("Could not connect to URL. Possible 404 error or connection timeout.")
elseif type(response) == "string" then
    error("Could not connect to URL: " .. response)
end

-- Raw text

local rawTxt = response.readAll()
if not rawTxt then
    print("Could not connect to URL")
    error("Response code: " .. response.getResponseCode())
end

print("Here is the http header:")
print(textutils.serialise(response.getResponseHeaders()))

print("Here is the raw text:")
print(rawTxt)


