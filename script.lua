-- Использование gethui() прячет окно от anti-cheat. Если её нет, используем CoreGui.
local targetParent = (gethui and gethui()) or game:GetService("CoreGui")

-- 1. Создаем графический контейнер
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KAudioPlayerMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = targetParent

-- 2. Главное окно (Размер 0.49 для названия и времени трека)
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0.35, 0, 0.49, 0)
MainWindow.Position = UDim2.new(0.325, 0, 0.25, 0)
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
Title.Text = "  K-AUDIOPLAYER v4.6"
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

local TabButton1 = Instance.new("TextButton")
TabButton1.Size = UDim2.new(0.333, 0, 1, 0)
TabButton1.Position = UDim2.new(0, 0, 0, 0)
TabButton1.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
TabButton1.Text = "Search"
TabButton1.TextColor3 = Color3.fromRGB(0, 210, 255)
TabButton1.Font = Enum.Font.Code
TabButton1.TextSize = 12
TabButton1.Parent = TabBarFrame

local TabButton2 = Instance.new("TextButton")
TabButton2.Size = UDim2.new(0.333, 0, 1, 0)
TabButton2.Position = UDim2.new(0.333, 0, 0, 0)
TabButton2.BackgroundColor3 = Color3.fromRGB(12, 22, 32)
TabButton2.Text = "Favorites"
TabButton2.TextColor3 = Color3.fromRGB(100, 150, 180)
TabButton2.Font = Enum.Font.Code
TabButton2.TextSize = 12
TabButton2.Parent = TabBarFrame

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
ContentFrame.Size = UDim2.new(1, 0, 1, -150)
ContentFrame.Position = UDim2.new(0, 0, 0, 55)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainWindow

local Page1 = Instance.new("Frame")
Page1.Size = UDim2.new(1, 0, 1, 0)
Page1.BackgroundTransparency = 1
Page1.Visible = true
Page1.Parent = ContentFrame

local Page2 = Instance.new("ScrollingFrame")
Page2.Size = UDim2.new(1, 0, 1, 0)
Page2.BackgroundTransparency = 1
Page2.Visible = false
Page2.CanvasSize = UDim2.new(0, 0, 0, 0)
Page2.ScrollBarThickness = 4
Page2.Parent = ContentFrame

local Page2Padding = Instance.new("UIPadding")
Page2Padding.PaddingTop = UDim.new(0, 8)
Page2Padding.Parent = Page2

local FavoritesLayout = Instance.new("UIListLayout")
FavoritesLayout.Padding = UDim.new(0, 5)
FavoritesLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
FavoritesLayout.Parent = Page2

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
AudioIDInput.Text = "142376088"
AudioIDInput.PlaceholderText = "Enter Audio ID here..."
AudioIDInput.PlaceholderColor3 = Color3.fromRGB(80, 110, 130)
AudioIDInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AudioIDInput.Font = Enum.Font.Code
AudioIDInput.TextSize = 14
AudioIDInput.ClearTextOnFocus = false
AudioIDInput.Parent = Page1

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(0.8, 0, 0, 20)
StatusLabel.Position = UDim2.new(0.1, 0, 0.55, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
StatusLabel.Font = Enum.Font.SourceSansItalic
StatusLabel.TextSize = 13
StatusLabel.Parent = Page1

-- ========================================================
-- ЭЛЕМЕНТЫ ТРЕТЬЕГО РАЗДЕЛА (SETTINGS)
-- ========================================================
local VolLabel = Instance.new("TextLabel")
VolLabel.Size = UDim2.new(0.8, 0, 0, 15)
VolLabel.Position = UDim2.new(0.1, 0, 0.02, 0)
VolLabel.BackgroundTransparency = 1
VolLabel.Text = "Volume: 100%"
VolLabel.TextColor3 = Color3.fromRGB(0, 210, 255)
VolLabel.Font = Enum.Font.Code
VolLabel.TextSize = 12
VolLabel.Parent = Page3

local VolSlider = Instance.new("TextButton")
VolSlider.Name = "VolSlider"
VolSlider.Size = UDim2.new(0.8, 0, 0, 10)
VolSlider.Position = UDim2.new(0.1, 0, 0.18, 0)
VolSlider.BackgroundColor3 = Color3.fromRGB(10, 20, 30)
VolSlider.BorderSizePixel = 1
VolSlider.BorderColor3 = Color3.fromRGB(0, 120, 200)
VolSlider.Text = ""
VolSlider.Parent = Page3

local VolBar = Instance.new("Frame")
VolBar.Name = "VolBar"
VolBar.Size = UDim2.new(1, 0, 1, 0)
VolBar.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
VolBar.BorderSizePixel = 0
VolBar.Parent = VolSlider

local BypassBtn = Instance.new("TextButton")
BypassBtn.Name = "BypassBtn"
BypassBtn.Size = UDim2.new(0.55, 0, 0, 30)
BypassBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
BypassBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 50)
BypassBtn.BorderSizePixel = 1
BypassBtn.BorderColor3 = Color3.fromRGB(0, 180, 255)
BypassBtn.Text = "LAUNCH K-BYPASS CONSOLE"
BypassBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BypassBtn.Font = Enum.Font.Code
BypassBtn.TextSize = 10
BypassBtn.Parent = Page3

