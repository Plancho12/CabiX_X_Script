-- CabiX_X Script v12.2 (Arreglado Panel de Bailes, Portal y Cambiador Completo)
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PlayerGui = LP:FindFirstChildOfClass("PlayerGui")
local ParentFolder = PlayerGui or game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- Definir el mouse al principio para evitar errores de carga
local mouse = LP:GetMouse()

if ParentFolder:FindFirstChild("CabiX_X_Gui") then
    ParentFolder["CabiX_X_Gui"]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CabiX_X_Gui"
ScreenGui.Parent = ParentFolder
ScreenGui.ResetOnSpawn = false

-- PANEL PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "CabiX_X_Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame
local RGBObjects = {MainStroke}

task.spawn(function()
    while task.wait(0.03) do
        local hue = (tick() % 4) / 4
        local color = Color3.fromHSV(hue, 1, 1)
        for _, stroke in pairs(RGBObjects) do
            if stroke and stroke.Parent then stroke.Color = color end
        end
    end
end)

-- CABECERA
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "CabiX_X Menu v12.2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(230, 75, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local MinimizeBtn = Instance.new("TextButton", Header)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -62, 0, 8)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(240, 195, 15)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

-- BOLA FLOTANTE (REAPERTURA)
local OpenBall = Instance.new("TextButton")
OpenBall.Name = "CabiX_X_Ball"
OpenBall.Parent = ScreenGui
OpenBall.Size = UDim2.new(0, 50, 0, 50)
OpenBall.Position = UDim2.new(0.1, 0, 0.2, 0)
OpenBall.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
OpenBall.Text = "X-X"
OpenBall.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBall.Font = Enum.Font.SourceSansBold
OpenBall.TextSize = 16
OpenBall.Visible = false
OpenBall.Active = true
OpenBall.Draggable = true
Instance.new("UICorner", OpenBall).CornerRadius = UDim.new(1, 0)
local BallStroke = Instance.new("UIStroke", OpenBall)
BallStroke.Thickness = 2
table.insert(RGBObjects, BallStroke)

-- CONTENEDOR DESLIZABLE PRINCIPAL
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.Size = UDim2.new(1, -10, 1, -55)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 950)
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)

local Layout = Instance.new("UIListLayout", Scroll)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- PANEL SECUNDARIO (Lista de TP Jugadores)
local TPFrame = Instance.new("Frame", ScreenGui)
TPFrame.Size = UDim2.new(0, 200, 0, 280)
TPFrame.Position = UDim2.new(0.4, -100, 0.3, -140)
TPFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TPFrame.Visible = false
Instance.new("UICorner", TPFrame).CornerRadius = UDim.new(0, 10)
local TPStroke = Instance.new("UIStroke", TPFrame)
TPStroke.Thickness = 2
table.insert(RGBObjects, TPStroke)

local TPTitle = Instance.new("TextLabel", TPFrame)
TPTitle.Size = UDim2.new(1, 0, 0, 35)
TPTitle.Text = "Selecciona Jugador"
TPTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TPTitle.BackgroundTransparency = 1
TPTitle.Font = Enum.Font.SourceSansBold

local TPClose = Instance.new("TextButton", TPFrame)
TPClose.Size = UDim2.new(0, 20, 0, 20)
TPClose.Position = UDim2.new(1, -25, 0, 7)
TPClose.Text = "X"
TPClose.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
TPClose.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TPClose)

local TPScroll = Instance.new("ScrollingFrame", TPFrame)
TPScroll.Position = UDim2.new(0, 5, 0, 40)
TPScroll.Size = UDim2.new(1, -10, 1, -45)
TPScroll.BackgroundTransparency = 1
TPScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
local TPLayout = Instance.new("UIListLayout", TPScroll)
TPLayout.Padding = UDim.new(0, 5)

