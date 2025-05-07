local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end


local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/notificationtest"))();
local Notify = Notification.Notify;

local function getPlr(name)
   -- loop over all players:
   for _, player in pairs(game:GetService("Players"):GetPlayers()) do
      -- if their name matches (case insensitive), return with that player:
      if player.Name:lower() == name:lower() then
          return player
      end
   end
   -- if we reach the end of the for-loop, no player with that name was found
end


hiddenfling = false

local Noclip = nil
local Clip = nil

function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.21) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end


function fling()
	local hrp, c, vel, movel = nil, nil, nil, 0.1
	while hiddenfling do
		game:GetService("RunService").Heartbeat:Wait()
		if hiddenfling then
			local lp = game.Players.LocalPlayer
			while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
				game:GetService("RunService").Heartbeat:Wait()
				c = lp.Character
				hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
			end
			if hiddenfling then
				print(hrp)
				vel = hrp.Velocity
				hrp.Velocity = vel * 100000000 + Vector3.new(0, 100000000, 0)
				game:GetService("RunService").RenderStepped:Wait()
				if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity = vel
				end
				game:GetService("RunService").Stepped:Wait()
				if c and c.Parent and hrp and hrp.Parent then
					hrp.Velocity = vel + Vector3.new(0, movel, 0)
					movel = movel * -1
				end
				
			end
		end
	end
	wait(0.01)
	
end

local Window = OrionLib:MakeWindow({
	Name = "BlockHUB📦 v1",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "BlockHUB"
})

