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
    RootDescription:CreateDivider()

    RootDescription:CreateButton(
        NS.L.CREATE_MEMORY,
        function()
            local Target =
                PL.Unit:New(
                    ContextData.unit
                )

            NS:CreateMemory(Target)
        end
    )
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