-- 💃 PANEL TERCIARIO: SUB-MENÚ DE BAILES
local DanceFrame = Instance.new("Frame")
DanceFrame.Name = "CabiX_X_DanceMenu"
DanceFrame.Parent = ScreenGui
DanceFrame.Size = UDim2.new(0, 220, 0, 320)
DanceFrame.Position = UDim2.new(0.6, -110, 0.3, -160)
DanceFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
DanceFrame.Visible = false
DanceFrame.Active = true
DanceFrame.Draggable = true
Instance.new("UICorner", DanceFrame).CornerRadius = UDim.new(0, 10)
local DanceStroke = Instance.new("UIStroke", DanceFrame)
DanceStroke.Thickness = 2
table.insert(RGBObjects, DanceStroke)

local DanceTitle = Instance.new("TextLabel", DanceFrame)
DanceTitle.Size = UDim2.new(1, 0, 0, 35)
DanceTitle.Text = "Menú de Bailes (+1000)"
DanceTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
DanceTitle.BackgroundTransparency = 1
DanceTitle.Font = Enum.Font.SourceSansBold

local DanceClose = Instance.new("TextButton", DanceFrame)
DanceClose.Size = UDim2.new(0, 20, 0, 20)
DanceClose.Position = UDim2.new(1, -25, 0, 7)
DanceClose.Text = "X"
DanceClose.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
DanceClose.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", DanceClose)

local DanceScroll = Instance.new("ScrollingFrame", DanceFrame)
DanceScroll.Position = UDim2.new(0, 5, 0, 40)
DanceScroll.Size = UDim2.new(1, -10, 1, -80)
DanceScroll.BackgroundTransparency = 1
DanceScroll.CanvasSize = UDim2.new(0, 0, 0, 26000)
local DanceLayout = Instance.new("UIListLayout", DanceScroll)
DanceLayout.Padding = UDim.new(0, 4)

local StopDanceBtn = Instance.new("TextButton", DanceFrame)
StopDanceBtn.Size = UDim2.new(0, 200, 0, 30)
StopDanceBtn.Position = UDim2.new(0.5, -100, 1, -35)
StopDanceBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
StopDanceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopDanceBtn.Text = "Detener Baile"
StopDanceBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", StopDanceBtn)

-- CONSTRUCTOR DE SLIDERS
local function CreateSlider(name, min, max, default, callback)
    local sliderFrame = Instance.new("Frame", Scroll)
    sliderFrame.Size = UDim2.new(0, 220, 0, 45)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel", sliderFrame)
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSansBold

    local track = Instance.new("Frame", sliderFrame)
    track.Size = UDim2.new(0, 180, 0, 6)
    track.Position = UDim2.new(0.5, -90, 0, 26)
    track.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

    local button = Instance.new("TextButton", track)
    button.Size = UDim2.new(0, 14, 0, 14)
    button.Position = UDim2.new((default - min) / (max - min), -7, 0, -4)
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    button.Text = ""
    Instance.new("UICorner", button).CornerRadius = UDim.new(1, 0)

    local dragging = false
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relativeX = input.Position.X - track.AbsolutePosition.X
            local percentage = math.clamp(relativeX / track.AbsoluteSize.X, 0, 1)
            button.Position = UDim2.new(percentage, -7, 0, -4)
            local value = math.floor(min + (max - min) * percentage)
            label.Text = name .. ": " .. value
            callback(value)
        end
    end)
end

-- CONSTRUCTOR DE BOTONES
local function CreateButton(text, activeText, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0, 220, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(45, 45, 45)
        btn.TextColor3 = state and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
        btn.Text = state and activeText or text
        callback(state)
    end)
end

-- LOGICA INTERNA HACKS
local InfJump = false
local Noclip = false
local TPClickActive = false

-- Sliders de Configuración
CreateSlider("Velocidad", 0, 10000, 16, function(val)
    if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then LP.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val end
end)