local Scripts = Window:MakeTab({
	Name = "Scripts",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Fling = Window:MakeTab({
	Name = "Fling",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Server = Window:MakeTab({
	Name = "Server",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Player = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Fling:AddToggle({
	Name = "TouchFling",
	Default = false,
	Callback = function(Value)
		hiddenfling = Value
		fling()
		
	end    
})


local cf = false
Fling:AddToggle({
	Name = "ClickFling",
	Default = false,
	Callback = function(Value)
	cf = Value
      	local Players = game:GetService("Players")
	 local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	 
	local funct = Mouse.Button1Down:Connect(function()
		 local Target = Mouse.Target
		 if Target and Target.Parent and Target.Parent:IsA("Model") and Players:GetPlayerFromCharacter(Target.Parent) then
			 local PlayerName = Players:GetPlayerFromCharacter(Target.Parent).Name
	 local player = game.Players.LocalPlayer
	 local Targets = {PlayerName}
	 
	 local Players = game:GetService("Players")
	 local Player = Players.LocalPlayer
	 
	 local AllBool = false
	 
	 local GetPlayer = function(Name)
		Name = Name:lower()
		if Name == "all" or Name == "others" then
			AllBool = true
			return
		elseif Name == "random" then
			local GetPlayers = Players:GetPlayers()
			if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
			return GetPlayers[math.random(#GetPlayers)]
		elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
			for _,x in next, Players:GetPlayers() do
				if x ~= Player then
					if x.Name:lower():match("^"..Name) then
						return x;
					elseif x.DisplayName:lower():match("^"..Name) then
						return x;
					end
				end
			end
		else
			return
		end
	 end
	 
	 local Message = function(_Title, _Text, Time)
print(_Title)
print(_Text)
print(Time)
	 end
	 
	 local SkidFling = function(TargetPlayer)
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local RootPart = Humanoid and Humanoid.RootPart
	 
		local TCharacter = TargetPlayer.Character
		local THumanoid
		local TRootPart
		local THead
		local Accessory
		local Handle
	 
		if TCharacter:FindFirstChildOfClass("Humanoid") then
			THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
		end
		if THumanoid and THumanoid.RootPart then
			TRootPart = THumanoid.RootPart
		end
		if TCharacter:FindFirstChild("Head") then
			THead = TCharacter.Head
		end
		if TCharacter:FindFirstChildOfClass("Accessory") then
			Accessory = TCharacter:FindFirstChildOfClass("Accessory")
		end
		if Accessoy and Accessory:FindFirstChild("Handle") then
			Handle = Accessory.Handle
		end
	 
		if Character and Humanoid and RootPart then
			if RootPart.Velocity.Magnitude < 50 then
				getgenv().OldPos = RootPart.CFrame
			end
			if THumanoid and THumanoid.Sit and not AllBool then
			end
			if THead then
				workspace.CurrentCamera.CameraSubject = THead
			elseif not THead and Handle then
				workspace.CurrentCamera.CameraSubject = Handle
			elseif THumanoid and TRootPart then
				workspace.CurrentCamera.CameraSubject = THumanoid
			end
			if not TCharacter:FindFirstChildWhichIsA("BasePart") then
				return
			end
			
			local FPos = function(BasePart, Pos, Ang)
				RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
				Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
				RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
				RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
			end
			
			local SFBasePart = function(BasePart)
				local TimeToWait = 2
				local Time = tick()
				local Angle = 0
	 
				repeat
					if RootPart and THumanoid then
						if BasePart.Velocity.Magnitude < 50 then
							Angle = Angle + 100
	 
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
						else
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
							
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()
						end
					else
						break
					end
				until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
			end
			
			workspace.FallenPartsDestroyHeight = 0/0
			
			local BV = Instance.new("BodyVelocity")
			BV.Name = "EpixVel"
			BV.Parent = RootPart
			BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
			BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
			
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			
			if TRootPart and THead then
				if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
					SFBasePart(THead)
				else
					SFBasePart(TRootPart)
				end
			elseif TRootPart and not THead then
				SFBasePart(TRootPart)
			elseif not TRootPart and THead then
				SFBasePart(THead)
			elseif not TRootPart and not THead and Accessory and Handle then
				SFBasePart(Handle)
			else
			end
			
			BV:Destroy()
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			workspace.CurrentCamera.CameraSubject = Humanoid
			
			repeat
				RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
				Humanoid:ChangeState("GettingUp")
				table.foreach(Character:GetChildren(), function(_, x)
					if x:IsA("BasePart") then
						x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
					end
				end)
				task.wait()
			until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
			workspace.FallenPartsDestroyHeight = getgenv().FPDH
		else
		end
		
	 end
	 
	 getgenv().Welcome = true
	 if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end
	 
	 if AllBool then
		for _,x in next, Players:GetPlayers() do
			SkidFling(x)
		end
	 end
	 
	 for _,x in next, Targets do
		if GetPlayer(x) and GetPlayer(x) ~= Player then
			if GetPlayer(x).UserId ~= 1414978355 then
				local TPlayer = GetPlayer(x)
				if TPlayer then
					SkidFling(TPlayer)
				end
			else
			end
		elseif not GetPlayer(x) and not AllBool then
		end
	 end
		 end
	 end)
	local cff = true
	while cff do
		if cf == false then
		funct:Disconnect()
		cff = false
		end
		wait()
  	end    
	end
})

Server:AddButton({
	Name = "Rejoin",
	Callback = function()
      			 queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
 
	 
	 if not DONE then
	   DONE = true
	   local qot = print("a")
	   local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	   if hrp then
		 qot = 'task.spawn(function() end) repeat wait() until game and game:IsLoaded() local lp = game:GetService("Players").LocalPlayer local char = lp.Character or lp.CharacterAdded:Wait() repeat char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new('..tostring(hrp.CFrame)..') wait() until (Vector3.new('..tostring(hrp.Position)..') - char:WaitForChild("HumanoidRootPart").Position).Magnitude < 10 loadstring(game:HttpGet("https://raw.githubusercontent.com/tnttp/myscripts/main/BlockHUB.lua"))()'
	   end
	   queueteleport(qot)
	   game:GetService("TeleportService"):TeleportCancel()
		 game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
			end
  	end    
})


Server:AddButton({
	Name = "Server Hop",
	Callback = function()
      		Notify({
 Description = "Searching";
 Title = "BlockHUB";
 Duration = 5;
 
 });
				 local Number = 0
				 local SomeSRVS = {}
				 for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
					 if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
						 if v.playing > Number then
							 Number = v.playing
							 SomeSRVS[1] = v.id
						 end
					 end
				 end
				 if #SomeSRVS > 0 then
				 Notify({
 Description = "Searched, please wait while we are teleporting you";
 Title = "BlockHUB";
 Duration = 5;
 
 });
				         queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
 
	 
	 if not DONE then
	   DONE = true
	   local qot = print("a")
	   local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	   if hrp then
		 qot = 'task.spawn(function() end) repeat wait() until game and game:IsLoaded() loadstring(game:HttpGet("https://raw.githubusercontent.com/tnttp/myscripts/main/BlockHUB.lua"))()'
	   end
	   queueteleport(qot)
					game:GetService("TeleportService"):TeleportCancel()
					 game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SomeSRVS[1])
				end
				 end
 
  	end    
})
 


Player:AddButton({
	Name = "Reset",
	Callback = function()
      		game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
  	end    
})

Player:AddButton({
	Name = "Ghost",
	Callback = function()
      		loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/Protected%20-%202023-05-28T225112.055.lua.txt'),true))()
  	end    
})

Player:AddToggle({
	Name = "Noclip",
	Default = false,
	Callback = function(Value)
	        if Value == true then
			noclip()
		else
			clip()	
			game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
})



local Fly = Player:AddToggle({
	Name = "Fly",
	Default = false,
	Callback = function(Value)
		
		if Value == false then
			if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
			game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
	                game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
	                game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	                Signal1:Disconnect()
	                Signal2:Disconnect()
			end
		end
	        if Value == true then
			local controlModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))
	 local bv = Instance.new("BodyVelocity")
	 bv.Name = "VelocityHandler"
	 bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
	 bv.MaxForce = Vector3.new(0,0,0)
	 bv.Velocity = Vector3.new(0,0,0)
	 
	 local bg = Instance.new("BodyGyro")
	 bg.Name = "GyroHandler"
	 bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
	 bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	 bg.P = 1000
	 bg.D = 50
	 
	 local Signal1
	 Signal1 = game.Players.LocalPlayer.CharacterAdded:Connect(function(NewChar)
	 local bv = Instance.new("BodyVelocity")
	 bv.Name = "VelocityHandler"
	 bv.Parent = NewChar:WaitForChild("Humanoid").RootPart
	 bv.MaxForce = Vector3.new(0,0,0)
	 bv.Velocity = Vector3.new(0,0,0)
	 
	 local bg = Instance.new("BodyGyro")
	 bg.Name = "GyroHandler"
	 bg.Parent = NewChar:WaitForChild("Humanoid").HumanoidRootPart
	 bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	 bg.P = 1000
	 bg.D = 50
	 end)
	 
	 local camera = game.Workspace.CurrentCamera
	 
	 local Signal2
	 Signal2 = game:GetService"RunService".RenderStepped:Connect(function()
	 if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
	 
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
	 game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
	 game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
	 
	 game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = camera.CoordinateFrame
	 local direction = controlModule:GetMoveVector()
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
	 if direction.X > 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*40)
	 end
	 if direction.X < 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*40)
	 end
	 if direction.Z > 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*40)
	 end
	 if direction.Z < 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*40)
	 end
	 end
	 end)
	 
		
			
		end
		
	end
})
local Aj = false
Player:AddToggle({
	Name = "Airjump",
	Default = false,
	Callback = function(Value)
		Aj = Value
		if Aj then
		local UserInputService = game:GetService("UserInputService")
		local funct = UserInputService.JumpRequest:Connect(function()
			game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end)
		local Ajj = true
	        while Ajj do
		if Aj == false then
		funct:Disconnect()
		Ajj = false
		end
		wait()
  	end 
			end
	end
})

local choose = Scripts:AddDropdown({
	Name = "Select player",
	Default = "CHOOSE PLAYER",
	Options = {"CHOOSE PLAYER"},
	Flag = "select",
	Callback = function(Value)
		
	end    
})
local indexx = 0
game:GetService("RunService").Heartbeat:Connect(function()
	if indexx >= 100 then	
	local plrs = {}
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	table.insert(plrs, v.name)
end

choose:Refresh(plrs,true)local plrs = {}
	indexx = -1
	end
indexx = indexx + 1
	
end)


Scripts:AddButton({
	Name = "Fling selected player",
	Callback = function()
      		local player = game.Players.LocalPlayer
	 
	 local Players = game:GetService("Players")
	 local Player = Players.LocalPlayer
	 
	 local AllBool = false
		local SkidFling = function(TargetPlayer)
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local RootPart = Humanoid and Humanoid.RootPart
	 
		local TCharacter = TargetPlayer.Character
		local THumanoid
		local TRootPart
		local THead
		local Accessory
		local Handle
	 
		if TCharacter:FindFirstChildOfClass("Humanoid") then
			THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
		end
		if THumanoid and THumanoid.RootPart then
			TRootPart = THumanoid.RootPart
		end
		if TCharacter:FindFirstChild("Head") then
			THead = TCharacter.Head
		end
		if TCharacter:FindFirstChildOfClass("Accessory") then
			Accessory = TCharacter:FindFirstChildOfClass("Accessory")
		end
		if Accessoy and Accessory:FindFirstChild("Handle") then
			Handle = Accessory.Handle
		end
	 
		if Character and Humanoid and RootPart then
			if RootPart.Velocity.Magnitude < 50 then
				getgenv().OldPos = RootPart.CFrame
			end
			if THumanoid and THumanoid.Sit and not AllBool then
			end
			if THead then
				workspace.CurrentCamera.CameraSubject = THead
			elseif not THead and Handle then
				workspace.CurrentCamera.CameraSubject = Handle
			elseif THumanoid and TRootPart then
				workspace.CurrentCamera.CameraSubject = THumanoid
			end
			if not TCharacter:FindFirstChildWhichIsA("BasePart") then
				return
			end
			
			local FPos = function(BasePart, Pos, Ang)
				RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
				Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
				RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
				RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
			end
			
			local SFBasePart = function(BasePart)
				local TimeToWait = 2
				local Time = tick()
				local Angle = 0
	 
				repeat
					if RootPart and THumanoid then
						if BasePart.Velocity.Magnitude < 50 then
							Angle = Angle + 100
	 
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
						else
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
							
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()
						end
					else
						break
					end
				until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
			end
			
			workspace.FallenPartsDestroyHeight = 0/0
			
			local BV = Instance.new("BodyVelocity")
			BV.Name = "EpixVel"
			BV.Parent = RootPart
			BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
			BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
			
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			
			if TRootPart and THead then
				if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
					SFBasePart(THead)
				else
					SFBasePart(TRootPart)
				end
			elseif TRootPart and not THead then
				SFBasePart(TRootPart)
			elseif not TRootPart and THead then
				SFBasePart(THead)
			elseif not TRootPart and not THead and Accessory and Handle then
				SFBasePart(Handle)
			else
			end
			
			BV:Destroy()
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			workspace.CurrentCamera.CameraSubject = Humanoid
			
			repeat
				RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
				Humanoid:ChangeState("GettingUp")
				table.foreach(Character:GetChildren(), function(_, x)
					if x:IsA("BasePart") then
						x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
					end
				end)
				task.wait()
			until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
			workspace.FallenPartsDestroyHeight = getgenv().FPDH
		else
		end
			end
			
			local plr = getPlr(OrionLib.Flags["select"].Value)
			if plr ~= nil then
			SkidFling(plr)
		        end
			
  	end    
})

Scripts:AddButton({
	Name = "Tp to selected player",
	Callback = function()
		local Target = getPlr(OrionLib.Flags["select"].Value)
		if Target ~= nil then
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.Humanoid.RootPart.CFrame
		end
  	end    
})

Scripts:AddButton({
	Name = "Ride selected player",
	Callback = function()
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local players = getPlr(OrionLib.Flags["select"].Value)
		local sitPlr = players.Name
		if players ~= nil then
 
		 sitDied = game.Players.LocalPlayer.Character:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
			 sitLoop = sitLoop:Disconnect()
		 end)
				 game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Sit = true
 
	 headSit = RunService.Heartbeat:Connect(function()
					 if Players:FindFirstChild(players.Name) and players.Character ~= nil and getRoot(players.Character) and getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Sit == true then
			 getRoot(game.Players.LocalPlayer.Character).CFrame = players.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(0),0)* CFrame.new(0,1.6,0.4)
			 else
			 headSit:Disconnect()
		 end
		 end)
		end
  	end    
})


