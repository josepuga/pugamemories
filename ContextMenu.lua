local AddonName, NS = ...
local PL = PugaLib


--
-- Adds PugaMemories options to a unit context menu.
--
local function ModifyUnitMenu(
    Owner,
    RootDescription,
    ContextData
)
    local Target = PL.Unit:New(ContextData.unit)

    RootDescription:CreateDivider()

    RootDescription:CreateButton(
        NS.L.CREATE_MEMORY,
        function()
            NS:CreateMemory(Target)
        end
    )

    -- Only show when a memory exists.
    if PugaMemoriesDB[Target.GUID] then
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