local TgButton = Instance.new("TextButton")
TgButton.Name = "TgButton"
TgButton.Size = UDim2.new(0.3, 0, 0, 30)
TgButton.Position = UDim2.new(0.65, 0, 0.45, 0)
TgButton.BackgroundColor3 = Color3.fromRGB(15, 40, 60)
TgButton.BorderSizePixel = 1
TgButton.BorderColor3 = Color3.fromRGB(0, 150, 220)
TgButton.Text = "🔗 Telegram"
TgButton.TextColor3 = Color3.fromRGB(0, 210, 255)
TgButton.Font = Enum.Font.Code
TgButton.TextSize = 11
TgButton.Parent = Page3 -- ========================================================
-- СКВОЗНАЯ НИЖНЯЯ ПАНЕЛЬ K-AUDIOPLAYER С НАЗВАНИЕМ И ВРЕМЕНЕМ
-- ========================================================
local PlayerControls = Instance.new("Frame")
PlayerControls.Name = "PlayerControls"
PlayerControls.Size = UDim2.new(1, 0, 0, 95)
PlayerControls.Position = UDim2.new(0, 0, 1, -95)
PlayerControls.BackgroundColor3 = Color3.fromRGB(12, 20, 30)
PlayerControls.BorderSizePixel = 0
PlayerControls.Parent = MainWindow

local SeparatorLine = Instance.new("Frame")
SeparatorLine.Name = "SeparatorLine"
SeparatorLine.Size = UDim2.new(1, 0, 0, 1)
SeparatorLine.Position = UDim2.new(0, 0, 0, 0)
SeparatorLine.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
SeparatorLine.BorderSizePixel = 0
SeparatorLine.Parent = PlayerControls

local TrackNameLabel = Instance.new("TextLabel")
TrackNameLabel.Name = "TrackNameLabel"
TrackNameLabel.Size = UDim2.new(0.9, 0, 0, 20)
TrackNameLabel.Position = UDim2.new(0.05, 0, 0, 8)
TrackNameLabel.BackgroundTransparency = 1
TrackNameLabel.Text = "No Track Loaded"
TrackNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TrackNameLabel.Font = Enum.Font.SourceSansItalic
TrackNameLabel.TextSize = 14
TrackNameLabel.Parent = PlayerControls

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Name = "TimeLabel"
TimeLabel.Size = UDim2.new(0.9, 0, 0, 15)
TimeLabel.Position = UDim2.new(0.05, 0, 0, 28)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = "0:00 / 0:00"
TimeLabel.TextColor3 = Color3.fromRGB(0, 150, 220)
TimeLabel.Font = Enum.Font.Code
TimeLabel.TextSize = 12
TimeLabel.Parent = PlayerControls

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Name = "ButtonHolder"
ButtonHolder.Size = UDim2.new(0.9, 0, 0, 35)
ButtonHolder.Position = UDim2.new(0.05, 0, 0, 48)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = ButtonHolder

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

local LoopButton = Instance.new("TextButton")
LoopButton.Size = UDim2.new(0, 35, 1, 0)
LoopButton.Position = UDim2.new(0, 0, 0, 0)
styleMediaButton(LoopButton, "↻")
LoopButton.TextColor3 = Color3.fromRGB(120, 150, 170)

local RewindButton = Instance.new("TextButton")
RewindButton.Size = UDim2.new(0, 40, 1, 0)
RewindButton.Position = UDim2.new(0.5, -70, 0, 0)
styleMediaButton(RewindButton, "◀◀")

local PlayPauseButton = Instance.new("TextButton")
PlayPauseButton.Size = UDim2.new(0, 50, 1, 0)
PlayPauseButton.Position = UDim2.new(0.5, -25, 0, 0)
styleMediaButton(PlayPauseButton, "▶")
PlayPauseButton.BackgroundColor3 = Color3.fromRGB(20, 45, 65)
PlayPauseButton.BorderColor3 = Color3.fromRGB(0, 200, 255)
PlayPauseButton.TextSize = 22

