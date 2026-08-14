-- =============================================================================
-- FIX ADVANCED K-AUDIO PLAYER v2.1 (ИСПРАВЛЕНА ОШИБКА БЛОКИРОВКИ КОРНЕВОГО UI)
-- =============================================================================
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
-- ИСПРАВЛЕНИЕ: Используем PlayerGui вместо заблокированного CoreGui
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Таблица для хранения избранных треков (изначально пустая)
local favorites = {}
local currentTrackIndex = 0
local isShuffle = false
local isLoop = false
local currentAudioId = ""

-- Создание аудио-объекта в памяти игры
local bgm = SoundService:FindFirstChild("KevinRadioAdvanced")
if bgm then bgm:Destroy() end

bgm = Instance.new("Sound")
bgm.Name = "KevinRadioAdvanced"
bgm.Volume = 2
bgm.Parent = SoundService

-- 1. ГЛАВНЫЙ ИНТЕРФЕЙС
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KevinRadioAdvancedMenu"
ScreenGui.ResetOnSpawn = false -- Меню не пропадет, если персонаж Кевина умрет
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 340)
MainFrame.Position = UDim2.new(0.6, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 180, 255)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Дисплей текущего трека (сверху)
local TrackDisplay = Instance.new("TextLabel")
TrackDisplay.Size = UDim2.new(1, -20, 0, 30)
TrackDisplay.Position = UDim2.new(0, 10, 0, 10)
TrackDisplay.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TrackDisplay.Text = "ID: None (Stopped)"
TrackDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
TrackDisplay.Font = Enum.Font.Code
TrackDisplay.TextSize = 12
TrackDisplay.Parent = MainFrame

-- 2. ПАНЕЛЬ НАВИГАЦИИ (ВКЛАДКИ)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TabBar.Parent = MainFrame

local Tab1Btn = Instance.new("TextButton")
Tab1Btn.Size = UDim2.new(0.33, 0, 1, 0)
Tab1Btn.Position = UDim2.new(0, 0, 0, 0)
Tab1Btn.Text = "Поиск ID"
Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Tab1Btn.Parent = TabBar

local Tab2Btn = Instance.new("TextButton")
Tab2Btn.Size = UDim2.new(0.33, 0, 1, 0)
Tab2Btn.Position = UDim2.new(0.33, 0, 0, 0)
Tab2Btn.Text = "Избранное"
Tab2Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
Tab2Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Tab2Btn.Parent = TabBar

local Tab3Btn = Instance.new("TextButton")
Tab3Btn.Size = UDim2.new(0.34, 0, 1, 0)
Tab3Btn.Position = UDim2.new(0.66, 0, 0, 0)
Tab3Btn.Text = "Настройки"
Tab3Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
Tab3Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Tab3Btn.Parent = TabBar

-- 3. КОНТЕЙНЕРЫ ДЛЯ ВКЛАДОК
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 0, 140)
ContentFrame.Position = UDim2.new(0, 10, 0, 90)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- ВКЛАДКА 1: Поиск/Ввод ID
local Page1 = Instance.new("Frame")
Page1.Size = UDim2.new(1, 0, 1, 0)
Page1.BackgroundTransparency = 1
Page1.Parent = ContentFrame

local IdInput = Instance.new("TextBox")
IdInput.Size = UDim2.new(1, 0, 0, 40)
IdInput.Position = UDim2.new(0, 0, 0, 20)
IdInput.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
IdInput.PlaceholderText = "Введи ID трека сюда..."
IdInput.Text = ""
IdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
IdInput.Parent = Page1

local LoadBtn = Instance.new("TextButton")
LoadBtn.Size = UDim2.new(1, 0, 0, 40)
LoadBtn.Position = UDim2.new(0, 0, 0, 75)
LoadBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
LoadBtn.Text = "ЗАГРУЗИТЬ И ИГРАТЬ"
LoadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadBtn.Parent = Page1

-- ВКЛАДКА 2: Избранное (Список)
local Page2 = Instance.new("ScrollingFrame")
Page2.Size = UDim2.new(1, 0, 1, 0)
Page2.BackgroundTransparency = 1
Page2.CanvasSize = UDim2.new(0, 0, 2, 0)
Page2.Visible = false
Page2.Parent = ContentFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = Page2

