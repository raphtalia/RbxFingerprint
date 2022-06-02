local sha1 = require(script.sha1)

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

print(sha1.sha1(HttpService:JSONEncode({
    -- Any number of data points can be added here
    time = {
        -- CPU start is the main data point used
        cpuStart = math.round(tick() - os.clock()),
        timezone = os.date("%Z"),
        isDST = os.date("*t").isdst,
    },
    device = {
        accelerometerEnabled = UserInputService.AccelerometerEnabled,
        touchEnabled = UserInputService.TouchEnabled,
    },
})))