CreateSlider("Poder de Salto", 0, 500, 50, function(val)
    if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then LP.Character:FindFirstChildOfClass("Humanoid").JumpPower = val end
end)

-- Botones Base
CreateButton("Infinity Jump: OFF", "Infinity Jump: ON", function(state) InfJump = state end)
UIS.JumpRequest:Connect(function()
    if InfJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end
end)

CreateButton("No Clip: OFF", "No Clip: ON", function(state) Noclip = state end)
RunService.Stepped:Connect(function()
    if Noclip and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
    end
end)

CreateButton("Fling: OFF", "Fling: ON", function(state)
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if state then
        local bavg = Instance.new("BodyAngularVelocity", hrp)
        bavg.Name = "CabiXFling"
        bavg.AngularVelocity = Vector3.new(0, 99999, 0)
        bavg.MaxTorque = Vector3.new(0, 99999, 0)
    else
        if hrp:FindFirstChild("CabiXFling") then hrp.CabiXFling:Destroy() end
    end
end)

-- TELEKINESIS POR OBJETO
local tkTool = Instance.new("Tool")
tkTool.Name = "Telekinesis"
tkTool.RequiresHandle = false

local tkTarget, tkBP
local tkMovingActive = false
local ultimoClickTK = 0

tkTool.Equipped:Connect(function()
    local inputConnection = UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local tiempoActual = tick()
            if (tiempoActual - ultimoClickTK) < 0.35 then
                tkMovingActive = not tkMovingActive
                if tkMovingActive then
                    local target = mouse.Target
                    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                    if target and not target:IsAnchored() and target:IsA("BasePart") and hrp then
                        tkTarget = target
                        tkBP = Instance.new("BodyPosition", tkTarget)
                        tkBP.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        tkBP.Position = hrp.Position + (mouse.Hit.Position - hrp.Position).Unit * 25
                    else
                        tkMovingActive = false
                    end
                else
                    if tkBP then tkBP:Destroy() tkBP = nil end
                    tkTarget = nil
                end
                ultimoClickTK = 0
            else
                ultimoClickTK = tiempoActual
            end
        end
    end)

    local moveConnection = RunService.RenderStepped:Connect(function()
        if tkMovingActive and tkBP and tkTarget then
            local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                tkBP.Position = hrp.Position + (mouse.Hit.Position - hrp.Position).Unit * 25
            end
        end
    end)

    tkTool.Unequipped:Connect(function()
        inputConnection:Disconnect()
        moveConnection:Disconnect()
        tkMovingActive = false
        if tkBP then tkBP:Destroy() tkBP = nil end
        tkTarget = nil
    end)
end)

CreateButton("Telekinesis: OFF", "Telekinesis: EQUIPADO", function(state) tkTool.Parent = state and LP.Backpack or nil end)

-- TP CLICK
CreateButton("Tp click me: OFF", "Tp click me: ON", function(state) TPClickActive = state end)
UIS.InputBegan:Connect(function(input, processed)
    if TPClickActive and not processed and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        if mouse.Target and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end
end)

-- 🛠️ PORTAL GUN
local portalTool = Instance.new("Tool")
portalTool.Name = "Portal"
portalTool.RequiresHandle = false
local portalEntrada, portalSalida
local ultimoClickPortal = 0

local function CreatePortalPart(color)
    local p = Instance.new("Part")
    p.Size = Vector3.new(5, 6, 0.5)
    p.Material = Enum.Material.Neon
    p.Color = color
    p.Anchored = true
    p.CanCollide = false
    p.Parent = workspace
    return p
end

