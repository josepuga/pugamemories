local AddonName, NS = ...
local PL = PugaLib


NS.Record = {}


--
-- Creates a new  memory record.
--
function NS.Record.New(
    Target,
    Good,
    Reason,
    Memo
)


    --
    -- Target name.
    --
    local TargetName = Target.Name

    --
    -- Player name.
    --
    local Player = PugaLib.Unit:New("player")
    local PlayerName = Player.Name

    return {
        Timestamp = time(),

        Good = Good,

        GUID = Target.GUID,
        TargetName = TargetName,
        TargetServer = Target.Server,
        TargetRace = Target.Race.Name,
        TargetClass = Target.Class.Name,
        TargetLevel = Target.Level,

        PlayerName = PlayerName,
        PlayerServer = Player.Server,
        PlayerRace = Player.Race.Name,
        PlayerClass = Player.Class.Name,
        PlayerLevel = Player.Level,

        Zone = Player.Location.Zone,
        SubZone = Player.Location.SubZone,

        Reason = Reason,
        Memo = Memo,
    }
end

--
-- Diplays the  memory text in the chat. 
-- WARNING: Hardcoded format!
--
function NS.Record.GetLinkText(Record)
    local Color, Type
    local TargetName = Record.TargetName
    local PlayerName = Record.PlayerName

    local Red = "ffff0000"
    local Green = "ff00ff00"

    if Record.Good then
        Color = Green
        Type = NS.L.GOOD
    else
        Color = Red
        Type = NS.L.BAD
    end

    Type = "|c" .. Color .. Type -- .. "|r"
    Reason = Record.Reason .. "|r"

    TargetName = "|c" .. Color .. TargetName .. "|r"

    if Record.TargetServer ~= nil then
        TargetName = TargetName .." <" .. Record.TargetServer ..">"
    end

    if Record.PlayerServer ~= nil then
        PlayerName = PlayerName .." <" .. Record.PlayerServer ..">"
    end

    return string.format(
        NS.L.LINK_FORMAT,

        Type,
        Reason,

        date("%d/%m/%y %H:%M", Record.Timestamp),

        TargetName,
        Record.TargetRace,
        Record.TargetClass,
        Record.TargetLevel,

        PlayerName,
        Record.PlayerRace,
        Record.PlayerClass,
        Record.PlayerLevel,

        Record.Zone,
        Record.SubZone,

        Record.Memo
    )
end

--
-- Returns the  memory lines for a tooltip.
-- WARNING: Hardcoded format!
--
function NS.Record.GetTooltipLines(Record)
    local Type
    local R, G, B
    local TargetName = Record.TargetName
    local PlayerName = Record.PlayerName

    if Record.Good then
        Type = NS.L.GOOD
        R, G, B = 0, 1, 0
    else
        Type = NS.L.BAD
        R, G, B = 1, 0, 0
    end

    if Record.TargetServer ~= nil then
        TargetName =
            TargetName ..
            " <" ..
            Record.TargetServer ..
            ">"
    end

    if Record.PlayerServer ~= nil then
        PlayerName =
            PlayerName ..
            " <" ..
            Record.PlayerServer ..
            ">"
    end

    return {
        {
            Text =
                Type ..
                " - " .. NS.L.REASON.. ": " ..
                Record.Reason,
            R = R,
            G = G,
            B = B,
        },

        {
            Text = date(
                "%d/%m/%y %H:%M",
                Record.Timestamp
            ),
        },

        {
            Text = TargetName,
            R = R,
            G = G,
            B = B,
        },

        {
            Text =
                Record.TargetRace ..
                " - " ..
                Record.TargetClass ..
                " (" .. NS.L.LEVEL .. " " ..
                Record.TargetLevel ..
                ")",
        },

        {
            Text = " " -- Line break
        },

        {
            Text =
                NS.L.ME .. ": " ..
                PlayerName ..
                " - " ..
                Record.PlayerRace ..
                " - " ..
                Record.PlayerClass ..
                " (" .. NS.L.LEVEL .. " " ..
                Record.PlayerLevel ..
                ")",
        },

        {
            Text = " " -- Line break
        },

        {
            Text =
                NS.L.LOCATION .. ": " ..
                Record.Zone ..
                " - " ..
                Record.SubZone,
        },

        {
            Text = NS.L.COMMENT .. ":",
        },

        {
            Text = Record.Memo,
            R = 1,
            G = 0.82,
            B = 0,
        },
    }
end
