-- CabiX_X Script con Bordes RGB, Minimizado y Enlace a YouTube
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollContainer = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- Botones de Control de Ventana
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local MinimizeBall = Instance.new("TextButton")

-- Botón de YouTube
local YTButton = Instance.new("ImageButton")

-- Configuración de la GUI Principal
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "CabiX_X_Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 230, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

-- Bordes redondeados para la ventana principal
local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

-- Título Centralizado: "CabiX_X Script"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "CabiX_X Script"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextAlignment = Enum.TextAlignment.Center

-- Botón Cerrar (X)
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

-- Botón Minimizar (-)
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -60, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 14
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 5)

-- Bola Flotante de Minimizado (X-X)
MinimizeBall.Name = "CabiX_X_Ball"
MinimizeBall.Parent = ScreenGui
MinimizeBall.Size = UDim2.new(0, 50, 0, 50)
MinimizeBall.Position = UDim2.new(0.1, 0, 0.2, 0)
MinimizeBall.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MinimizeBall.Text = "X-X"
MinimizeBall.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBall.Font = Enum.Font.SourceSansBold
MinimizeBall.TextSize = 16
MinimizeBall.Visible = false
MinimizeBall.Active = true
MinimizeBall.Draggable = true
local BallCorner = Instance.new("UICorner", MinimizeBall)
BallCorner.CornerRadius = UDim.new(1, 0) -- Lo hace una bola perfecta

-- Botón de YouTube con Logo Oficial
YTButton.Parent = MainFrame
YTButton.Size = UDim2.new(0, 25, 0, 25)
YTButton.Position = UDim2.new(0, 8, 0, 5)
YTButton.BackgroundTransparency = 1
YTButton.Image = "rbxassetid://13404533033" -- Icono limpio de YouTube en Roblox

-- Contenedor Deslizable (ScrollingFrame)
ScrollContainer.Parent = MainFrame
ScrollContainer.Position = UDim2.new(0, 0, 0, 45)
ScrollContainer.Size = UDim2.new(1, 0, 1, -45)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 640)
ScrollContainer.ScrollBarThickness = 4
ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)

UIListLayout.Parent = ScrollContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Configuración de Colores e Iluminación RGB
local ColorActivo = Color3.fromRGB(0, 255, 200) -- Celeste neón
local ColorInactivo = Color3.fromRGB(40, 40, 40)
local RGBObjects = {}

-- Añadir bordes de línea para el efecto RGB cromático
local function ApplyRGBStroke(object)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = object
    table.insert(RGBObjects, stroke)
end

ApplyRGBStroke(MainFrame)
ApplyRGBStroke(MinimizeBall)

-- Hilo de animación para el ciclo RGB cromático
task.spawn(function()
    while true do
        for i = 0, 1, 0.005 do
            local color = Color3.fromHSV(i, 1, 1)
            for _, stroke in pairs(RGBObjects) do
                stroke.Color = color
            end
            task.wait(0.02)
        end
    end
end)

-- Sistema para crear Toggles Estilizados con bordes RGB
local function CreateToggle(text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollContainer
    btn.Size = UDim2.new(0, 195, 0, 35)
    btn.BackgroundColor3 = ColorInactivo
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    ApplyRGBStroke(btn)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and ColorActivo or ColorInactivo
        if state then btn.TextColor3 = Color3.fromRGB(0, 0, 0) else btn.TextColor3 = Color3.fromRGB(255, 255, 255) end
        callback(state)
    end)
    return btn
end

-- Función para estilizar Cajas de Texto
local function StyleTextBox(box)
    ApplyRGBStroke(box)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
end

-- --- ACCIONES DE VENTANA ---
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizeBall.Position = MainFrame.Position
    MinimizeBall.Visible = true
end)

MinimizeBall.MouseButton1Click:Connect(function()
    MinimizeBall.Visible = false
    MainFrame.Position = MinimizeBall.Position
    MainFrame.Visible = true
end)

YTButton.MouseButton1Click:Connect(function()
    -- Comando nativo que abre el navegador en ejecutores móviles modernos
    if setclipboard then setclipboard("https://youtube.com/@cabixx_xgaming?si=YoRsYbqICYcevzb2") end
    game:GetService("GuiService"):OpenBrowserWindow("https://youtube.com/@cabixx_xgaming?si=YoRsYbqICYcevzb2")
end)

-- --- CARACTERÍSTICAS Y COMANDOS DEL PANEL ---
local LP = game.Players.LocalPlayer
local InfJump = false
local Noclip = false
local Fling = false
local Flying = false

