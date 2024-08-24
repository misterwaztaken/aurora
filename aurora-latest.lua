-- AURORA REV2 - DISTRIBUTE!!!
-- You can add whatever you want to this, but name it so it differentiates from our versions!
-- We luv Celery 

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Aurora Mod Menu Ultimate", HidePremium = false, IntroText = "Aurora", SaveConfig = true, ConfigFolder = "Aurora"})

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local targetPlayerName = ""
local FlingTarget = ""

-- Utility function to find players based on input string
local function gplr(String)
	local Found = {}
	local strl = String:lower()

	for _, v in pairs(Players:GetPlayers()) do
		local vName = v.Name:lower()
		if strl == "all" then
			table.insert(Found, v)
		elseif strl == "others" and vName ~= lp.Name:lower() then
			table.insert(Found, v)
		elseif strl == "me" and vName == lp.Name:lower() then
			table.insert(Found, v)
		elseif vName:sub(1, #strl) == strl then
			table.insert(Found, v)
		end
	end

	return Found 
end

-- Utility function for sending notifications
local function notif(str, dur)
	StarterGui:SetCore("SendNotification", {
		Title = "Aurora Ultimate",
		Text = str,
		Duration = dur or 3
	})
end

-- Create Tabs
local MoveTab = Window:MakeTab({ Name = "Fly & TP", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local AdminTab = Window:MakeTab({ Name = "Admin + Utilities", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local CharacterTab = Window:MakeTab({ Name = "Character", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local FunTab = Window:MakeTab({ Name = "Fun Hacks", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local SettingTab = Window:MakeTab({ Name = "Settings", Icon = "rbxassetid://4483345998", PremiumOnly = false })

-- Create Sections
local AdminSection = AdminTab:AddSection({ Name = "Admin" })
local CctrSection = CharacterTab:AddSection({ Name = "Character" })
local tps = MoveTab:AddSection({ Name = "Teleportation" })
local esp = AdminTab:AddSection({ Name = "ESP" })
local fs = MoveTab:AddSection({ Name = "Flight and Noclip" })
local ss = SettingTab:AddSection({ Name = "Options" })
local fef = FunTab:AddSection({ Name = "FE Fling (Trollface edition)" })
local bts = FunTab:AddSection({ Name = "Building tools" })
local EplrSection = AdminTab:AddSection({ Name = "Explorer" })
local saveinstance_section = AdminTab:AddSection({ Name = "SaveInstance" })
local alogger_section = AdminTab:AddSection({ Name = "Edge's audiologger" })

local infjmpConnection, noclipConnection

-- Infinite Jump
MoveTab:AddToggle({ 
	Name = "Fly (Infinite Jump)", Default = false,
	Callback = function(Value)
		if Value then
			infjmpConnection = UserInputService.jumpRequest:Connect(function()
				local humanoid = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then humanoid:ChangeState("Jumping") end
			end)
		else
			if infjmpConnection then
				infjmpConnection:Disconnect()
				infjmpConnection = nil
			end
		end
	end    
})

-- Character Modifications
CctrSection:AddSlider({
	Name = "Walkspeed", Min = 0, Max = 100, Default = 16, Increment = 1, ValueName = "Speed",
	Callback = function(Value)
		local humanoid = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then humanoid.WalkSpeed = Value end
	end    
})

CctrSection:AddSlider({
	Name = "JumpPower", Min = 0, Max = 100, Default = 50, Increment = 1, ValueName = "Power",
	Callback = function(Value)
		local humanoid = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then humanoid.JumpPower = Value end
	end    
})

CctrSection:AddSlider({
	Name = "Gravity", Min = -50, Max = 300, Default = 196, Increment = 1, ValueName = "studs/s2",
	Callback = function(Value)
		workspace.Gravity = Value
	end    
})

-- Teleport to Player
tps:AddTextbox({
	Name = "Target", Default = "Label", TextDisappear = false,
	Callback = function(Value) targetPlayerName = Value end
})

tps:AddButton({
	Name = "Teleport To Player",
	Callback = function()
		local targetPlayer = gplr(targetPlayerName)[1]
		if targetPlayer then
			local targetCharacter = targetPlayer.Character
			local localCharacter = lp.Character
			if targetCharacter and localCharacter then
				local targetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
				local localHRP = localCharacter:FindFirstChild("HumanoidRootPart")
				if targetHRP and localHRP then
					localHRP.CFrame = targetHRP.CFrame
				end
			end
		else
			notif("Player not found", 2)
		end
	end
})

-- FE Fling (Trollface Edition)
fef:AddTextbox({
	Name = "Fling Target", Default = "annoying_kid69", TextDisappear = false,
	Callback = function(Value) FlingTarget = Value end
})

fef:AddButton({
	Name = "Cheese em'",
	Callback = function()
		local targetPlayer = gplr(FlingTarget)[1]
		if targetPlayer and targetPlayer.Character then
			local thrust = Instance.new('BodyThrust', lp.Character.HumanoidRootPart)
			thrust.Force = Vector3.new(9999, 9999, 9999)
			thrust.Name = "YeetForce"
			repeat
				lp.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
				thrust.Location = targetPlayer.Character.HumanoidRootPart.Position
				RunService.Heartbeat:wait()
			until not targetPlayer.Character:FindFirstChild("Head")
		else
			notif("Invalid player", 2)
		end
	end
})

-- Admin Scripts
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

-- Explorer Scripts
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

-- SaveInstance Options
local ssi_sm, ssi_ns = false, false

saveinstance_section:AddToggle({
	Name = "Safe mode", Default = false,
	Callback = function(Value) ssi_sm = Value end
})

saveinstance_section:AddToggle({
	Name = "No scripts", Default = false,
	Callback = function(Value) ssi_ns = Value end
})

saveinstance_section:AddButton({
	Name = "SynSaveInstance",
	Callback = function()
		local Params = {
			RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
			SSI = "saveinstance",
		}
		local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
		local Options = {SafeMode = ssi_sm, NoScripts = ssi_ns}
		synsaveinstance(Options) 
	end
})

-- Noclip
MoveTab:AddToggle({ 
	Name = "Noclip", Default = false,
	Callback = function(Value)
		if Value then
			noclipConnection = RunService.Stepped:Connect(function()
				if lp.Character then
					for _, v in pairs(lp.Character:GetDescendants()) do
						if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
					end
				end
			end)
		else
			if noclipConnection then
				noclipConnection:Disconnect()
				noclipConnection = nil
			end
		end
	end    
})

-- Fly (Btools for Fun)
bts:AddButton({
	Name = "Btools",
	Callback = function()
		local tool = Instance.new("HopperBin", lp.Backpack)
		tool.BinType = Enum.BinType.Build
	end
})

-- ESP (Simple ESP Toggle)
esp:AddButton({
	Name = "Simple ESP",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ICYPhoenix101/RobloxScripts/main/ESPV3"))()
	end
})

-- Miscellaneous Settings
ss:AddBind({
	Name = "Toggle GUI", Default = Enum.KeyCode.RightShift,
	Hold = false,
	Callback = function() OrionLib:Toggle() end    
})

ss:AddButton({
	Name = "Unload UI",
	Callback = function()
		OrionLib:Destroy()
	end
})

-- Finalize Setup
OrionLib:Init()
