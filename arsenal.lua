loadstring(game:HttpGet("https://raw.githubusercontent.com/yusufupvpytt/LIGHTNING-hub/master/main.lua", true))()
wait(2)
local Library = loadstring(game:HttpGet("https://pastebinp.com/raw/2xDTKdpV", true))()

local AimbotTab = Library:CreateTab("Combat", "Aimbot + Hitbox", true) 
local Visual = Library:CreateTab("Visual", "Esp + Chams + Tacers", true) 
local Credits = Library:CreateTab("Credits", "Youtube CLYusuf", true) 

AimbotTab:CreateToggle("Enable Aimbot", function(arg) --the (arg) is if the checkbox is toggled or not
    if arg then
        print("Aimbot is now : Enabled")
        _G.pfAimbot() 
    else
        print("Aimbot is now : Disabled")
        _G.pfAimbotSignal:Disconnect()
    end
end)

Visual:CreateToggle("Esp", function(arg) --the (arg) is if the checkbox is toggled or not
    if arg then
        print("Aimbot is now : Enabled")
        _G.PFESP()
    else
        print("Aimbot is now : Disabled")
        _G.PFESPOFF()
    end
end)

Visual:CreateToggle("Chams", function(arg) --the (arg) is if the checkbox is toggled or not
    if arg then
        print("Aimbot is now : Enabled")
        _G.pfchams()
    else
        print("Aimbot is now : Disabled")
        _G.pfchamsoff()
    end
end)

Visual:CreateToggle("Chams", function(arg) --the (arg) is if the checkbox is toggled or not
    if arg then
        print("Aimbot is now : Enabled")
        _G.tracerss()
    else
        print("Aimbot is now : Disabled")
        _G.tracersOff()
    end
end)


AimbotTab:CreateButton("Hitbox", function() --you dont need "arg" for a button
    --

    local Script = game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client
    local ran = false
    local tables = {}
    local w = wait
    
    local players = game:GetService("Players")
    local plr = players.LocalPlayer
    coroutine.resume(coroutine.create(function()
        while  wait(1) do
            coroutine.resume(coroutine.create(function()
                for _,v in pairs(players:GetPlayers()) do
                    if v.Name ~= plr.Name and v.Character then
                        v.Character.LowerTorso.CanCollide = false
                        v.Character.LowerTorso.Material = "Neon"
                        v.Character.LowerTorso.Size = Vector3.new(20,20,20)
                        v.Character.HumanoidRootPart.Size = Vector3.new(20,20,20)
                    end
                end
            end))
        end
    end))
end)
