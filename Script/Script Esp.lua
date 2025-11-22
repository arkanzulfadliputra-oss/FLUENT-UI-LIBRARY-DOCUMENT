local Players = game:GetService("Players") 
local RunService = game:GetService("RunService") 
local LocalPlayer = Players.LocalPlayer 
  
local function createESP(target) 
    if target and target:FindFirstChild("HumanoidRootPart") then 
        local highlight = Instance.new("Highlight") 
        highlight.Parent = target 
        highlight.FillColor = Color3.fromRGB(255, 0, 0)  -- Warna merah untuk Krasue (bisa diubah) 
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)  -- Outline putih 
        highlight.FillTransparency = 0.5  -- Setengah transparan 
        highlight.OutlineTransparency = 0 
         
        local billboard = Instance.new("BillboardGui") 
        billboard.Parent = target 
        billboard.Size = UDim2.new(0, 100, 0, 50) 
        billboard.StudsOffset = Vector3.new(0, 3, 0) 
        billboard.AlwaysOnTop = true 
         
        local label = Instance.new("TextLabel") 
        label.Parent = billboard 
        label.Size = UDim2.new(1, 0, 1, 0) 
        label.BackgroundTransparency = 1 
        label.Text = "Krasue" 
        label.TextColor3 = Color3.fromRGB(255, 255, 255) 
        label.TextStrokeTransparency = 0 
        label.TextScaled = true 
        label.Font = Enum.Font.SourceSansBold 
          
        local connection 
        connection = RunService.Heartbeat:Connect(function() 
            if target.Parent then 
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - target.HumanoidRootPart.Position).Magnitude 
                label.Text = "Krasue - " .. math.floor(distance) .. "m" 
            else 
                connection:Disconnect() 
            end 
        end) 
    end 
end 
  
local krasue = workspace:WaitForChild("Krasue", 10)  -- Tunggu max 10 detik 
if krasue then 
    createESP(krasue) 
    print("ESP Krasue aktif! Posisi terdeteksi.") 
else 
    print("Krasue tidak ditemukan. Pastikan kamu di level yang tepat (misalnya Mansion atau Hotel).") 
end 
 
local espEnabled = true 
game:GetService("UserInputService").InputBegan:Connect(function(input) 
    if input.KeyCode == Enum.KeyCode.E then 
        espEnabled = not espEnabled 
        if krasue then 
            for _, child in pairs(krasue:GetChildren()) do 
                if child:IsA("Highlight") or child:IsA("BillboardGui") then 
                    child.Enabled = espEnabled 
                end 
            end 
        end 
        print("ESP Krasue: " .. (espEnabled and "ON" or "OFF")) 
    end 
end)
