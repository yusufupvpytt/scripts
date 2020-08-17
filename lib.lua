local PolarLibrary = {windows = 0}
local dragger = {}; 
local resizer = {};

do
	local mouse = game:GetService("Players").LocalPlayer:GetMouse();
	local inputService = game:GetService('UserInputService');
	local heartbeat = game:GetService("RunService").Heartbeat;
	-- // credits to Ririchi / Inori for this cute drag function :)
	function dragger.new(frame)
	    local s, event = pcall(function()
	    	return frame.MouseEnter
	    end)

	    if s then
	    	frame.Active = true;

	    	event:connect(function()
	    		local input = frame.InputBegan:connect(function(key)
	    			if key.UserInputType == Enum.UserInputType.MouseButton1 then
	    				local objectPosition = Vector2.new(mouse.X - frame.AbsolutePosition.X, mouse.Y - frame.AbsolutePosition.Y);
	    				while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
	    					frame:TweenPosition(UDim2.new(0, mouse.X - objectPosition.X + (frame.Size.X.Offset * frame.AnchorPoint.X), 0, mouse.Y - objectPosition.Y + (frame.Size.Y.Offset * frame.AnchorPoint.Y)), 'Out', 'Quad', 0.1, true);
	    				end
	    			end
	    		end)

	    		local leave;
	    		leave = frame.MouseLeave:connect(function()
	    			input:disconnect();
	    			leave:disconnect();
	    		end)
	    	end)
	    end
	end
	
	function resizer.new(p, s)
		p:GetPropertyChangedSignal('AbsoluteSize'):connect(function()
			s.Size = UDim2.new(s.Size.X.Scale, s.Size.X.Offset, s.Size.Y.Scale, p.AbsoluteSize.Y);
		end)
	end
end
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Library = {
    Colors = {
        Body = Color3.fromRGB(20, 20, 20);
        Section = Color3.fromRGB(40, 40, 40);
        CheckboxChecked = Color3.fromRGB(255, 255, 255);
        CheckboxUnchecked = Color3.fromRGB(50, 50, 50);
        Button = Color3.fromRGB(45, 45, 45);
        ColorPickerMarker = Color3.fromRGB(150, 150, 150);
        SliderBackground = Color3.fromRGB(50, 50, 50);
        Slider = Color3.fromRGB(255, 255, 255);
        Dropdown = Color3.fromRGB(45, 45, 45);
        DropdownButton = Color3.fromRGB(35, 35, 35);
        DropdownButtonHover = Color3.fromRGB(45, 45, 45);
        Underline = Color3.fromRGB(255, 92, 92);
        Border = Color3.fromRGB(0, 0, 0);
        Text = Color3.fromRGB(255, 255, 255);
        PlaceholderText = Color3.fromRGB(255, 255, 255);
    };

    Settings = {
        MainTextSize = 15;
        MainTweenTime = 1;
        RippleTweenTime = 1;
        CheckboxTweenTime = 0.5;
        ColorPickerTweenTime = 0.5;
        DropdownTweenTime = 0.5;
        DropdownButtonColorHoverTweenTime = 0.5;
        MainTextFont = Enum.Font.Code;
        UIToggleKey = Enum.KeyCode.RightControl;
        TweenEasingStyle = Enum.EasingStyle.Quart;
    }
}
default = {
    topcolor       = Color3.fromRGB(30, 30, 30);
    titlecolor     = Color3.fromRGB(255, 255, 255);
    
    underlinecolor = Color3.fromRGB(0, 255, 140);
    bgcolor        = Color3.fromRGB(35, 35, 35);
    boxcolor       = Color3.fromRGB(35, 35, 35);
    btncolor       = Color3.fromRGB(25, 25, 25);
    dropcolor      = Color3.fromRGB(25, 25, 25);
    sectncolor     = Color3.fromRGB(25, 25, 25);
    bordercolor    = Color3.fromRGB(60, 60, 60);

    font           = Enum.Font.SourceSans;
    titlefont      = Enum.Font.Code;

    fontsize       = 17;
    titlesize      = 18;

    textstroke     = 1;
    titlestroke    = 1;

    strokecolor    = Color3.fromRGB(0, 0, 0);

    textcolor      = Color3.fromRGB(255, 255, 255);
    titletextcolor = Color3.fromRGB(255, 255, 255);

    placeholdercolor = Color3.fromRGB(255, 255, 255);
    titlestrokecolor = Color3.fromRGB(0, 0, 0);
}

