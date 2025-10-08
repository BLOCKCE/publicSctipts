-- Brute-force tester (for OWN game only). Run in Roblox Studio.
-- Configure below before running.

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Required: the RemoteEvent used by your game to submit passcodes
local PASSCODE_REMOTE = ReplicatedStorage:WaitForChild("Passcode") -- RemoteEvent (FireServer)

-- Optional: a RemoteEvent the server can use to tell the client the attempt succeeded.
-- If you don't have this, the script will still fire attempts but cannot automatically detect success.
local PASSCODE_RESULT_REMOTE = ReplicatedStorage:FindFirstChild("PasscodeResult") -- optional RemoteEvent (OnClientEvent -> result bool, attempted string)

-- === Configuration ===
local config = {
    mode = "numeric",          -- "numeric" | "wordlist" | "custom"
    attemptsPerHeartbeat = 10, -- tries per RunService.Heartbeat (tick). Reduce to be gentler.
    throttleDelaySeconds = 0,  -- additional delay between heartbeats (0 = none)
    maxAttempts = 100000,      -- safety cap to avoid infinite runs
    numeric = { minLen = 1, maxLen = 4 }, -- numeric mode: test 0..9^len-1 with zero padding
    wordlist = {               -- wordlist mode: put the words you want to try here (small example)
        "1234","0000","password","pass","dadwad","letmein"
    },
    customGenerator = nil      -- optional function() -> iterator function() that returns next string or nil
}
-- =======================

-- Safety checks
if config.attemptsPerHeartbeat <= 0 then config.attemptsPerHeartbeat = 1 end
if config.maxAttempts <= 0 then config.maxAttempts = math.huge end

local running = true
local attempts = 0

-- Optional handler to stop when server signals success
if PASSCODE_RESULT_REMOTE then
    PASSCODE_RESULT_REMOTE.OnClientEvent:Connect(function(success, attempted)
        if success then
            print(("Server reported success for password: %s"):format(tostring(attempted)))
            running = false
        end
    end)
end

-- Generator builders
local function makeNumericGenerator(minLen, maxLen)
    -- returns function() -> nextPassword or nil when finished
    local length = minLen
    local current = 0
    local maxForLen = function(len) return 10^len - 1 end

    return function()
        while length <= maxLen do
            if current > maxForLen(length) then
                length = length + 1
                current = 0
            else
                local s = tostring(current)
                if #s < length then
                    s = string.rep("0", length - #s) .. s
                end
                current = current + 1
                return s
            end
        end
        return nil
    end
end

local function makeWordlistGenerator(list)
    local i = 0
    return function()
        i = i + 1
        return list[i]
    end
end

local function makeCustomGenerator(fn)
    -- fn should return an iterator function() -> nextString or nil
    return fn and fn() or function() return nil end
end

-- Set up the generator based on chosen mode
local generator
if config.mode == "numeric" then
    generator = makeNumericGenerator(config.numeric.minLen, config.numeric.maxLen)
elseif config.mode == "wordlist" then
    generator = makeWordlistGenerator(config.wordlist)
elseif config.mode == "custom" then
    if type(config.customGenerator) == "function" then
        generator = makeCustomGenerator(config.customGenerator)
    else
        error("custom mode requires config.customGenerator to be a function that returns an iterator")
    end
else
    error("Unknown mode in config.mode")
end

-- Core attempt loop: uses Heartbeat so it runs once per frame (attemptsPerHeartbeat per frame)
local heartbeatConn
heartbeatConn = RunService.Heartbeat:Connect(function(dt)
    if not running then
        heartbeatConn:Disconnect()
        print("Stopped brute-force tester.")
        return
    end

    for i = 1, config.attemptsPerHeartbeat do
        if not running then break end
        if attempts >= config.maxAttempts then
            print(("Reached maxAttempts (%d). Stopping."):format(config.maxAttempts))
            running = false
            break
        end

        local pwd = generator()
        if not pwd then
            print("Generator exhausted — no more passwords to try.")
            running = false
            break
        end

        -- Fire the passcode RemoteEvent. Passing a single argument (password).
        -- If your game expects a different arg shape, change this line accordingly.
        pcall(function()
            PASSCODE_REMOTE:FireServer(pwd)
        end)

        attempts = attempts + 1
        if attempts % 100 == 0 then
            print(("Attempts: %d (latest: %s)"):format(attempts, tostring(pwd)))
        end
    end

    if config.throttleDelaySeconds > 0 then
        wait(config.throttleDelaySeconds)
    end
end)

print("Brute-force tester started. mode=", config.mode, " attemptsPerHeartbeat=", config.attemptsPerHeartbeat)
