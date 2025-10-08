-- Fixed-length (6) brute-force sender (OWN GAME ONLY). Run in Roblox Studio (Play Solo).
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PASSCODE_REMOTE = ReplicatedStorage:WaitForChild("Passcode") -- RemoteEvent in your game

-- ===== CONFIG =====
local LENGTH = 6                       -- fixed length to test
local attemptsPerHeartbeat = 50        -- how many FireServer calls per Heartbeat (lower = gentler)
local maxAttempts = 5000000            -- absolute cap (set to a safe number during development)
-- charset: lower, upper, digits, and common symbols (includes . ! - and others)
local charset = {}
local function add(s)
    for i = 1, #s do table.insert(charset, s:sub(i,i)) end
end

add("abcdefghijklmnopqrstuvwxyz")    -- lowercase
add("ABCDEFGHIJKLMNOPQRSTUVWXYZ")    -- uppercase
add("0123456789")                    -- digits
add("._-!")                          -- requested dot, underscore, dash, exclamation
add("@#%&*()[]{}<>:;,+/?\\|~^$`'\"")  -- additional common symbols you may want
-- ===================

-- sanity
if LENGTH < 1 then LENGTH = 1 end
if attemptsPerHeartbeat < 1 then attemptsPerHeartbeat = 1 end
if maxAttempts < 1 then maxAttempts = math.huge end

local base = #charset
if base == 0 then error("Charset empty") end

-- create index array for fixed LENGTH, initial all 1 (first char)
local indices = {}
for i = 1, LENGTH do indices[i] = 1 end

local function buildFromIndices()
    local t = {}
    for i = 1, #indices do t[i] = charset[indices[i]] end
    return table.concat(t)
end

-- advance indices like a base-N counter; returns true if new combo ready, false if exhausted
local function advance()
    local pos = #indices
    while pos >= 1 do
        indices[pos] = indices[pos] + 1
        if indices[pos] <= base then
            return true
        else
            indices[pos] = 1
            pos = pos - 1
        end
    end
    return false -- exhausted all LENGTH-length combos
end

-- optional server feedback event to stop when server says success
local PASSCODE_RESULT = ReplicatedStorage:FindFirstChild("PasscodeResult")
local running = true
if PASSCODE_RESULT then
    PASSCODE_RESULT.OnClientEvent:Connect(function(success, attempted)
        if success then
            print("Server reported success for:", tostring(attempted))
            running = false
        end
    end)
end

-- send loop
local attempts = 0
local hbConn
hbConn = RunService.Heartbeat:Connect(function()
    if not running then
        hbConn:Disconnect()
        print("Stopped.")
        return
    end

    for i = 1, attemptsPerHeartbeat do
        if not running then break end
        if attempts >= maxAttempts then
            print("Reached maxAttempts cap. Stopping.")
            running = false
            break
        end

        local candidate = buildFromIndices()
        local ok, err = pcall(function() PASSCODE_REMOTE:FireServer(candidate) end)
        if not ok then warn("FireServer error: ", err) end

        attempts = attempts + 1
        if attempts % 1000 == 0 then
            print(("Attempts: %d  latest: %s"):format(attempts, candidate))
        end

        if not advance() then
            print("Generator exhausted. Done.")
            running = false
            break
        end
    end
end)

print(("Started brute-force: charset=%d chars, length=%d, attemptsPerHeartbeat=%d"):format(base, LENGTH, attemptsPerHeartbeat))
