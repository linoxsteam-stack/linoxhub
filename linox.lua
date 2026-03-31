-- Cargar Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "linox",
   LoadingTitle = "linox hub",
   LoadingSubtitle = "by linox",
   ConfigurationSaving = {Enabled = false},
   KeySystem = true,
   KeySettings = {
      Title = "Acceso requerido",
      Subtitle = "Introduce la contraseña",
      Note = "clave privada",
      FileName = "linoxkey",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"dohan"}
   }
})

-- TABS
local Tab1 = Window:CreateTab("VFly", 4483362458)
local Tab2 = Window:CreateTab("AIMBOT MENU SOUTH BRONX", 4483362458)
local Tab3 = Window:CreateTab("AUTO FARM SOUTH BRONX", 4483362458)

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flying = false
local noclip = false
local speed = 50
local autoFarmLoaded = false

local bv, bg

-- FLY (ORIGINAL)
local function startFly()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e6,1e6,1e6)
    bv.Parent = hrp

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e6,1e6,1e6)
    bg.Parent = hrp

    flying = true
end

local function stopFly()
    flying = false
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end

-- MOVIMIENTO
RunService.RenderStepped:Connect(function()
    if flying and player.Character then
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local cam = workspace.CurrentCamera
        local dir = Vector3.new()

        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end

        if dir.Magnitude > 0 then
            bv.Velocity = dir.Unit * speed
        else
            bv.Velocity = Vector3.new()
        end

        bg.CFrame = cam.CFrame
    end
end)

-- NOCLIP
RunService.Heartbeat:Connect(function()
    if noclip and player.Character then
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CanCollide = false
        end
    end
end)

-- TAB 1
Tab1:CreateToggle({
   Name = "Activar VFly",
   CurrentValue = false,
   Callback = function(v)
      if v then startFly() else stopFly() end
   end,
})

Tab1:CreateSlider({
   Name = "Velocidad",
   Range = {10, 500},
   Increment = 10,
   Suffix = "Speed",
   CurrentValue = 50,
   Callback = function(v)
      speed = v
   end,
})

Tab1:CreateToggle({
   Name = "NoClip",
   CurrentValue = false,
   Callback = function(v)
      noclip = v
   end,
})

-- DELETER
Tab1:CreateButton({
   Name = "DELETED BY LINOX",
   Callback = function()
      local plr = game.Players.LocalPlayer
      local mouse = plr:GetMouse()
      local rs = game:GetService("RunService")

      local enabled = false
      local lastPart = nil
      local box = nil

      local t = Instance.new("Tool")
      t.Name = "Deleter"
      t.RequiresHandle = false
      t.Parent = plr.Backpack

      local function clearBox()
          if box then box:Destroy() box = nil end
          lastPart = nil
      end

      local function highlight(part)
          clearBox()
          box = Instance.new("SelectionBox")
          box.Color3 = Color3.fromRGB(255, 0, 0)
          box.SurfaceTransparency = 0.4
          box.Adornee = part
          box.Parent = workspace
      end

      local function safe(part)
          if not part or not part:IsA("BasePart") then return false end
          local c = plr.Character
          if c and part:IsDescendantOf(c) then return false end
          return true
      end

      t.Activated:Connect(function()
          enabled = not enabled
          if not enabled then clearBox() end
      end)

      mouse.Button1Down:Connect(function()
          if not enabled then return end
          local hit = mouse.Target
          if not safe(hit) then return end
          clearBox()
          hit:Destroy()
      end)

      rs.RenderStepped:Connect(function()
          if not enabled then clearBox() return end
          local hit = mouse.Target
          if hit and safe(hit) then
              if hit ~= lastPart then
                  lastPart = hit
                  highlight(hit)
              end
          else
              clearBox()
          end
      end)
   end,
})

-- TAB 2
Tab2:CreateButton({
   Name = "Abrir AIMBOT",
   Callback = function()
      loadstring(game:HttpGet("https://rawscripts.net/raw/South-Bronx:-The-Trenches-South-bronx-the-trenche*box-expander-85811"))()
   end,
})

-- TAB 3 AUTO FARM
Tab3:CreateButton({
   Name = "Activar Auto Farm",
   Callback = function()
      if not autoFarmLoaded then
         autoFarmLoaded = true
         loadstring(game:HttpGet("https://raw.githubusercontent.com/rexxymayor-ai/SCRIPTtt/refs/heads/main/script%20automs", true))()
      end
   end,
})

-- TECLA Z (ORIGINAL 🔥)
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end

    if input.KeyCode == Enum.KeyCode.Z then
        if flying then
            stopFly()
        else
            startFly()
        end
    end
end)