local function GetPlayer(name)
    name = name:lower()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Name:lower():sub(1, #name) == name or (p.DisplayName and p.DisplayName:lower():sub(1, #name) == name) then
            return p
        end
    end
    return nil
end

-- 1. SPEED BOX
local SpeedBox = Instance.new("TextBox", ScrollContainer)
SpeedBox.Size = UDim2.new(0, 195, 0, 35)
SpeedBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.PlaceholderText = "Velocidad (1 - 1000000)"
SpeedBox.Text = ""
SpeedBox.Font = Enum.Font.SourceSans
SpeedBox.TextSize = 14
StyleTextBox(SpeedBox)

SpeedBox.FocusLost:Connect(function()
    local num = tonumber(SpeedBox.Text)
    if num and num >= 1 and num <= 1000000 then
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = num
        end
    end
end)

-- 2. JUMP BOX
local JumpBox = Instance.new("TextBox", ScrollContainer)
JumpBox.Size = UDim2.new(0, 195, 0, 35)
JumpBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
JumpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpBox.PlaceholderText = "Súper Jump (Poder)"
JumpBox.Text = ""
JumpBox.Font = Enum.Font.SourceSans
JumpBox.TextSize = 14
StyleTextBox(JumpBox)

JumpBox.FocusLost:Connect(function()
    local num = tonumber(JumpBox.Text)
    if num then
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.JumpPower = num
        end
    end
end)

-- 3. FLY TOGGLE
CreateToggle("Fly (Volar)", function(state)
    Flying = state
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if Flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "CabiXFly"
        bv.Velocity = Vector3.new(0, 50, 0)
        bv.MaxForce = Vector3.new(0, 9e9, 0)
        bv.Parent = char.HumanoidRootPart
    else
        if char.HumanoidRootPart:FindFirstChild("CabiXFly") then char.HumanoidRootPart.CabiXFly:Destroy() end
    end
end)

-- 4. INFINITE JUMP
CreateToggle("Infinity Jump", function(state)
    InfJump = state
    if InfJump then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if InfJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
                LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end
end)

-- 5. NO CLIP
CreateToggle("No Clip (Paredes)", function(state)
    Noclip = state
    game:GetService("RunService").Stepped:Connect(function()
        if Noclip and LP.Character then
            for _, part in pairs(LP.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)

-- 6. INVISIBLE
CreateToggle("Invisible", function(state)
    if LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if part.Name ~= "HumanoidRootPart" then
                    part.Transparency = state and 1 or 0
                end
            end
        end
    end
end)

-- 7. FORCEFIELD (FF)
local currentFF = nil
CreateToggle("ForceField (Escudo FF)", function(state)
    if state then
        if LP.Character then currentFF = Instance.new("ForceField", LP.Character) end
    else
        if currentFF then currentFF:Destroy() end
    end
end)

-- 8. FLING
CreateToggle("Fling (Empujar Lejos)", function(state)
    Fling = state
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if Fling then
        local bavg = Instance.new("BodyAngularVelocity")
        bavg.Name = "CabiXFling"
        bavg.AngularVelocity = Vector3.new(0, 99999, 0)
        bavg.MaxTorque = Vector3.new(0, 99999, 0)
        bavg.Parent = hrp
    else
        if hrp:FindFirstChild("CabiXFling") then hrp.CabiXFling:Destroy() end
    end
end)

-- 9. FREEZE BOX
local FreezeBox = Instance.new("TextBox", ScrollContainer)
FreezeBox.Size = UDim2.new(0, 195, 0, 35)
FreezeBox.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
FreezeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezeBox.PlaceholderText = "Congelar a (Nombre)"
FreezeBox.Text = ""
FreezeBox.Font = Enum.Font.SourceSansBold
FreezeBox.TextSize = 14
StyleTextBox(FreezeBox)

FreezeBox.FocusLost:Connect(function()
    local target = GetPlayer(FreezeBox.Text)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        target.Character.HumanoidRootPart.Anchored = true
        FreezeBox.Text = "¡Congelado!"
        task.wait(1)
        FreezeBox.Text = ""
    end
end)

-- 10. JAIL BOX
local JailBox = Instance.new("TextBox", ScrollContainer)
JailBox.Size = UDim2.new(0, 195, 0, 35)
JailBox.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
JailBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JailBox.PlaceholderText = "Encarcelar a (Nombre)"
JailBox.Text = ""
JailBox.Font = Enum.Font.SourceSansBold
JailBox.TextSize = 14
StyleTextBox(JailBox)

JailBox.FocusLost:Connect(function()
    local target = GetPlayer(JailBox.Text)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local cf = target.Character.HumanoidRootPart.CFrame
        local jailModel = Instance.new("Model", workspace)
        jailModel.Name = "CabiXJail_" .. target.Name
        
        local function makeWall(pos, size)
            local wall = Instance.new("Part", jailModel)
            wall.Size = size
            wall.CFrame = cf * pos
            wall.Anchored = true
            wall.Material = Enum.Material.ForceField
            wall.Transparency = 0.5
        end
        
        makeWall(CFrame.new(0, -3.5, 0), Vector3.new(10, 1, 10))
        makeWall(CFrame.new(0, 4.5, 0), Vector3.new(10, 1, 10))
        makeWall(CFrame.new(5, 0, 0), Vector3.new(1, 8, 10))
        makeWall(CFrame.new(-5, 0, 0), Vector3.new(1, 8, 10))
        makeWall(CFrame.new(0, 0, 5), Vector3.new(10, 8, 1))
        makeWall(CFrame.new(0, 0, -5), Vector3.new(10, 8, 1))
        
        JailBox.Text = "¡Encarcelado!"
        task.wait(1)
        JailBox.Text = ""
    end
end)