-- ВКЛАДКА 3: Настройки
local Page3 = Instance.new("Frame")
Page3.Size = UDim2.new(1, 0, 1, 0)
Page3.BackgroundTransparency = 1
Page3.Visible = false
Page3.Parent = ContentFrame

local VolLabel = Instance.new("TextLabel")
VolLabel.Size = UDim2.new(1, 0, 0, 30)
VolLabel.Text = "Громкость звука: 2.0"
VolLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
VolLabel.BackgroundTransparency = 1
VolLabel.Parent = Page3

-- Логика переключения вкладок
local function showPage(pageNumber)
Page1.Visible = (pageNumber == 1)
Page2.Visible = (pageNumber == 2)
Page3.Visible = (pageNumber == 3)

Tab1Btn.TextColor3 = pageNumber == 1 and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,150)
Tab1Btn.BackgroundColor3 = pageNumber == 1 and Color3.fromRGB(45,45,55) or Color3.fromRGB(35,35,45)

Tab2Btn.TextColor3 = pageNumber == 2 and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,150)
Tab2Btn.BackgroundColor3 = pageNumber == 2 and Color3.fromRGB(45,45,55) or Color3.fromRGB(35,35,45)

Tab3Btn.TextColor3 = pageNumber == 3 and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,150)
Tab3Btn.BackgroundColor3 = pageNumber == 3 and Color3.fromRGB(45,45,55) or Color3.fromRGB(35,35,45)
end

Tab1Btn.MouseButton1Click:Connect(function() showPage(1) end)
Tab2Btn.MouseButton1Click:Connect(function() showPage(2) end)
Tab3Btn.MouseButton1Click:Connect(function() showPage(3) end)


-- =============================================================================
-- 4. НИЖНЯЯ ПАНЕЛЬ УПРАВЛЕНИЯ (ПЛЕЕР)
-- =============================================================================
local ControlPanel = Instance.new("Frame")
ControlPanel.Size = UDim2.new(1, -20, 0, 90)
ControlPanel.Position = UDim2.new(0, 10, 0, 240)
ControlPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ControlPanel.Parent = MainFrame

-- Кнопки управления (Ряд 1)
local PrevBtn = Instance.new("TextButton")
PrevBtn.Size = UDim2.new(0, 45, 0, 35)
PrevBtn.Position = UDim2.new(0, 10, 0, 10)
PrevBtn.Text = "<<"
PrevBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PrevBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PrevBtn.Parent = ControlPanel

local PlayBtn = Instance.new("TextButton")
PlayBtn.Size = UDim2.new(0, 65, 0, 35)
PlayBtn.Position = UDim2.new(0, 60, 0, 10)
PlayBtn.Text = "PLAY"
PlayBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
PlayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayBtn.Parent = ControlPanel

local NextBtn = Instance.new("TextButton")
NextBtn.Size = UDim2.new(0, 45, 0, 35)
NextBtn.Position = UDim2.new(0, 130, 0, 10)
NextBtn.Text = ">>"
NextBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
NextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NextBtn.Parent = ControlPanel

local LikeBtn = Instance.new("TextButton")
LikeBtn.Size = UDim2.new(0, 90, 0, 35)
LikeBtn.Position = UDim2.new(0, 180, 0, 10)
LikeBtn.Text = "♥ LIKE"
LikeBtn.BackgroundColor3 = Color3.fromRGB(50, 35, 45)
LikeBtn.TextColor3 = Color3.fromRGB(255, 100, 150)
LikeBtn.Parent = ControlPanel

-- Кнопки режимов (Ряд 2)
local ShuffleBtn = Instance.new("TextButton")
ShuffleBtn.Size = UDim2.new(0, 125, 0, 30)
ShuffleBtn.Position = UDim2.new(0, 10, 0, 50)
ShuffleBtn.Text = "RANDOM: OFF"
ShuffleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ShuffleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ShuffleBtn.Parent = ControlPanel

local LoopBtn = Instance.new("TextButton")
LoopBtn.Size = UDim2.new(0, 125, 0, 30)
LoopBtn.Position = UDim2.new(0, 145, 0, 50)
LoopBtn.Text = "LOOP: OFF"
LoopBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
LoopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoopBtn.Parent = ControlPanel


