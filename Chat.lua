local AddonName, NS = ...
local PL = PugaLib


local GoodTextIcon = "|T" .. NS.IMAGE_GOOD .. ":0|t"
local BadTextIcon = "|T" .. NS.IMAGE_BAD .. ":0|t"

local PugaMemoryLinkHandler =
    PL.UI:NewLinkHandler(
        "pugamemory",
        function(GUID)
            
            local Record =
                PugaMemoriesDB[GUID]

            if Record == nil then
                print("Es nil")
                return
            end

            print(
                NS.Record.GetLinkText(
                    Record
                )
            )
        end
    )


--
-- Add PugaMemory icon to chat messages.
--
local function PugaMemoriesChatFilter(
    self,
    Event,
    Message,
    Author,
    ...
)
    local Args = { ... }

    local GUID =
        NS.NormalizeGUID(Args[10])

    if GUID == nil then
        return false
    end


    local Record =
        PugaMemoriesDB[GUID]

    if Record == nil then
        return false
    end


    local Icon

    if Record.Good then
        Icon = GoodTextIcon
    else
        Icon = BadTextIcon
    end


    local PugaMemoryLink =
        PL.UI:NewLink(
            PugaMemoryLinkHandler,
            Icon,
            GUID
        )


    Message =
        PugaMemoryLink ..
        " " ..
        Message


    return false, Message, Author, ...
end


local ChatEvents = {
    "CHAT_MSG_SAY",
    "CHAT_MSG_YELL",
    "CHAT_MSG_WHISPER",
    "CHAT_MSG_PARTY",
    "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_RAID",
    "CHAT_MSG_RAID_LEADER",
    "CHAT_MSG_INSTANCE_CHAT",
    "CHAT_MSG_INSTANCE_CHAT_LEADER",
    "CHAT_MSG_GUILD",
}


for _, Event in ipairs(ChatEvents) do
    ChatFrame_AddMessageEventFilter(
        Event,
        PugaMemoriesChatFilter
    )
end
