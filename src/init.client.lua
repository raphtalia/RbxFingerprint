local sha1 = require(script.sha1)

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local function round(x, y)
    return math.round(x / y) * y
end

print(sha1.sha1(HttpService:JSONEncode({
    -- Any number of data points can be added here
    time = {
        -- CPU start is the main data point used
        cpuStart = round(tick() - os.clock(), 5),
        timezone = os.date("%Z"),
        isDST = os.date("*t").isdst,
    },
    device = {
        accelerometerEnabled = UserInputService.AccelerometerEnabled,
        touchEnabled = UserInputService.TouchEnabled,
    },
})))
