local AddonName, NS = ...
local PL = PugaLib

--
-- i18n
--
local Locale = GetLocale()

local Strings =
    NS.Locale[Locale]
    or NS.Locale.enUS

NS.L = Strings



--
-- Saved variables initialization.
--
local EventFrame = CreateFrame("Frame")

EventFrame:RegisterEvent("ADDON_LOADED")

EventFrame:SetScript("OnEvent", function(
    self,
    Event,
    LoadedAddon
)
    if LoadedAddon ~= AddonName then
        return
    end

    PugaMemoriesDB = PugaMemoriesDB or {}

    self:UnregisterEvent("ADDON_LOADED")
end)

--
-- Create a new memory.
--
function NS:CreateMemory(Target)
    --
    -- If a memory already exists, ask before overwriting it.
    --
    if PugaMemoriesDB[Target.GUID] then
        PL.UI:NewDialogYesNo({
            Title = AddonName,
            Message = NS.L.ALREADY_MEMORY,

            TextYes = NS.L.YES,
            TextNo = NS.L.NO,

            OnYes = function()
                NS:OpenMemoryWindow(Target)
            end,
        })

        return
    end

    --
    -- No previous memory.
    --
    NS:OpenMemoryWindow(Target)
end

-- TODO: Reuse the window instead of creating a new one
-- every time OpenMemoryWindow() is called.
function NS:OpenMemoryWindow(Target)
    local Window = PL.UI:NewWindow({
        Title = NS.ADDON_NAME,
        Width = 270,
        Height = 275,
        Transparent = true, --TODO: false not implemented
        Closable = true,
        Movable = true,
    })

    --
    -- App Icon
    -- 
    PL.UI:NewIcon(Window, {
        TextureID = NS.TEXTUREID_APP_ICON,

        X = 10,
        Y = 10,

        Width = 32,
        Height = 32,
    })

    --
    -- For: Target 
    --
    local TargetName = Target.Name
    PL.UI:NewLabel(Window, {
        Text = string.format(NS.L.MEMORY_OF, TargetName ),
        X = 30,
        Y = 45,

        FontSize = 10,
    })

    local RowComboBad = 65
    local RowComboGood = RowComboBad + 30
    local Col = 40

    --
    -- ButtonGroup Bad/Good
    --
    local ButtonGood = PL.UI:NewRadioButton(Window, {
        Text = "",
        Checked = true,

        X = Col,
        Y = RowComboGood +5,
    })

    local ButtonBad = PL.UI:NewRadioButton(Window, {
        Text = "",
        Checked = true,

        X = Col,
        Y = RowComboBad +5,
    })

    -- Group
    local TypeGroup = PL.UI:NewRadioGroup({
        ButtonBad,
        ButtonGood,
    })

    --
    -- Bad
    --
    

    TypeGroup:SetSelected(1)

    PL.UI:NewImage(Window, {
        Texture = NS.IMAGE_BAD,
        
        X = Col + 20,
        Y = RowComboBad +5,
        
        Width = 16,
        Height = 16,
    })

    local ReasonBad = PL.UI:NewComboBox(Window, {
        Items = NS.L.REASONS_BAD,

        Selected = 1,

        X = Col + 45,
        Y = RowComboBad,
        
        Width = 110,
    })

    --
    -- Good
    --
    PL.UI:NewImage(Window, {
        Texture = NS.IMAGE_GOOD,
        
        X = Col + 20,
        Y = RowComboGood + 5,
        
        Width = 16,
        Height = 16,
    })

    local ReasonGood = PL.UI:NewComboBox(Window, {
        Items = NS.L.REASONS_GOOD,

        Selected = 1,

        X = Col + 45,
        Y = RowComboGood,
        
        Width = 110,
    })


    ---
    --- Label for Reason Memo
    --- 
    local RowReason = RowComboGood + 35

    PL.UI:NewLabel(Window, {
        Text = NS.L.REASON_OPTIONAL,
        X = 25,
        Y = RowReason + 5,
    })

    ---
    --- Reason of memory
    --- 
    local memory = PL.UI:NewMemo(Window, {
        X = nil, -- Centered
        Y = RowReason + 20,

        Width = 220,
        Height = 80,

        MaxLength = 255,
    })

    ---
    --- Save
    --- 
    local SaveButton = PL.UI:NewButton(Window, {
        Text = NS.L.SAVE,

        X = nil,
        Y = Window:GetHeight() - 40,

        Width = 100,
        Height = 24,
    })


SaveButton:SetScript("OnClick", function()
    --
    -- Get memory type.
    --
    local Good =
        TypeGroup:GetSelected() == 2 -- 1=Bad, 2=Good


    --
    -- Get reason from the corresponding ComboBox.
    --
    local Reason

    if Good then
        local Index =
            ReasonGood:GetSelected()

        Reason =
            NS.L.REASONS_GOOD[Index]
    else
        local Index =
            ReasonBad:GetSelected()

        Reason =
            NS.L.REASONS_BAD[Index]
    end


    --
    -- Create record.
    --
    local Record = NS.Record.New(
        Target,
        Good,
        Reason,
        memory:GetText()
    )


    --
    -- Save / overwrite record.
    --
    PugaMemoriesDB[Target.GUID] =
        Record

    --
    -- Close window.
    --
    Window:Hide()
end)

end

