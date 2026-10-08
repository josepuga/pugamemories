local AddonName, NS = ...
local PL = PugaLib


--
-- Portrait configurations.
--
local PortraitConfig = {
    TargetFrame = {
        Size = 20,
        Point = "CENTER",
        RelativePoint = "CENTER",
        X = 40,
        Y = 0,
    },

    PartyFrame = {
        Size = 14,
        Point = "CENTER",
        RelativePoint = "CENTER",
        X = -20,
        Y = 0,
    },

    CompactRaidGroup = {
        Size = 10,
        Point = "CENTER",
        RelativePoint = "CENTER",
        X = 0,
        Y = 0,
    },
}


--
-- Creates a PugaMemory indicator for a unit frame.
--
local function NewPin(
    UnitFrame,
    Config
)
    local Pin =
        CreateFrame(
            "Button",
            nil,
            UnitFrame
        )


    -- Force above.
    Pin:SetFrameLevel(
        UnitFrame:GetFrameLevel() + 10
    )

    Pin:SetSize(
        Config.Size,
        Config.Size
    )

    Pin:SetPoint(
        Config.Point,
        UnitFrame,
        Config.RelativePoint,
        Config.X,
        Config.Y
    )


    Pin.Texture =
        Pin:CreateTexture(
            nil,
            "OVERLAY"
        )

    Pin.Texture:SetAllPoints()

    Pin:Hide()


    --
    -- Tooltip.
    --
    Pin.Tooltip =
        PL.UI:NewTooltip(
            Pin,
            {
                Anchor = "ANCHOR_RIGHT",
            }
        )


    return Pin
end


--
-- Updates a PugaMemory indicator.
--
local function UpdatePin(
    UnitFrame,
    Pin
)
    Pin:Hide()
    Pin.Record = nil

    Pin.Tooltip:Clear()


    if UnitFrame.unit == nil then
        return
    end


    local GUID =
        UnitGUID(
            UnitFrame.unit
        )

    if GUID == nil then
        return
    end


    GUID =
        NS.NormalizeGUID(
            GUID
        )


    local Record =
        PugaMemoriesDB[GUID]

    if Record == nil then
        return
    end


    Pin.Record =
        Record


    if Record.Good then
        Pin.Texture:SetTexture(
            NS.IMAGE_GOOD
        )
    else
        Pin.Texture:SetTexture(
            NS.IMAGE_BAD
        )
    end


    Pin.Tooltip:AddHeader(
        AddonName
    )


    local Lines =
        NS.Record.GetTooltipLines(
            Record
        )


    for _, Line in ipairs(Lines) do
        Pin.Tooltip:AddLine(
            Line.Text,
            Line.R,
            Line.G,
            Line.B
        )
    end


    Pin:Show()
end


--
-- Target portrait.
--
local TargetPin =
    NewPin(
        TargetFrame,
        PortraitConfig.TargetFrame
    )


--
-- Party portraits.
--
local PartyPins = {}

for Member = 1, 4 do
    local UnitFrame =
        PartyFrame[
            "MemberFrame" .. Member
        ]

    if UnitFrame ~= nil then
        PartyPins[UnitFrame] =
            NewPin(
                UnitFrame,
                PortraitConfig.PartyFrame
            )
    end
end


--
-- Raid portraits.
--
local RaidPins = {}


--
-- Creates pins for available raid portraits.
--
local function SetupRaidPins()
    for Group = 1, 8 do
        for Member = 1, 5 do
            local UnitFrame =
                _G[
                    "CompactRaidGroup" ..
                    Group ..
                    "Member" ..
                    Member
                ]

            if UnitFrame ~= nil
                and RaidPins[UnitFrame] == nil
            then
                RaidPins[UnitFrame] =
                    NewPin(
                        UnitFrame,
                        PortraitConfig.CompactRaidGroup
                    )
            end
        end
    end
end


--
-- Updates the target portrait.
--
local function UpdateTarget()
    UpdatePin(
        TargetFrame,
        TargetPin
    )
end


--
-- Updates party and raid portraits.
--
local function UpdateGroup()
    SetupRaidPins()


    for UnitFrame, Pin in pairs(PartyPins) do
        UpdatePin(
            UnitFrame,
            Pin
        )
    end


    for UnitFrame, Pin in pairs(RaidPins) do
        UpdatePin(
            UnitFrame,
            Pin
        )
    end
end


--
-- Events.
--
local EventFrame =
    CreateFrame("Frame")

EventFrame:RegisterEvent(
    "PLAYER_TARGET_CHANGED"
)

EventFrame:RegisterEvent(
    "GROUP_ROSTER_UPDATE"
)

EventFrame:RegisterEvent(
    "PLAYER_ENTERING_WORLD"
)

EventFrame:SetScript(
    "OnEvent",
    function(
        Self,
        Event
    )
        if Event == "PLAYER_TARGET_CHANGED" then
            UpdateTarget()

        elseif Event == "GROUP_ROSTER_UPDATE" then
            UpdateGroup()

        elseif Event == "PLAYER_ENTERING_WORLD" then
            UpdateGroup()
        end
    end
)


--
-- Initialize.
--
UpdateTarget()
UpdateGroup()