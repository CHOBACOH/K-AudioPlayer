-- Использование gethui() прячет окно от античитов. Если её нет, используем CoreGui.
local targetParent = (gethui and gethui()) or game:GetService("CoreGui")

-- 1. Создаем графический контейнер
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KBoomboxMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = targetParent

-- 2. Главное окно (Размер 1/8 экрана)
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0.35, 0, 0.42, 0)
MainWindow.Position = UDim2.new(0.325, 0, 0.29, 0)
MainWindow.BackgroundColor3 = Color3.fromRGB(15, 25, 35)
MainWindow.BorderSizePixel = 2
MainWindow.BorderColor3 = Color3.fromRGB(0, 180, 255) -- Электрический голубой неон
MainWindow.ClipsDescendants = true
MainWindow.Active = true
MainWindow.Draggable = true
MainWindow.Parent = ScreenGui

-- ВЕРХНЯЯ ПАНЕЛЬ ЗАГОЛОВКА (Высота 30px)
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Name = "HeaderFrame"
HeaderFrame.Size = UDim2.new(1, 0, 0, 30)
HeaderFrame.Position = UDim2.new(0, 0, 0, 0)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = MainWindow

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "  K-BOOMBOX v1.0"
Title.TextColor3 = Color3.fromRGB(0, 210, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Code
Title.TextSize = 14
Title.Parent = HeaderFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 1, 0)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = HeaderFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 35, 1, 0)
MinimizeButton.Position = UDim2.new(1, -75, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Parent = HeaderFrame

-- ========================================================
-- ПАНЕЛЬ ДЛЯ ТРЕХ ПЕРЕКЛЮЧАТЕЛЕЙ (ВКЛАДОК) — Высота 25px
-- ========================================================
local TabBarFrame = Instance.new("Frame")
TabBarFrame.Name = "TabBarFrame"
TabBarFrame.Size = UDim2.new(1, 0, 0, 25)
TabBarFrame.Position = UDim2.new(0, 0, 0, 30)
TabBarFrame.BackgroundColor3 = Color3.fromRGB(10, 18, 26)
TabBarFrame.BorderSizePixel = 0
TabBarFrame.Parent = MainWindow

-- Вкладка 1 (Search)
local TabButton1 = Instance.new("TextButton")
TabButton1.Size = UDim2.new(0.333, 0, 1, 0)
TabButton1.Position = UDim2.new(0, 0, 0, 0)
TabButton1.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
TabButton1.Text = "Search"
TabButton1.TextColor3 = Color3.fromRGB(0, 210, 255)
TabButton1.Font = Enum.Font.Code
TabButton1.TextSize = 12
TabButton1.Parent = TabBarFrame

-- Вкладка 2 (Favorites)
local TabButton2 = Instance.new("TextButton")
TabButton2.Size = UDim2.new(0.333, 0, 1, 0)
TabButton2.Position = UDim2.new(0.333, 0, 0, 0)
TabButton2.BackgroundColor3 = Color3.fromRGB(12, 22, 32)
TabButton2.Text = "Favorites"
TabButton2.TextColor3 = Color3.fromRGB(100, 150, 180)
TabButton2.Font = Enum.Font.Code
TabButton2.TextSize = 12
TabButton2.Parent = TabBarFrame

-- Вкладка 3 (Settings)
local TabButton3 = Instance.new("TextButton")
TabButton3.Size = UDim2.new(0.334, 0, 1, 0)
TabButton3.Position = UDim2.new(0.666, 0, 0, 0)
TabButton3.BackgroundColor3 = Color3.fromRGB(12, 22, 32)
TabButton3.Text = "Settings"
TabButton3.TextColor3 = Color3.fromRGB(100, 150, 180)
TabButton3.Font = Enum.Font.Code
TabButton3.TextSize = 12
TabButton3.Parent = TabBarFrame

-- ========================================================
-- ОБЩИЙ КОНТЕЙНЕР ДЛЯ РАЗДЕЛОВ
-- ========================================================
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -110)
ContentFrame.Position = UDim2.new(0, 0, 0, 55)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainWindow

-- Панель для Раздела 1 (Search)
local Page1 = Instance.new("Frame")
Page1.Size = UDim2.new(1, 0, 1, 0)
Page1.BackgroundTransparency = 1
Page1.Visible = true
Page1.Parent = ContentFrame