portalTool.Equipped:Connect(function()
    local shootCon = UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local tiempoActual = tick()
            if (tiempoActual - ultimoClickPortal) < 0.35 then
                local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                if not hrp or not mouse.Target then return end

                if portalEntrada then portalEntrada:Destroy() end
                if portalSalida then portalSalida:Destroy() end

                portalEntrada = CreatePortalPart(Color3.fromRGB(0, 150, 255))
                portalEntrada.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)

                portalSalida = CreatePortalPart(Color3.fromRGB(255, 100, 0))
                portalSalida.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))

                portalEntrada.Touched:Connect(function(hit)
                    if hit.Parent == LP.Character and portalSalida then
                        hrp.CFrame = portalSalida.CFrame * CFrame.new(0, 0, -2)
                    end
                end)
                
                ultimoClickPortal = 0
            else
                ultimoClickPortal = tiempoActual
            end
        end
    end)

    portalTool.Unequipped:Connect(function()
        shootCon:Disconnect()
        if portalEntrada then portalEntrada:Destroy() end
        if portalSalida then portalSalida:Destroy() end
    end)
end)

CreateButton("Portal: OFF", "Portal: EQUIPADO", function(state) portalTool.Parent = state and LP.Backpack or nil end)

-- 🔄 CAMBIADOR DE CUERPO COMPLETO (ESCALAS + APARIENCIA MODERNA)
local swapTool = Instance.new("Tool")
swapTool.Name = "Cambiador de Skins"
swapTool.RequiresHandle = true

local swapHandle = Instance.new("Part")
swapHandle.Name = "Handle"
swapHandle.Size = Vector3.new(1, 1, 1)
swapHandle.Transparency = 1
swapHandle.CanCollide = false
swapHandle.Parent = swapTool

local function ClearAppearance(character)
    for _, obj in pairs(character:GetDescendants()) do
        if obj:IsA("Clothing") or obj:IsA("ShirtGraphic") or obj:IsA("Accessory") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") or obj:IsA("WrapLayer") then
            obj:Destroy()
        end
    end
    local head = character:FindFirstChild("Head")
    if head and head:FindFirstChild("face") then head.face:Destroy() end
end

local function CloneAppearance(source, target)
    for _, obj in pairs(source:GetChildren()) do
        if obj:IsA("Clothing") or obj:IsA("ShirtGraphic") or obj:IsA("Accessory") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            local clone = obj:Clone()
            clone.Parent = target
        end
    end
    local sourceHead = source:FindFirstChild("Head")
    local targetHead = target:FindFirstChild("Head")
    if sourceHead and targetHead and sourceHead:FindFirstChild("face") then
        local faceClone = sourceHead.face:Clone()
        faceClone.Parent = targetHead
    end
    
    local sourceHumanoid = source:FindFirstChildOfClass("Humanoid")
    local targetHumanoid = target:FindFirstChildOfClass("Humanoid")
    if sourceHumanoid and targetHumanoid then
        for _, val in pairs(sourceHumanoid:GetChildren()) do
            if val:IsA("NumberValue") then
                local existing = targetHumanoid:FindFirstChild(val.Name)
                if existing then
                    existing.Value = val.Value
                else
                    val:Clone().Parent = targetHumanoid
                end
            end
        end
    end
end

swapTool.Equipped:Connect(function()
    local clickCon = UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local target = mouse.Target
            if target and target.Parent and target.Parent:FindFirstChildOfClass("Humanoid") then
                local targetChar = target.Parent
                local myChar = LP.Character
                
                if targetChar ~= myChar and myChar and myChar:FindFirstChild("Head") and targetChar:FindFirstChild("Head") then
                    local tempMySkin = Instance.new("Folder")
                    local tempTargetSkin = Instance.new("Folder")
                    
                    CloneAppearance(myChar, tempMySkin)
                    CloneAppearance(targetChar, tempTargetSkin)
                    
                    ClearAppearance(myChar)
                    ClearAppearance(targetChar)
                    
                    CloneAppearance(tempTargetSkin, myChar)
                    CloneAppearance(tempMySkin, targetChar)
                    
                    tempMySkin:Destroy()
                    tempTargetSkin:Destroy()
                end
            end
        end
    end)

    swapTool.Unequipped:Connect(function()
        clickCon:Disconnect()
    end)