local FastForwardButton = Instance.new("TextButton")
FastForwardButton.Size = UDim2.new(0, 40, 1, 0)
FastForwardButton.Position = UDim2.new(0.5, 30, 0, 0)
styleMediaButton(FastForwardButton, "▶▶")

local LikeButton = Instance.new("TextButton")
LikeButton.Size = UDim2.new(0, 35, 1, 0)
LikeButton.Position = UDim2.new(1, -35, 0, 0)
styleMediaButton(LikeButton, "♥")
LikeButton.TextColor3 = Color3.fromRGB(120, 150, 170)

-- ========================================================
-- ФАЙЛОВАЯ СИСТЕМА ДЛЯ DELTA (УСТРОЙСТВО ХАКЕРА)
-- ========================================================
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local isPlaying = false
local isLooping = false

local HiddenSound = Instance.new("Sound")
HiddenSound.Name = "KAudioPlayer_SoundSource"
HiddenSound.Parent = game:GetService("SoundService")

local currentLoadedID = "142376088"
local favoritesList = {}

if makefolder and isfolder then
    if not isfolder("K-AudioPlayer") then
        makefolder("K-AudioPlayer")
    end
end

local function loadFavoritesFromFile()
    if readfile and isfile and isfile("K-AudioPlayer/favorites.txt") then
        local success, data = pcall(function() 
            return HttpService:JSONDecode(readfile("K-AudioPlayer/favorites.txt")) 
        end)
        if success and type(data) == "table" then favoritesList = data end
    end
end

local function saveFavoritesToFile()
    if writefile then
        pcall(function() 
            writefile("K-AudioPlayer/favorites.txt", HttpService:JSONEncode(favoritesList)) 
        end)
    end
end

local function checkLikeStatus()
    local liked = table.find(favoritesList, currentLoadedID) ~= nil
    LikeButton.TextColor3 = liked and Color3.fromRGB(255, 50, 100) or Color3.fromRGB(120, 150, 170)
end

local function loadAndPlayTrack(id)
    StatusLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
    StatusLabel.Text = "Checking track validity..."
    
    task.spawn(function()
        local info
        local success = pcall(function() info = MarketplaceService:GetProductInfo(tonumber(id)) end)
        
        if not success or not info or info.AssetTypeId ~= 3 then
            StatusLabel.TextColor3 = Color3.fromRGB(250, 50, 50)
            StatusLabel.Text = "⛔ Error: Unknown Audio Track"
            return
        end
        
        HiddenSound:Stop()
        HiddenSound.SoundId = "rbxassetid://" .. id
        currentLoadedID = id
        checkLikeStatus()
        
        TrackNameLabel.Text = info.Name
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        StatusLabel.Text = "Track Loaded Successfully ✓"
        
        isPlaying = true
        PlayPauseButton.Text = "⏸"
        HiddenSound:Play()
    end)
end

local function updateFavoritesPage()
    for _, item in ipairs(Page2:GetChildren()) do if item:IsA("TextButton") then item:Destroy() end end
    
    for i, id in ipairs(favoritesList) do
        local FavTrackBtn = Instance.new("TextButton")
        FavTrackBtn.Size = UDim2.new(0, 220, 0, 30)
        FavTrackBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
        FavTrackBtn.BorderSizePixel = 1
        FavTrackBtn.BorderColor3 = Color3.fromRGB(0, 150, 220)
        FavTrackBtn.Text = "  ID: " .. id
        FavTrackBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
        FavTrackBtn.Font = Enum.Font.Code
        FavTrackBtn.TextSize = 13
        FavTrackBtn.TextXAlignment = Enum.TextXAlignment.Left
        FavTrackBtn.Parent = Page2
        
        task.spawn(function()
            pcall(function()
                local info = MarketplaceService:GetProductInfo(tonumber(id))
                if info then FavTrackBtn.Text = "  " .. info.Name end
            end)
        end)
        
        FavTrackBtn.MouseButton1Click:Connect(function()
            AudioIDInput.Text = id
            loadAndPlayTrack(id)
        end)
    end
    Page2.CanvasSize = UDim2.new(0, 0, 0, FavoritesLayout.AbsoluteContentSize.Y)
end

loadFavoritesFromFile()

LikeButton.MouseButton1Click:Connect(function()
    local index = table.find(favoritesList, currentLoadedID)
    if index then table.remove(favoritesList, index) else table.insert(favoritesList, currentLoadedID) end
    saveFavoritesToFile()
    checkLikeStatus()
    updateFavoritesPage()
end)