-- Панель для Раздела 2 (Favorites)
local Page2 = Instance.new("Frame")
Page2.Size = UDim2.new(1, 0, 1, 0)
Page2.BackgroundTransparency = 1
Page2.Visible = false
Page2.Parent = ContentFrame

-- Панель для Раздела 3 (Settings)
local Page3 = Instance.new("Frame")
Page3.Size = UDim2.new(1, 0, 1, 0)
Page3.BackgroundTransparency = 1
Page3.Visible = false
Page3.Parent = ContentFrame

-- ========================================================
-- ЭЛЕМЕНТЫ ПЕРВОГО РАЗДЕЛА (SEARCH)
-- ========================================================
local AudioIDInput = Instance.new("TextBox")
AudioIDInput.Name = "AudioIDInput"
AudioIDInput.Size = UDim2.new(0.8, 0, 0, 35)
AudioIDInput.Position = UDim2.new(0.1, 0, 0.15, 0)
AudioIDInput.BackgroundColor3 = Color3.fromRGB(10, 20, 30)
AudioIDInput.BorderSizePixel = 1
AudioIDInput.BorderColor3 = Color3.fromRGB(0, 150, 220)
AudioIDInput.Text = ""
AudioIDInput.PlaceholderText = "Enter Audio ID here..."
AudioIDInput.PlaceholderColor3 = Color3.fromRGB(80, 110, 130)
AudioIDInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AudioIDInput.Font = Enum.Font.Code
AudioIDInput.TextSize = 14
AudioIDInput.ClearTextOnFocus = false
AudioIDInput.Parent = Page1

-- ========================================================
-- СКВОЗНАЯ НИЖНЯЯ ПАНЕЛЬ УПРАВЛЕНИЯ ПЛЕЕРОМ (НА ВСЕ ВКЛАДКИ)
-- ========================================================
local PlayerControls = Instance.new("Frame")
PlayerControls.Name = "PlayerControls"
PlayerControls.Size = UDim2.new(1, 0, 0, 55)
PlayerControls.Position = UDim2.new(0, 0, 1, -55) -- Прижата к самому низу
PlayerControls.BackgroundColor3 = Color3.fromRGB(12, 20, 30)
PlayerControls.BorderSizePixel = 0
PlayerControls.Parent = MainWindow

-- Тонкая неоновая разделительная полоса сверху плеера
local SeparatorLine = Instance.new("Frame")
SeparatorLine.Name = "SeparatorLine"
SeparatorLine.Size = UDim2.new(1, 0, 0, 1)
SeparatorLine.Position = UDim2.new(0, 0, 0, 0)
SeparatorLine.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
SeparatorLine.BorderSizePixel = 0
SeparatorLine.Parent = PlayerControls

-- Контейнер для центрирования кнопок внутри плеера
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Name = "ButtonHolder"
ButtonHolder.Size = UDim2.new(0.9, 0, 0, 35)
ButtonHolder.Position = UDim2.new(0.05, 0, 0.5, -17)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = PlayerControls

-- Функция стиля для кнопок
local function styleMediaButton(btn, text)
    btn.BackgroundColor3 = Color3.fromRGB(18, 30, 45)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 120, 200)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 210, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Parent = ButtonHolder
end

-- 1. Кнопка ПОВТОРА ТРЕКА (Loop) — Слева
local LoopButton = Instance.new("TextButton")
LoopButton.Size = UDim2.new(0, 35, 1, 0)
LoopButton.Position = UDim2.new(0, 0, 0, 0) -- Крайний левый угол
styleMediaButton(LoopButton, "↻")
LoopButton.TextColor3 = Color3.fromRGB(120, 150, 170)

-- 2. Кнопка НАЗАД (Перемотка влево) — Центр-лево
local RewindButton = Instance.new("TextButton")
RewindButton.Size = UDim2.new(0, 40, 1, 0)
RewindButton.Position = UDim2.new(0.5, -70, 0, 0)
styleMediaButton(RewindButton, "◀◀")

-- 3. Центральная кнопка PLAY / PAUSE — Ровно по центру
local PlayPauseButton = Instance.new("TextButton")
PlayPauseButton.Size = UDim2.new(0, 50, 1, 0)
PlayPauseButton.Position = UDim2.new(0.5, -25, 0, 0)
styleMediaButton(PlayPauseButton, "▶")
PlayPauseButton.BackgroundColor3 = Color3.fromRGB(20, 45, 65)
PlayPauseButton.BorderColor3 = Color3.fromRGB(0, 200, 255)
PlayPauseButton.TextSize = 22