-- =============================================================================
-- ЛОГИКА ФУНКЦИОНАЛА
-- =============================================================================

-- Функция запуска конкретного ID
local function playAudio(id)
currentAudioId = id
bgm.SoundId = "rbxassetid://" .. id
bgm:Play()
PlayBtn.Text = "PAUSE"
PlayBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
TrackDisplay.Text = "ID: " .. id
end

-- Обновление вкладки Избранное
local function refreshFavoritesUI()
for _, child in pairs(Page2:GetChildren()) do
if child:IsA("TextButton") then child:Destroy() end
end
for i, id in ipairs(favorites) do
local FavItem = Instance.new("TextButton")
FavItem.Size = UDim2.new(1, 0, 0, 30)
FavItem.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
FavItem.Text = "Трек ID: " .. id
FavItem.TextColor3 = Color3.fromRGB(255, 255, 255)
FavItem.Parent = Page2

FavItem.MouseButton1Click:Connect(function()
currentTrackIndex = i
playAudio(id)
end)
end
end

-- Нажатие "Загрузить и играть"
LoadBtn.MouseButton1Click:Connect(function()
local text = IdInput.Text:gsub("%D", "") -- Очистка от букв, оставляем только цифры
if text ~= "" then
playAudio(text)
end
end)

-- Управление кнопкой PLAY/PAUSE
PlayBtn.MouseButton1Click:Connect(function()
if bgm.IsPlaying then
bgm:Pause()
PlayBtn.Text = "PLAY"
PlayBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
else
if currentAudioId ~= "" then
bgm:Resume()
PlayBtn.Text = "PAUSE"
PlayBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end
end
end)

-- Кнопка LIKE (Добавить в Избранное)
LikeBtn.MouseButton1Click:Connect(function()
if currentAudioId ~= "" then
-- Проверяем, нет ли уже этого ID в таблице
local found = falsefor _, id in ipairs(favorites) doif id == currentAudioId then found = true break endendif not found thentable.insert(favorites, currentAudioId)currentTrackIndex = #favoritesrefreshFavoritesUI() 
-- Анимация кнопки
LikeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 100)task.delay(0.3, function() LikeBtn.BackgroundColor3 = Color3.fromRGB(50, 35, 45) end)endendend) 
-- Переключатель RANDOM (Shuffle)ShuffleBtn.MouseButton1Click:Connect(function()isShuffle = not isShuffleShuffleBtn.Text = isShuffle and "RANDOM: ON" or "RANDOM: OFF"ShuffleBtn.BackgroundColor3 = isShuffle and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(40, 40, 50)end) 
-- Переключатель LOOP (Повтор)LoopBtn.MouseButton1Click:Connect(function()isLoop = not isLoopbgm.Looped = isLoopLoopBtn.Text = isLoop and "LOOP: ON" or "LOOP: OFF"LoopBtn.BackgroundColor3 = isLoop and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(40, 40, 50)end) 
-- Навигация: Следующий трек (>>)NextBtn.MouseButton1Click:Connect(function()if #favorites == 0 then return endif isShuffle thencurrentTrackIndex = math.random(1, #favorites)elsecurrentTrackIndex = currentTrackIndex + 1if currentTrackIndex > #favorites then currentTrackIndex = 1 endendplayAudio(favorites[currentTrackIndex])end) 
-- Навигация: Предыдущий трек (<<)PrevBtn.MouseButton1Click:Connect(function()if #favorites == 0 then return endcurrentTrackIndex = currentTrackIndex - 1if currentTrackIndex < 1 then currentTrackIndex = #favorites endplayAudio(favorites[currentTrackIndex])end) -- Автопереключение при окончании
bgm.Ended:Connect(function()if isLoop then return endif #favorites > 0 thenif isShuffle thencurrentTrackIndex = math.random(1, #favorites)elsecurrentTrackIndex = currentTrackIndex + 1if currentTrackIndex > #favorites then currentTrackIndex = 1 endendplayAudio(favorites[currentTrackIndex])elsePlayBtn.Text = "PLAY"PlayBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)endend)
