-- Simple brute-force sender (OWN GAME ONLY). Run in Roblox Studio (Play Solo).
-- Very simple: sends every combination (charset, minLen..maxLen) to ReplicatedStorage.Passcode

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PASSCODE_REMOTE = ReplicatedStorage:WaitForChild("Passcode") -- RemoteEvent in your game

-- ==== CONFIG ====
local config = {
    charset = { "0","1","2","3","4","5","6","7","8","9" }, -- characters to use
    minLen = 1,
    maxLen = 4,
    attemptsPerHeartbeat = 50, -- how many sends per Heartbeat (tick). Reduce if needed.
    maxAttempts = 1000000,     -- overall cap (safety)
}
-- ================

-- basic sanity
if config.minLen < 1 then config.minLen = 1 end
if config.maxLen < config.minLen then config.maxLen = config.minLen end
if config.attemptsPerHeartbeat < 1 then config.attemptsPerHeartbeat = 1 end

local charset = config.charset
local base = #charset

-- generator state: current length and index array representing base-N number
local curLen = config.minLen
local indices = {} -- 1-based indices into charset, store 1..base
for i = 1, curLen do indices[i] = 1 end

local attempts = 0
local running = true

-- helper: build string from indices
local function buildFromIndices()
    local parts = {}
    for i = 1, #indices do
        parts[i] = charset[indices[i]]
    end
    return table.concat(parts)
end

-- helper: advance indices like a base-N counter; returns true if we produced a new combo, false if exhausted
local function advance()
    -- increment least-significant position (rightmost, index #indices)
    local pos = #indices
    while pos >= 1 do
        indices[pos] = indices[pos] + 1
        if indices[pos] <= base then
            return true
        else
            -- carry
            indices[pos] = 1
            pos = pos - 1
        end
    end

    -- if we carried past the most significant digit, increase length if allowed
    if curLen < config.maxLen then
        curLen = curLen + 1
        indices = {}
        for i = 1, curLen do indices[i] = 1 end
        return true
    end

    -- exhausted
    return false
end

-- Optional: if you add a PasscodeResult RemoteEvent on server that fires (success, attempted),
-- it can tell the client to stop. If not present, this script will keep going until exhausted or maxAttempts.
local PASSCODE_RESULT = ReplicatedStorage:FindFirstChild("PasscodeResult")
if PASSCODE_RESULT then
    PASSCODE_RESULT.OnClientEvent:Connect(function(success, attempted)
        if success then
            print("Server reported success for:", tostring(attempted))
            running = false
        end
    end)
end

-- send loop on Heartbeat
local hbConn
hbConn = RunService.Heartbeat:Connect(function()
    if not running then
        hbConn:Disconnect()
        print("Stopped.")
        return
    end

    for i = 1, config.attemptsPerHeartbeat do
        if not running then break end
        if attempts >= config.maxAttempts then
            print("Reached maxAttempts cap. Stopping.")
            running = false
            break
        end

        local candidate = buildFromIndices()
        -- Fire to the server. Wrap in pcall to avoid script-breaking errors.
        local success, err = pcall(function()
            PASSCODE_REMOTE:FireServer(candidate)
        end)
        if not success then
            warn("Failed to FireServer:", err)
        end

        attempts = attempts + 1
        if attempts % 1000 == 0 then
            print(string.format("Attempts: %d (latest: %s)", attempts, candidate))
        end

        -- advance to next combo; if none left, stop
        if not advance() then
            print("Generator exhausted. Done.")
            running = false
            break
        end
    end
end)

print("Brute-force sender started. Charset size:", base, "minLen:", config.minLen, "maxLen:", config.maxLen)