-- 4. Кнопка ВПЕРЕД (Перемотка вправо) — Центр-право
local FastForwardButton = Instance.new("TextButton")
FastForwardButton.Size = UDim2.new(0, 40, 1, 0)
FastForwardButton.Position = UDim2.new(0.5, 30, 0, 0)
styleMediaButton(FastForwardButton, "▶▶")

-- 5. Кнопка ЛАЙКА — Справа
local LikeButton = Instance.new("TextButton")
LikeButton.Size = UDim2.new(0, 35, 1, 0)
LikeButton.Position = UDim2.new(1, -35, 0, 0) -- Крайний правый угол
styleMediaButton(LikeButton, "♥")
LikeButton.TextColor3 = Color3.fromRGB(120, 150, 170)

-- ========================================================
-- ЛОГИКА ВЗАИМОДЕЙСТВИЯ (СКРИПТЫ)
-- ========================================================
local isPlaying = false
local isLiked = false
local isLooping = false

PlayPauseButton.MouseButton1Click:Connect(function()
    isPlaying = not isPlaying
    if isPlaying then
        PlayPauseButton.Text = "⏸"
        print("[K-BOOMBOX] Воспроизведение трека ID: " .. AudioIDInput.Text)
    else
        PlayPauseButton.Text = "▶"
        print("[K-BOOMBOX] Пауза")
    end
end)

LikeButton.MouseButton1Click:Connect(function()
    isLiked = not isLiked
    if isLiked then
        LikeButton.TextColor3 = Color3.fromRGB(255, 50, 100)
        print("[K-BOOMBOX] Трек добавлен в избранное")
    else
        LikeButton.TextColor3 = Color3.fromRGB(120, 150, 170)
    end
end)

LoopButton.MouseButton1Click:Connect(function()
    isLooping = not isLooping
    if isLooping then
        LoopButton.TextColor3 = Color3.fromRGB(0, 255, 150)
        print("[K-BOOMBOX] Повтор трека ВКЛ")
    else
        LoopButton.TextColor3 = Color3.fromRGB(120, 150, 170)
        print("[K-BOOMBOX] Повтор трека ВЫКЛ")
    end
end)

RewindButton.MouseButton1Click:Connect(function() print("[K-BOOMBOX] Перемотка назад...") end)
FastForwardButton.MouseButton1Click:Connect(function() print("[K-BOOMBOX] Перемотка вперед...") end)

local function showPage(pageNumber)
    Page1.Visible = (pageNumber == 1)
    TabButton1.BackgroundColor3 = (pageNumber == 1) and Color3.fromRGB(20, 35, 50) or Color3.fromRGB(12, 22, 32)
    TabButton2.BackgroundColor3 = (pageNumber == 2) and Color3.fromRGB(20, 35, 50) or Color3.fromRGB(12, 22, 32)
    TabButton3.BackgroundColor3 = (pageNumber == 3) and Color3.fromRGB(20, 35, 50) or Color3.fromRGB(12, 22, 32)
end

TabButton1.MouseButton1Click:Connect(function() showPage(1) end)
TabButton2.MouseButton1Click:Connect(function() showPage(2) end)
TabButton3.MouseButton1Click:Connect(function() showPage(3) end)

-- ========================================================
-- ЛОГИКА СВОРЯЧИВАНИЯ (ИСПРАВЛЕННАЯ)
-- ========================================================
local isMinimized = false
local originalHeight = MainWindow.Size.Y.Scale

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        -- Скрываем все внутренние элементы, чтобы не наезжали на кнопки шапки
        TabBarFrame.Visible = false
        ContentFrame.Visible = false
        PlayerControls.Visible = false
        
        MainWindow:TweenSize(UDim2.new(0.35, 0, 0, 30), "Out", "Quad", 0.15, true)
        MinimizeButton.Text = "+"
        isMinimized = true
    else
        MainWindow:TweenSize(UDim2.new(0.35, 0, originalHeight, 0), "Out", "Quad", 0.15, true)
        MinimizeButton.Text = "-"
        isMinimized = false
        
        -- Показываем элементы обратно только после раскрытия окна
        task.wait(0.15)
        TabBarFrame.Visible = true
        ContentFrame.Visible = true
        PlayerControls.Visible = true
    end
end)
