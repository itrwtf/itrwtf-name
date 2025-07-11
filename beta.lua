--// CLIENT NAME SPOOFER
-- Make sure you're using a Roblox executor (e.g., Synapse X, Fluxus, etc.)
-- This does NOT change your real name server-side or for other players.

--== CONFIGURATION ==--
local fakeUsername = "itr.wtf"
local fakeDisplayName = "itr wtf"

--== SCRIPT ==--
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to spoof names in all detected UI instances
local function spoofNames()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            if obj.Text and (string.find(obj.Text, LocalPlayer.Name) or string.find(obj.Text, LocalPlayer.DisplayName)) then
                obj.Text = obj.Text:gsub(LocalPlayer.Name, fakeUsername)
                obj.Text = obj.Text:gsub(LocalPlayer.DisplayName, fakeDisplayName)
            end
        end
    end
end

-- Leaderboard spoof (if using default player list)
pcall(function()
    local function spoofLeaderboard()
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then
                player.Name = fakeUsername
                player.DisplayName = fakeDisplayName
            end
        end
    end
    spoofLeaderboard()
end)

-- Overhead name tags spoof
local function spoofOverhead()
    for _, obj in ipairs(LocalPlayer.Character:GetDescendants()) do
        if obj:IsA("BillboardGui") or obj:IsA("TextLabel") then
            if obj.Text and (string.find(obj.Text, LocalPlayer.Name) or string.find(obj.Text, LocalPlayer.DisplayName)) then
                obj.Text = obj.Text:gsub(LocalPlayer.Name, fakeUsername)
                obj.Text = obj.Text:gsub(LocalPlayer.DisplayName, fakeDisplayName)
            end
        end
    end
end

-- Hook into character and UI changes
LocalPlayer.CharacterAdded:Connect(function(char)
    wait(1)
    spoofOverhead()
end)

-- Constant update to catch UI changes
game:GetService("RunService").RenderStepped:Connect(function()
    pcall(spoofNames)
end)

-- Initial spoof
spoofNames()
spoofOverhead()

-- Notify in console
print("✅ Name spoof active: "..fakeDisplayName.." ("..fakeUsername..")")