end)

CreateButton("Cambiar cuerpo: OFF", "Cambiar cuerpo: EQUIPADO", function(state) 
    if state then
        swapTool.Parent = LP:FindFirstChildOfClass("Backpack") or LP.Character
    else
        swapTool.Parent = nil
    end
end)

-- TP JUGADOR (Lista)
local TPMainBtn = Instance.new("TextButton", Scroll)
TPMainBtn.Size = UDim2.new(0, 220, 0, 35)
TPMainBtn.BackgroundColor3 = Color3.fromRGB(70, 40, 90)
TPMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPMainBtn.Text = "Tp Jugador (Lista)"
TPMainBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", TPMainBtn).CornerRadius = UDim.new(0, 6)

TPMainBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(TPScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LP then
            local pBtn = Instance.new("TextButton", TPScroll)
            pBtn.Size = UDim2.new(1, 0, 0, 30)
            pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.Text = player.DisplayName or player.Name
            pBtn.Font = Enum.Font.SourceSans
            Instance.new("UICorner", pBtn)
            pBtn.MouseButton1Click:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    LP.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                    TPFrame.Visible = false
                end
            end)
        end
    end
    TPFrame.Visible = true
end)

-- 💃 BOTÓN PRINCIPAL: BAILES (+1000)
local DanceMainBtn = Instance.new("TextButton", Scroll)
DanceMainBtn.Size = UDim2.new(0, 220, 0, 35)
DanceMainBtn.BackgroundColor3 = Color3.fromRGB(160, 80, 20)
DanceMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DanceMainBtn.Text = "Bailes (+1000)"
DanceMainBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", DanceMainBtn).CornerRadius = UDim.new(0, 6)

local currentTrack = nil
DanceMainBtn.MouseButton1Click:Connect(function()
    if #DanceScroll:GetChildren() <= 1 then
        for i = 1, 1020 do
            local animId = 507468000 + (i * 15) 
            local dBtn = Instance.new("TextButton", DanceScroll)
            dBtn.Size = UDim2.new(1, 0, 0, 25)
            dBtn.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
            dBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
            dBtn.Text = "Baile / Emote Privado #" .. i
            dBtn.Font = Enum.Font.SourceSans
            dBtn.TextSize = 13
            Instance.new("UICorner", dBtn)
            
            dBtn.MouseButton1Click:Connect(function()
                local char = LP.Character
                local human = char and char:FindFirstChildOfClass("Humanoid")
                if human then
                    if currentTrack then currentTrack:Stop() end
                    local anim = Instance.new("Animation")
                    anim.AnimationId = "rbxassetid://" .. tostring(animId)
                    local success, track = pcall(function() return human:LoadAnimation(anim) end)
                    if success and track then
                        currentTrack = track
                        currentTrack.Looped = true
                        currentTrack:Play()
                    end
                end
            end)
        end
    end
    DanceFrame.Visible = true
end)

StopDanceBtn.MouseButton1Click:Connect(function()
    if currentTrack then currentTrack:Stop() currentTrack = nil end
end)

-- BOTÓN INDEPENDIENTE "SALTAR DE SERVIDOR"
local ServerHopBtn = Instance.new("TextButton", Scroll)
ServerHopBtn.Size = UDim2.new(0, 220, 0, 35)
ServerHopBtn.BackgroundColor3 = Color3.fromRGB(30, 85, 45)
ServerHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerHopBtn.Text = "Saltar de Servidor"
ServerHopBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ServerHopBtn).CornerRadius = UDim.new(0, 6)

ServerHopBtn.MouseButton1Click:Connect(function()
    ServerHopBtn.Text = "Buscando..."
    local x = pcall(function()
        local site = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
        for _, server in pairs(site.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LP)
                break
            end
        end
    end)
    if not x then ServerHopBtn.Text = "Error" task.wait(1) ServerHopBtn.Text = "Saltar de Servidor" end
end)

