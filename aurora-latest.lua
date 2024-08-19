-- AURORA REV2 - DISTRIBUTE!!!
-- You can add whatever you want to this, but name it so it differenciates from our versions!
-- We luv Celery 
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Aurora Mod Menu Ultimate", HidePremium = false, IntroText = "Aurora", SaveConfig = true, ConfigFolder = "Aurora"})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local targetPlayerName = ""
local FlingTarget = ""

-- defs from fling script end

local lp = game:FindService("Players").LocalPlayer

local function gplr(String)
	local Found = {}
	local strl = String:lower()
	if strl == "all" then
		for i,v in pairs(game:FindService("Players"):GetPlayers()) do
			table.insert(Found,v)
		end
	elseif strl == "others" then
		for i,v in pairs(game:FindService("Players"):GetPlayers()) do
			if v.Name ~= lp.Name then
				table.insert(Found,v)
			end
		end 
	elseif strl == "me" then
		for i,v in pairs(game:FindService("Players"):GetPlayers()) do
			if v.Name == lp.Name then
				table.insert(Found,v)
			end
		end 
	else
		for i,v in pairs(game:FindService("Players"):GetPlayers()) do
			if v.Name:lower():sub(1, #String) == String:lower() then
				table.insert(Found,v)
			end
		end 
	end
	return Found 
end

local function notif(str,dur)
	game:FindService("StarterGui"):SetCore("SendNotification", {
		Title = "Aurora: yeet gui",
		Text = str,
		Icon = "rbxassetid://2005276185",
		Duration = dur or 3
	})
end

-- defs from fling script end







local MoveTab = Window:MakeTab({
	Name = "Fly & TP",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local AdminTab = Window:MakeTab({
	Name = "Admin + Utilities",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local CharacterTab = Window:MakeTab({
	Name = "Character",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local FunTab = Window:MakeTab({
    Name = "Fun Hacks",
    Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local SettingTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local AdminSection = AdminTab:AddSection({
	Name = "Admin"
})

local CctrSection = CharacterTab:AddSection({
	Name = "Character"
})

local tps = MoveTab:AddSection({
	Name = "Teleportation"
})

local esp = AdminTab:AddSection({
	Name = "ESP"
})

local fs = MoveTab:AddSection({
	Name = "Flight and Noclip"
})

local ss = SettingTab:AddSection({
    Name = "Options"
})

local fef = FunTab:AddSection({
	Name = "FE Fling (Trollface edition)"
})

local bts = FunTab:AddSection({
	Name = "Building tools"
})

local EplrSection = AdminTab:AddSection({
	Name = "Explorer"
})

local infjmpConnection

MoveTab:AddToggle({ 
	Name = "Fly (Infinite Jump)",
	Default = false,
	Callback = function(Value)
        if Value then
            infjmpConnection = game:GetService("UserInputService").jumpRequest:Connect(function()
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass"Humanoid":ChangeState("Jumping")
            end)
        else
            if infjmpConnection then
                infjmpConnection:Disconnect()
                infjmpConnection = nil
            end
        end
	end    
})







CctrSection:AddSlider({
	Name = "Walkspeed",
	Min = 0,
	Max = 100,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

CctrSection:AddSlider({
	Name = "JumpPower",
	Min = 0,
	Max = 100,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

CctrSection:AddSlider({
	Name = "Gravity",
	Min = -50,
	Max = 300,
	Default = 196,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "studs/s2",
	Callback = function(Value)
		Workspace.Gravity = Value
	end    
})


-- FlySection:AddLabel("Teleportation")
tps:AddTextbox({
	Name = "Target",
	Default = "Label",
	TextDisappear = false,
	Callback = function(Value)
		targetPlayerName = Value
	end	  
})


tps:AddButton({
    Name = "Teleport To Player",
    Callback = function()
        -- Find the target player

		local targetPlayer = gplr(targetPlayerName)
		if targetPlayer[1] then
			targetPlayer = targetPlayer[1]
		end
        if targetPlayer then
            local targetCharacter = targetPlayer.Character
            local localCharacter = LocalPlayer.Character

            if targetCharacter and localCharacter then
                -- Find the HumanoidRootPart of both characters
                local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
                local localHumanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
                if targetHumanoidRootPart and localHumanoidRootPart then
                    -- Move the local player's HumanoidRootPart to the target player's HumanoidRootPart position
                    localHumanoidRootPart.CFrame = targetHumanoidRootPart.CFrame
                end
            end
        end   
    end    
})

-- FlySection:AddLabel("Teleportation")
fef:AddTextbox({
	Name = "Fling Target",
	Default = "annoying_kid69",
	TextDisappear = false,
	Callback = function(Value)
		FlingTarget = Value -- Replace with the target player's name
	end	  
})


fef:AddButton({
    Name = "Cheese em'", -- memorial for that one fe fling gui with trollface 
    Callback = function()
		local Target = gplr(FlingTarget)
		if Target[1] then
		Target = Target[1]
		
		local Thrust = Instance.new('BodyThrust', lp.Character.HumanoidRootPart)
		Thrust.Force = Vector3.new(9999,9999,9999)
		Thrust.Name = "YeetForce"
		repeat
			lp.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
			Thrust.Location = Target.Character.HumanoidRootPart.Position
			game:FindService("RunService").Heartbeat:wait()
		until not Target.Character:FindFirstChild("Head")
	else
		notif("Invalid player")
	end
end   
})

AdminSection:AddButton({
	Name = "Nameless Admin",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()
  	end
})

AdminSection:AddButton({
	Name = "Infinite Yield",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
  	end
})

EplrSection:AddButton({
	Name = "Dex Explorer 2.0 (Raspberry Pi)",
	Callback = function()
      		loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
  	end
})

EplrSection:AddButton({
	Name = "DarkDex 4.0 (Moon & Courtney)",
	Callback = function()
		loadstring(game:HttpGet("https://gist.githubusercontent.com/DinosaurXxX/b757fe011e7e600c0873f967fe427dc2/raw/ee5324771f017073fc30e640323ac2a9b3bfc550/dark%2520dex%2520v4"))()
		
  	end
})


local noclipConnection

MoveTab:AddToggle({ 
	Name = "Noclip",
	Default = false,
	Callback = function(Value)
        if Value then
            noclipConnection = game:GetService("RunService").RenderStepped:Connect(function()
                if game.Players.LocalPlayer.Character then
                    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
                if game.Players.LocalPlayer.Character then
                    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = true
                        end
                    end
                end
            end
        end
	end    
})

bts:AddButton({
	Name = "F3X Building Tools",
	Callback = function()
      	loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
  	end
})

ss:AddButton({
    Name = "Unload interface",
    Callback = function()
      	OrionLib:Destroy()
  	end
})



esp:AddButton({
	Name = "Unnamed ESP (ic3w0lf22/Unnamed-ESP)",
	Callback = function()
      		pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))() end)
  	end
})

CharacterTab:AddButton({
	Name = "Give TP tool",
	Callback = function()
		local tool = Instance.new("Tool")
		tool.RequiresHandle = false
		tool.Parent = game.Players.LocalPlayer.Backpack
		tool.Name = "teleport"
		tool.Activated:Connect(function()
			local mouse = game.Players.LocalPlayer:GetMouse()
			local character = game.Players.LocalPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				humanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
			end
		end)
	end
})

CharacterTab:AddButton({
	Name = "Reset velocity",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
	end
})


OrionLib:Init()
