-- Использование gethui() прячет окно от античитов. Если её нет, используем CoreGui.
local targetParent = (gethui and gethui()) or game:GetService("CoreGui")

-- 1. Создаем саму графическую оболочку (Экранный контейнер)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoomboxHackMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = targetParent

-- 2. Главное окно (Размер 1/16 экрана — это 0.25 по ширине и 0.25 по высоте)
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0.25, 0, 0.25, 0) -- Ровно 1/16 площади экрана
MainWindow.Position = UDim2.new(0.375, 0, 0.375, 0) -- По центру экрана
MainWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Темный хакерский цвет
MainWindow.BorderSizePixel = 2
MainWindow.BorderColor3 = Color3.fromRGB(0, 255, 100) -- Зеленая неоновая рамка
MainWindow.Active = true
MainWindow.Draggable = true -- Делает окно передвигаемым мышкой
MainWindow.Parent = ScreenGui

-- Текст-заголовок окна
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 0.15, 0)
Title.BackgroundTransparency = 1
Title.Text = "  K-BOOMBOX BYPASS v1.0"
Title.TextColor3 = Color3.fromRGB(0, 255, 100)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Code
Title.TextSize = 14
Title.Parent = MainWindow

-- 3. Кнопка полного ЗАКРЫТИЯ (Крестик)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.15, 0, 0.15, 0)
CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = MainWindow

-- 4. Кнопка СВОРЯЧИВАНИЯ (Минус)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0.15, 0, 0.15, 0)
MinimizeButton.Position = UDim2.new(0.7, 0, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Parent = MainWindow

-- Переменная для отслеживания состояния (свернуто/развернуто)
local isMinimized = false
local originalHeight = MainWindow.Size.Y.Scale

-- ЛОГИКА КНОПКИ ЗАКРЫТИЯ: Полностью удаляет чит-меню с экрана
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ЛОГИКА КНОПКИ СВОРЯЧИВАНИЯ: Сжимает окно до тонкой полоски заголовка
MinimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        -- Сворачиваем: оставляем только высоту заголовка (0.04 от экрана)
        MainWindow:TweenSize(UDim2.new(0.25, 0, 0.04, 0), "Out", "Quad", 0.2, true)
        MinimizeButton.Text = "+"
        isMinimized = true
    else
        -- Разворачиваем обратно в 1/16 экрана
        MainWindow:TweenSize(UDim2.new(0.25, 0, originalHeight, 0), "Out", "Quad", 0.2, true)
        MinimizeButton.Text = "-"
        isMinimized = false
    end
end)