Fling:AddButton({
	Name = "Fling all",
	Callback = function()
	 local player = game.Players.LocalPlayer
	 
	 local Players = game:GetService("Players")
	 local Player = Players.LocalPlayer
	 
	 local AllBool = false
		local SkidFling = function(TargetPlayer)
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local RootPart = Humanoid and Humanoid.RootPart
	 
		local TCharacter = TargetPlayer.Character
		local THumanoid
		local TRootPart
		local THead
		local Accessory
		local Handle
	 
		if TCharacter:FindFirstChildOfClass("Humanoid") then
			THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
		end
		if THumanoid and THumanoid.RootPart then
			TRootPart = THumanoid.RootPart
		end
		if TCharacter:FindFirstChild("Head") then
			THead = TCharacter.Head
		end
		if TCharacter:FindFirstChildOfClass("Accessory") then
			Accessory = TCharacter:FindFirstChildOfClass("Accessory")
		end
		if Accessoy and Accessory:FindFirstChild("Handle") then
			Handle = Accessory.Handle
		end
	 
		if Character and Humanoid and RootPart then
			if RootPart.Velocity.Magnitude < 50 then
				getgenv().OldPos = RootPart.CFrame
			end
			if THumanoid and THumanoid.Sit and not AllBool then
			end
			if THead then
				workspace.CurrentCamera.CameraSubject = THead
			elseif not THead and Handle then
				workspace.CurrentCamera.CameraSubject = Handle
			elseif THumanoid and TRootPart then
				workspace.CurrentCamera.CameraSubject = THumanoid
			end
			if not TCharacter:FindFirstChildWhichIsA("BasePart") then
				return
			end
			
			local FPos = function(BasePart, Pos, Ang)
				RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
				Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
				RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
				RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
			end
			
			local SFBasePart = function(BasePart)
				local TimeToWait = 2
				local Time = tick()
				local Angle = 0
	 
				repeat
					if RootPart and THumanoid then
						if BasePart.Velocity.Magnitude < 50 then
							Angle = Angle + 100
	 
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
						else
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
							
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()
						end
					else
						break
					end
				until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
			end
			
			workspace.FallenPartsDestroyHeight = 0/0
			
			local BV = Instance.new("BodyVelocity")
			BV.Name = "EpixVel"
			BV.Parent = RootPart
			BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
			BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
			
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			
			if TRootPart and THead then
				if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
					SFBasePart(THead)
				else
					SFBasePart(TRootPart)
				end
			elseif TRootPart and not THead then
				SFBasePart(TRootPart)
			elseif not TRootPart and THead then
				SFBasePart(THead)
			elseif not TRootPart and not THead and Accessory and Handle then
				SFBasePart(Handle)
			else
			end
			
			BV:Destroy()
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			workspace.CurrentCamera.CameraSubject = Humanoid
			
			repeat
				RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
				Humanoid:ChangeState("GettingUp")
				table.foreach(Character:GetChildren(), function(_, x)
					if x:IsA("BasePart") then
						x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
					end
				end)
				task.wait()
			until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
			workspace.FallenPartsDestroyHeight = getgenv().FPDH
		else
		end
			end
			for i,v in pairs(Players:GetPlayers()) do
				if game.Workspace:FindFirstChild(v.name) then
				SkidFling(v)
				end
				Wait()
			end
	end
})
local fal = false
Fling:AddToggle({
	Name = "Fling all loop",
	Default = false,
	Callback = function(Value)
	fal = Value
	
	 local player = game.Players.LocalPlayer
	 
	 local Players = game:GetService("Players")
	 local Player = Players.LocalPlayer
	 
	 local AllBool = false
		local SkidFling = function(TargetPlayer)
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local RootPart = Humanoid and Humanoid.RootPart
	 
		local TCharacter = TargetPlayer.Character
		local THumanoid
		local TRootPart
		local THead
		local Accessory
		local Handle
	 
		if TCharacter:FindFirstChildOfClass("Humanoid") then
			THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
		end
		if THumanoid and THumanoid.RootPart then
			TRootPart = THumanoid.RootPart
		end
		if TCharacter:FindFirstChild("Head") then
			THead = TCharacter.Head
		end
		if TCharacter:FindFirstChildOfClass("Accessory") then
			Accessory = TCharacter:FindFirstChildOfClass("Accessory")
		end
		if Accessoy and Accessory:FindFirstChild("Handle") then
			Handle = Accessory.Handle
		end
	 
		if Character and Humanoid and RootPart then
			if RootPart.Velocity.Magnitude < 50 then
				getgenv().OldPos = RootPart.CFrame
			end
			if THumanoid and THumanoid.Sit and not AllBool then
			end
			if THead then
				workspace.CurrentCamera.CameraSubject = THead
			elseif not THead and Handle then
				workspace.CurrentCamera.CameraSubject = Handle
			elseif THumanoid and TRootPart then
				workspace.CurrentCamera.CameraSubject = THumanoid
			end
			if not TCharacter:FindFirstChildWhichIsA("BasePart") then
				return
			end
			
			local FPos = function(BasePart, Pos, Ang)
				RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
				Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
				RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
				RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
			end
			
			local SFBasePart = function(BasePart)
				local TimeToWait = 2
				local Time = tick()
				local Angle = 0
	 
				repeat
					if RootPart and THumanoid then
						if BasePart.Velocity.Magnitude < 50 then
							Angle = Angle + 100
	 
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
							task.wait()
						else
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
							
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
							task.wait()
	 
							FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
							task.wait()
						end
					else
						break
					end
				until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
			end
			
			workspace.FallenPartsDestroyHeight = 0/0
			
			local BV = Instance.new("BodyVelocity")
			BV.Name = "EpixVel"
			BV.Parent = RootPart
			BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
			BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
			
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			
			if TRootPart and THead then
				if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
					SFBasePart(THead)
				else
					SFBasePart(TRootPart)
				end
			elseif TRootPart and not THead then
				SFBasePart(TRootPart)
			elseif not TRootPart and THead then
				SFBasePart(THead)
			elseif not TRootPart and not THead and Accessory and Handle then
				SFBasePart(Handle)
			else
			end
			
			BV:Destroy()
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			workspace.CurrentCamera.CameraSubject = Humanoid
			
			repeat
				RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
				Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
				Humanoid:ChangeState("GettingUp")
				table.foreach(Character:GetChildren(), function(_, x)
					if x:IsA("BasePart") then
						x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
					end
				end)
				task.wait()
			until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
			workspace.FallenPartsDestroyHeight = getgenv().FPDH
		else
		end
			end

			while fal == true do
			if fal == true then
			for i,v in pairs(Players:GetPlayers()) do
				if fal == true then
				if game.Workspace:FindFirstChild(v.name) then
				SkidFling(v)
				end
				end
				Wait()
			
			end
			end
			Wait()
			end
			
			
	end
})




OrionLib:Init()
--[[
game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0.5
hiddenfling = false

if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
	hiddenfling = true
else
	hiddenfling = true
	detection = Instance.new("Decal")
	detection.Name = "juisdfj0i32i0eidsuf0iok"
	detection.Parent = game:GetService("ReplicatedStorage")
	local function fling()
		local hrp, c, vel, movel = nil, nil, nil, 0.1
		while true do
			game:GetService("RunService").Heartbeat:Wait()
			if hiddenfling then
				local lp = game.Players.LocalPlayer
				while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
					game:GetService("RunService").Heartbeat:Wait()
					c = lp.Character
					hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
				end
				if hiddenfling then
					vel = hrp.Velocity
					hrp.Velocity = vel * 1000000 + Vector3.new(0, 1000000, 0)
					game:GetService("RunService").RenderStepped:Wait()
					if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity = vel
					end
					game:GetService("RunService").Stepped:Wait()
					if c and c.Parent and hrp and hrp.Parent then
						hrp.Velocity = vel + Vector3.new(0, movel, 0)
						movel = movel * -1
					end
				end
			end
		end
	end
		 
	fling()
end
]]
