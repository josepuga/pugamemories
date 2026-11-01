local AddonName, NS = ...
local PL = PugaLib


--
-- Adds PugaMemories options to a unit context menu.
--
local function AddMemoryOptions(
    RootDescription,
    Target
)
    if not Target or not Target.GUID then
        return
    end

    RootDescription:CreateDivider()

    RootDescription:CreateButton(
        NS.L.CREATE_MEMORY,
        function()
            NS:CreateMemory(Target)
        end
    )

    -- Only show when a memory exists.
    if PugaMemoriesDB and PugaMemoriesDB[Target.GUID] then
        RootDescription:CreateButton(
            NS.L.DELETE_MEMORY,
            function()
                NS:DeleteMemory(Target)
            end
        )
    end
end


--
-- Unit context menus.
--
local function ModifyUnitMenu(
    Owner,
    RootDescription,
    ContextData
)
    if not ContextData or not ContextData.unit then
        return
    end

    local Target = PL.Unit:New(ContextData.unit)
    AddMemoryOptions(RootDescription, Target)
end


--
-- Chat player context menu.
--
local function ModifyChatMenu(
    Owner,
    RootDescription,
    ContextData
)
    if not ContextData or not ContextData.lineID then
        return
    end

    local GUID = C_ChatInfo.GetChatLineSenderGUID(
        ContextData.lineID
    )

    if not GUID then
        return
    end

    local Class, _, Race, _, _, Name, Realm =
        GetPlayerInfoByGUID(GUID)

    local Target = {
        GUID = GUID,
        Name = ContextData.name or Name,
        Server = ContextData.server or Realm,
        Race = Race and { Name = Race } or nil,
        Class = Class and { Name = Class } or nil,
        Level = nil, -- Not available from the chat GUID.
    }

    AddMemoryOptions(RootDescription, Target)
end


--
-- Unit context menus.
--
local Menus = {
    "MENU_UNIT_PLAYER",
    "MENU_UNIT_SELF",  -- Working as intended
    "MENU_UNIT_TARGET",
    "MENU_UNIT_PARTY",
    "MENU_UNIT_RAID_PLAYER",
}

for _, MenuName in ipairs(Menus) do
    Menu.ModifyMenu(
        MenuName,
        ModifyUnitMenu
    )
end

-- Chat menu has no ContextData.unit.
Menu.ModifyMenu(
    "MENU_UNIT_FRIEND",
    ModifyChatMenu
)