local function formatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local remSeconds = math.floor(seconds % 60)
    return string.format("%d:%02d", minutes, remSeconds)
end

AudioIDInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local inputID = AudioIDInput.Text:match("%d+")
        if not inputID then
            StatusLabel.TextColor3 = Color3.fromRGB(250, 50, 50)
            StatusLabel.Text = "⛔ Error: Invalid ID"
            return
        end
        loadAndPlayTrack(inputID)
    end
end)

PlayPauseButton.MouseButton1Click:Connect(function()
    if HiddenSound.SoundId == "" then return end
    isPlaying = not isPlaying
    if isPlaying then PlayPauseButton.Text = "⏸" HiddenSound:Resume() else PlayPauseButton.Text = "▶" HiddenSound:Pause() end
end)

task.spawn(function()
    while task.wait(0.5) do
        if HiddenSound.IsPlaying or not isPlaying then
            TimeLabel.Text = formatTime(HiddenSound.TimePosition) .. " / " .. formatTime(HiddenSound.TimeLength)
        end
    end
end)

LoopButton.MouseButton1Click:Connect(function()
    isLooping = not isLooping
    HiddenSound.Looped = isLooping
    LoopButton.TextColor3 = isLooping and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(120, 150, 170)
end)

RewindButton.MouseButton1Click:Connect(function()
    if #favoritesList <= 1 then return end
    local currentIndex = table.find(favoritesList, currentLoadedID)
    local targetIndex = 1
    if currentIndex then
        if currentIndex == 1 then targetIndex = #favoritesList else targetIndex = currentIndex - 1 end
    end
    local nextID = favoritesList[targetIndex]
    AudioIDInput.Text = nextID
    loadAndPlayTrack(nextID)
end)

FastForwardButton.MouseButton1Click:Connect(function()
    if #favoritesList <= 1 then return end
    local currentIndex = table.find(favoritesList, currentLoadedID)
    local targetIndex = 1
    if currentIndex then
        if currentIndex == #favoritesList then targetIndex = 1 else targetIndex = currentIndex + 1 end
    end
    local nextID = favoritesList[targetIndex]
    AudioIDInput.Text = nextID
    loadAndPlayTrack(nextID)
end)

-- ========================================================
-- ЛОГИКА ДЛЯ ВКЛАДКИ НАСТРОЕК (SETTINGS)
-- ========================================================
VolSlider.MouseButton1Down:Connect(function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local sliderWidth = VolSlider.AbsoluteSize.X
    local startX = VolSlider.AbsolutePosition.X
    local relativeX = math.clamp(mouse.X - startX, 0, sliderWidth)
    local volumePercent = relativeX / sliderWidth BypassBtn.MouseButton1Click:Connect(function()
    local rawUrl = "https://githubusercontent.com"
    pcall(function() loadstring(game:HttpGet(rawUrl))() end)
    end)
end)
TgButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("://tg.com")
        TgButton.Text = "✓ Copied!"
        task.wait(2)
        TgButton.Text = "🔗 Telegram"
    end
end)

local function showPage(pageNumber)
    Page1.Visible = (pageNumber == 1)
    Page2.Visible = (pageNumber == 2)
    Page3.Visible = (pageNumber == 3)
    if pageNumber == 2 then updateFavoritesPage() end
    TabButton1.BackgroundColor3 = (pageNumber == 1) and Color3.fromRGB(20, 35, 50) or Color3.fromRGB(12, 22, 32)
    TabButton2.BackgroundColor3 = (pageNumber == 2) and Color3.fromRGB(20, 35, 50) or Color3.fromRGB(12, 22, 32)
    TabButton3.BackgroundColor3 = (pageNumber == 3) and Color3.fromRGB(20, 35, 50) or Color3.fromRGB(12, 22, 32)
end

TabButton1.MouseButton1Click:Connect(function() showPage(1) end)
TabButton2.MouseButton1Click:Connect(function() showPage(2) end)
TabButton3.MouseButton1Click:Connect(function() showPage(3) end)

-- ========================================================
-- ЛОГИКА СВОРЯЧИВАНИЯ и ЗАКРЫТИЯ
-- ========================================================
local isMinimized = false
local originalHeight = MainWindow.Size.Y.Scale

CloseButton.MouseButton1Click:Connect(function()
    HiddenSound:Destroy()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
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
        
        task.wait(0.15)
        TabBarFrame.Visible = true
        ContentFrame.Visible = true
        PlayerControls.Visible = true
    end
end)