-- INPUT CON BYPASS DE PRIVACIDAD EN VIVO
local UserJoinFrame = Instance.new("Frame", Scroll)
UserJoinFrame.Size = UDim2.new(0, 220, 0, 70)
UserJoinFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", UserJoinFrame).CornerRadius = UDim.new(0, 6)

local JoinBox = Instance.new("TextBox", UserJoinFrame)
JoinBox.Size = UDim2.new(0, 200, 0, 25)
JoinBox.Position = UDim2.new(0.5, -100, 0, 8)
JoinBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JoinBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinBox.PlaceholderText = "Nombre del usuario..."
JoinBox.Text = ""
JoinBox.Font = Enum.Font.SourceSans
JoinBox.TextSize = 14
Instance.new("UICorner", JoinBox).CornerRadius = UDim.new(0, 4)

local JoinGoBtn = Instance.new("TextButton", UserJoinFrame)
JoinGoBtn.Size = UDim2.new(0, 200, 0, 25)
JoinGoBtn.Position = UDim2.new(0.5, -100, 0, 38)
JoinGoBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
JoinGoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinGoBtn.Text = "Bypass Entrar (Forzar)"
JoinGoBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", JoinGoBtn).CornerRadius = UDim.new(0, 4)

JoinGoBtn.MouseButton1Click:Connect(function()
    local targetUser = JoinBox.Text
    if targetUser == "" then return end
    JoinGoBtn.Text = "Obteniendo ID..."
    
    local targetId
    local idSuccess = pcall(function()
        targetId = Players:GetUserIdFromNameAsync(targetUser)
    end)
    
    if not idSuccess or not targetId then
        JoinGoBtn.Text = "No existe"
        task.wait(1.5)
        JoinGoBtn.Text = "Bypass Entrar (Forzar)"
        return
    end
    
    JoinGoBtn.Text = "Escaneando salas..."
    
    task.spawn(function()
        local foundServer = nil
        local nextPageCursor = ""
        local maxPagesToScan = 8
        local currentPage = 0
        
        while nextPageCursor and currentPage < maxPagesToScan do
            currentPage = currentPage + 1
            local url = 'https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Desc&limit=100'
            if nextPageCursor ~= "" then
                url = url .. "&cursor=" .. nextPageCursor
            end
            
            local success, response = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(url))
            end)
            
            if success and response and response.data then
                for _, server in pairs(response.data) do
                    if server.id and server.playing and server.playing > 0 then
                        foundServer = server.id
                    end
                end
                nextPageCursor = response.nextPageCursor
            else
                break
            end
            if foundServer then break end
        end
        
        if foundServer then
            JoinGoBtn.Text = "¡Sala Hallada! Entrando..."
            TeleportService:TeleportToPlaceInstance(game.PlaceId, foundServer, LP)
        else
            JoinGoBtn.Text = "Intentando Forzado..."
            local lastResort = pcall(function()
                TeleportService:TeleportUserIdsToPlaceInstance(game.PlaceId, game.JobId, {targetId}, LP)
            end)
            if not lastResort then
                JoinGoBtn.Text = "No se pudo forzar"
                task.wait(1.5)
                JoinGoBtn.Text = "Bypass Entrar (Forzar)"
            end
        end
    end)
end)

-- EVENTOS DE ACCIÓN LÓGICA DE VENTANA
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBall.Position = MainFrame.Position
    OpenBall.Visible = true
end)
OpenBall.MouseButton1Click:Connect(function()
    OpenBall.Visible = false
    MainFrame.Position = OpenBall.Position
    MainFrame.Visible = true
end)
TPClose.MouseButton1Click:Connect(function() TPFrame.Visible = false end)
DanceClose.MouseButton1Click:Connect(function() DanceFrame.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