options = setmetatable({}, {__index = default})
function RippleEffect(button)
    spawn(function()
        local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local RippleHolder = Instance.new("Frame")
        local RippleEffect = Instance.new("ImageLabel")

        RippleHolder.Name = "RippleHolder"
        RippleHolder.Parent = button
        RippleHolder.BackgroundColor3 = Library.Colors.Border
        RippleHolder.BackgroundTransparency = 1
        RippleHolder.BorderColor3 = Library.Colors.Border
        RippleHolder.BorderSizePixel = 0
        RippleHolder.ClipsDescendants = true
        RippleHolder.Size = UDim2.new(0, 157, 0, 31)

        RippleEffect.Name = "RippleEffect"
        RippleEffect.Parent = RippleHolder
        RippleEffect.BackgroundTransparency = 1
        RippleEffect.BorderSizePixel = 0
        RippleEffect.Image = "rbxassetid://2708891598"
        RippleEffect.ImageColor3 = Color3.fromRGB(0,0,0)
        RippleEffect.ImageTransparency = 0.8
        RippleEffect.ScaleType = Enum.ScaleType.Fit

        RippleEffect.Position = UDim2.new((Mouse.X - RippleEffect.AbsolutePosition.X) / button.AbsoluteSize.X, 0, (Mouse.Y - RippleEffect.AbsolutePosition.Y) / button.AbsoluteSize.Y, 0)
        TweenService:Create(RippleEffect, TweenInfo.new(Library.Settings.RippleTweenTime, Library.Settings.TweenEasingStyle, Enum.EasingDirection.Out), {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)}):Play()

        wait(0.5)
        TweenService:Create(RippleEffect, TweenInfo.new(Library.Settings.MainTweenTime, Library.Settings.TweenEasingStyle, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()

        wait(1)
        RippleHolder:Destroy()
    end)
end
function PolarLibrary:CreateWindow(name)
    self.windows = self.windows + 1;
    local ScreenGui = Instance.new("ScreenGui")
    local Titleee = Instance.new("ImageLabel")
    local MainFrame = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local Titletext = Instance.new("TextLabel")
    ScreenGui.Parent = game.CoreGui
    
    Titleee.Name = "Titleee"
    Titleee.Parent = ScreenGui
    Titleee.BackgroundColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314)
    Titleee.BackgroundTransparency = 1
    Titleee.Position =UDim2.new(0, (15 + ((200 * self.windows) - 200)), 0, 15)
    Titleee.Size = UDim2.new(0, 173, 0, 38)
    Titleee.Image = "rbxassetid://3570695787"
    Titleee.ImageColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314)
    Titleee.ScaleType = Enum.ScaleType.Slice
    Titleee.SliceCenter = Rect.new(100, 100, 100, 200)
    Titleee.SliceScale = 0.06
    dragger.new(Titleee)
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Titleee
    MainFrame.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0, 0, 0.973683774, 0)
    MainFrame.Size = UDim2.new(0, 173, 0, 0)
    local function getSize()
		local ySize = 0;
		for i, object in next, MainFrame:GetChildren() do
			if (not object:IsA('UIListLayout')) and (not object:IsA('UIPadding')) then
				ySize = ySize + object.AbsoluteSize.Y
			end
		end
		return UDim2.new(1, 0, 0, ySize + 10)
	end

	function Resize(tween, change)
		local size = change or getSize()
		MainFrame.ClipsDescendants = true;
		
		if tween then
			MainFrame:TweenSize(size, "Out", "Sine", 0.5, true)
		else
			MainFrame.Size = size
		end
	end
    UIListLayout.Parent = MainFrame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    Titletext.Name = "Titletext"
    Titletext.Parent = Titleee
    Titletext.BackgroundColor3 = Color3.new(1, 1, 1)
    Titletext.BackgroundTransparency = 1
    Titletext.Size = UDim2.new(0, 173, 0, 37)
    Titletext.Font = Enum.Font.GothamBold
    Titletext.Text = name
    Titletext.TextColor3 = Color3.new(1, 1, 1)
    Titletext.TextSize = 18
    game:GetService('UserInputService').InputBegan:connect(function(key, gpe)
        if key.KeyCode == Enum.KeyCode.RightShift then
            if Titleee.Visible == true then Titleee.Visible = false elseif Titleee.Visible == false then Titleee.Visible = true end

        end
    end)
    local RealLibrary = {}
    function RealLibrary:Section(name)
  
        local Section = Instance.new("Frame")
        local Sectiontext = Instance.new("TextLabel")
        local spacer = Instance.new("Frame")
        Section.Name = "Section"
        Section.Parent = MainFrame
        Section.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
        Section.BorderSizePixel = 0
        Section.Size = UDim2.new(0, 173, 0, 39)

        Sectiontext.Name = "Sectiontext"
        Sectiontext.Parent = Section
        Sectiontext.BackgroundColor3 = Color3.new(1, 1, 1)
        Sectiontext.BackgroundTransparency = 1
        Sectiontext.Size = UDim2.new(0, 173, 0, 37)
        Sectiontext.Font = Enum.Font.GothamBold
        Sectiontext.Text = name
        Sectiontext.TextColor3 = Color3.new(1, 1, 1)
        Sectiontext.TextSize = 18

        spacer.Name = "spacer"
        spacer.Parent = MainFrame
        spacer.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
        spacer.BorderSizePixel = 0
        spacer.Position = UDim2.new(0.00289017335, 0, 0.256578952, 0)
        spacer.Size = UDim2.new(0, 172, 0, 5)
        Resize()
    end
    function RealLibrary:Button(name, action)
        local TextLabel = Instance.new("TextLabel")
        local TextButton = Instance.new("TextButton")
        local spacer = Instance.new("Frame")
        local TextButton_Roundify_3px = Instance.new("ImageLabel")
        TextButton.Parent = MainFrame
        TextButton.BackgroundColor3 = Color3.new(0.788235, 0.619608, 0.156863)
        TextButton.BackgroundTransparency = 1
        TextButton.BorderSizePixel = 0
        TextButton.Position = UDim2.new(0.0491329469, 0, 0.16858238, 0)
        TextButton.Size = UDim2.new(0, 156, 0, 31)
        TextButton.Font = Enum.Font.GothamBold
        TextButton.Text = "ButtonTest"
        TextButton.TextColor3 = Color3.new(0, 0, 0)
        TextButton.TextSize = 17

        TextButton_Roundify_3px.Name = "TextButton_Roundify_3px"
        TextButton_Roundify_3px.Parent = TextButton
        TextButton_Roundify_3px.Active = true
        TextButton_Roundify_3px.AnchorPoint = Vector2.new(0.5, 0.5)
        TextButton_Roundify_3px.BackgroundColor3 = Color3.new(1, 1, 1)
        TextButton_Roundify_3px.BackgroundTransparency = 1
        TextButton_Roundify_3px.Position = UDim2.new(0.5, 0, 0.5, 0)
        TextButton_Roundify_3px.Selectable = true
        TextButton_Roundify_3px.Size = UDim2.new(1, 0, 1, 0)
        TextButton_Roundify_3px.Image = "rbxassetid://3570695787"
        TextButton_Roundify_3px.ImageColor3 = Color3.new(0, 166, 255)
        TextButton_Roundify_3px.ScaleType = Enum.ScaleType.Slice
        TextButton_Roundify_3px.SliceCenter = Rect.new(100, 100, 100, 100)
        TextButton_Roundify_3px.SliceScale = 0.06
        TextLabel.Parent = TextButton_Roundify_3px
        TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(0, 157, 0, 31)
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.Text = name
        TextLabel.TextColor3 = Color3.new(0, 0, 0)
        TextLabel.TextSize = 17
        TextButton.MouseButton1Down:connect(function()
        action()
        RippleEffect(TextButton)
        end)
        spacer.Name = "spacer"
        spacer.Parent = MainFrame
        spacer.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
        spacer.BorderSizePixel = 0
        spacer.Position = UDim2.new(0.0028901733)
        spacer.Size = UDim2.new(0, 172, 0, 5)
        Resize()
        
    end
    function RealLibrary:Toggle(name, action)
        local ToggleHolder = Instance.new("Frame")
        local TextLabel_2 = Instance.new("TextLabel")
        local TextButton_2 = Instance.new("TextButton")
        local TextButton_Roundify_3px = Instance.new("ImageLabel")
        ToggleHolder.Name = "ToggleHolder"
        ToggleHolder.Parent = MainFrame
        ToggleHolder.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
        ToggleHolder.BorderSizePixel = 0
        ToggleHolder.Position = UDim2.new(0.00289017335, 0, 0.306513399, 0)
        ToggleHolder.Size = UDim2.new(0, 163, 0, 31)

        TextLabel_2.Parent = ToggleHolder
        TextLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Position = UDim2.new(-0.00195699371, 0, 0.0967741907, 0)
        TextLabel_2.Size = UDim2.new(0, 128, 255)
        TextLabel_2.Font = Enum.Font.GothamSemibold
        TextLabel_2.Text = " "..name
        TextLabel_2.TextColor3 = Color3.new(1, 1, 1)
        TextLabel_2.TextSize = 17
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
        TextButton_2.AutoButtonColor = false
        TextButton_2.Parent = ToggleHolder
        TextButton_2.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        --TextButton_2.BackgroundTransparency = 1
       -- TextButton_2.BorderColor3 = Color3.new(1, 1, 1)
     --   TextButton_2.BorderSizePixel = 2
     TextButton_2.BorderSizePixel = false
        TextButton_2.Position = UDim2.new(0.849711001, 0, 0.0967741907, 0)
        TextButton_2.Size = UDim2.new(0, 25, 0, 25)
        TextButton_2.Font = Enum.Font.SourceSans
        TextButton_2.Text = ""
        TextButton_2.TextColor3 = Color3.new(1, 1, 1)
        TextButton_2.TextSize = 14
        TextButton_Roundify_3px.Name = "TextButton_Roundify_3px"
        TextButton_Roundify_3px.Parent = TextButton_2
        TextButton_Roundify_3px.Active = true
        TextButton_Roundify_3px.AnchorPoint = Vector2.new(0.5, 0.5)
        TextButton_Roundify_3px.BackgroundColor3 = Color3.new(1, 1, 1)
        TextButton_Roundify_3px.BackgroundTransparency = 1
        TextButton_Roundify_3px.Position = UDim2.new(0.5, 0, 0.5, 0)
        TextButton_Roundify_3px.Selectable = true
        TextButton_Roundify_3px.Size = UDim2.new(1, 0, 1, 0)
        TextButton_Roundify_3px.Image = "rbxassetid://3570695787"
        TextButton_Roundify_3px.ImageColor3 = Color3.fromRGB(0, 179, 255)
        TextButton_Roundify_3px.ScaleType = Enum.ScaleType.Slice
        TextButton_Roundify_3px.SliceCenter = Rect.new(100, 100, 100, 100)
        TextButton_Roundify_3px.ImageTransparency = 1
        TextButton_Roundify_3px.SliceScale = 0.03
        local Enabled = false
        TextButton_2.MouseButton1Down:connect(function()
            Enabled = not Enabled
        
            if Enabled then
                TweenService:Create(TextButton_Roundify_3px, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
               -- TextButton_Roundify_3px.ImageColor3 = Color3.fromRGB(201, 158, 40)
            elseif not Enabled then
                TweenService:Create(TextButton_Roundify_3px, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()

            end
          
            action(Enabled)
        end)
        local spacer = Instance.new("Frame")
        spacer.Name = "spacer"
        spacer.Parent = MainFrame
        spacer.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
        spacer.BorderSizePixel = 0
        spacer.Position = UDim2.new(0.0028901733)
        spacer.Size = UDim2.new(0, 172, 0, 5)
        Resize()
    end
    function RealLibrary:Slider(name,minimumvalue, maximumvalue, startvalue, precisevalue, action)
        local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
        local SliderHolder = Instance.new("Frame")
local TextLabel_3 = Instance.new("TextLabel")
local Frame = Instance.new("ImageLabel")
local Frame_2 = Instance.new("ImageLabel")
local TextLabel_4 = Instance.new("TextLabel")
local Dragging = false
local PreciseSliderValue = precisevalue
        SliderHolder.Name = "SliderHolder"
SliderHolder.Parent = MainFrame
SliderHolder.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
SliderHolder.BorderSizePixel = 0
SliderHolder.Position = UDim2.new(0.00289017335, 0, 0.444444448, 0)
SliderHolder.Size = UDim2.new(0, 172, 0, 32)

TextLabel_3.Parent = SliderHolder
TextLabel_3.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_3.BackgroundTransparency = 1
TextLabel_3.Position = UDim2.new(0.0465116277, 0, 0, 0)
TextLabel_3.Size = UDim2.new(0, 83, 0, 18)
TextLabel_3.Font = Enum.Font.GothamSemibold
TextLabel_3.Text = name
TextLabel_3.TextColor3 = Color3.new(1, 1, 1)
TextLabel_3.TextSize = 14
TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

Frame.Name = "Frame2"
Frame.Parent = SliderHolder
Frame.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
Frame.BackgroundTransparency = 1
Frame.Position = UDim2.new(0.0465116277, 0, 0.5625, 0)
Frame.Size = UDim2.new(0, 157, 0, 6)
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.new(0.137255, 0.137255, 0.137255)
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.05
Frame_2.Name = "Frame"
Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.new(0, 128, 255)
Frame_2.BackgroundTransparency = 1
Frame_2.Image = "rbxassetid://3570695787"
Frame_2.ImageColor3 = Color3.new(0, 128, 255)
Frame_2.ScaleType = Enum.ScaleType.Slice
Frame_2.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_2.SliceScale = 0.05
TextLabel_4.Parent = SliderHolder
TextLabel_4.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_4.BackgroundTransparency = 1
TextLabel_4.Position = UDim2.new(0.604651153, 0, 0.09375, 0)
TextLabel_4.Size = UDim2.new(0, 61, 0, 12)
TextLabel_4.Font = Enum.Font.GothamSemibold
TextLabel_4.Text = tostring(startvalue or PreciseSliderValue and tonumber(string.format("%.2f", startvalue)))
TextLabel_4.TextColor3 = Color3.new(1, 1, 1)
TextLabel_4.TextSize = 14
Frame_2.Size = UDim2.new(((startvalue or minimumvalue) - minimumvalue) / (maximumvalue - minimumvalue), 0, 0, 5)
local function Sliding(input)
    
    local Pos = UDim2.new(math.clamp((input.Position.X - Frame.AbsolutePosition.X) / Frame.AbsoluteSize.X, 0, 1), 0, 1, 0)
    Frame_2.Size = Pos
    TweenService:Create(Frame_2, TweenInfo.new(0.10, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Pos}):Play()
    
    local NonSliderPreciseValue = math.floor(((Pos.X.Scale * maximumvalue) / maximumvalue) * (maximumvalue - minimumvalue) + minimumvalue)
    local SliderPreciseValue = ((Pos.X.Scale * maximumvalue) / maximumvalue) * (maximumvalue - minimumvalue) + minimumvalue

    local Value = (PreciseSliderValue and SliderPreciseValue or NonSliderPreciseValue)
    Value = tonumber(string.format("%.2f", Value))

    TextLabel_4.Text = tostring(Value)
    action(Value)
end;

Frame_2.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
    end
    local wow = 1

    if wow < 0 then Frame_2.Size =UDim2.new(0, 3,0, 6)  end
end)


Frame_2.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

Frame_2.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Sliding(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        Sliding(input)
    end
 

end)
local spacer = Instance.new("Frame")
spacer.Name = "spacer"
spacer.Parent = MainFrame
spacer.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
spacer.BorderSizePixel = 0
spacer.Position = UDim2.new(0.0028901733)
spacer.Size = UDim2.new(0, 172, 0, 5)
Resize()
    end
    function RealLibrary:TextBox(name, callback)
        local TextBox = Instance.new("TextBox")
        TextBox.Parent = MainFrame
TextBox.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.0549132936, 0, 0.586206913, 0)
TextBox.Size = UDim2.new(0, 154, 0, 29)
TextBox.Font = Enum.Font.GothamBold
TextBox.Text = name
TextBox.TextColor3 = Color3.new(0.454902, 0.454902, 0.454902)
TextBox.TextSize = 17
TextBox.FocusLost:connect(function(...)
    callback(TextBox, ...)
end)
local spacer = Instance.new("Frame")
spacer.Name = "spacer"
spacer.Parent = MainFrame
spacer.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
spacer.BorderSizePixel = 0
spacer.Position = UDim2.new(0.0028901733)
spacer.Size = UDim2.new(0, 172, 0, 5)
Resize()
    end
    return RealLibrary;
end
return PolarLibrary;
