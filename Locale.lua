local AddonName, NS = ...

NS.Locale = {
    ---
    --- English
    --- 
    enUS = {
        REASON_OPTIONAL = "Reason (optional)",
        REASON = "Reason",
        LOCATION = "Location",
        COMMENT = "Comment",
        SAVE = "Save",
        ME = "Me",
        LEVEL = "level",
        MEMORY_OF = "Memory of: %s",
        CREATE_MEMORY = "Create Memory...",
        ALREADY_MEMORY = "Player already has a memory.\nOverwrite?.",

        REASONS_BAD = {
            "",
            "Ninja",
            "AFK",
            "Bad Party",
            "Bad Heal",
            "Bad Tank",
            "Bad DPS",
        },

        REASONS_GOOD = {
            "",
            "Good Party",
            "Good Heal",
            "Good Tank",
            "Good DPS",
        },
        -- Relative to Memory
        GOOD = "Good",
        BAD = "Bad",

        YES = "Yes",
        NO = "No",

        LINK_FORMAT = [[
PugaMemory %s - Reason: %s
%s
%s - %s - %s (level %d)
Me: %s - %s - %s (level %d)
Location : %s - %s
Comment:
%s
]],
    },

    ---
    --- Español
    --- 
    esES = {
        REASON_OPTIONAL = "Motivo (opcional)",
        REASON = "Motivo",
        LOCATION = "Lugar",
        COMMENT = "Comentario",
        SAVE = "Guardar",
        ME = "Yo",
        LEVEL = "nivel",
        MEMORY_OF = "Recuerdo de: %s",
        CREATE_MEMORY = "Crear Recuerdo...",
        ALREADY_MEMORY = "Jugador ya tiene un recuerdo.\n¿Sobreescribir?.",

        REASONS_BAD = {
            "",
            "Ninja",
            "AFK",
            "Mal Heal",
            "Mal Tank",
            "Mal DPS",
        },

        REASONS_GOOD = {
            "",
            "Buen Heal",
            "Buen Tank",
            "Buen DPS",
            "Buen Grupo",
        },
        GOOD = "Buena",
        BAD = "Mala",

        YES = "Sí",
        NO = "No",

        LINK_FORMAT = [[
PugaRecuerdo %s - Motivo: %s
%s
%s - %s - %s (nivel %d)
Yo: %s - %s - %s (nivel %d)
Lugar : %s - %s
Comentario:
%s
]],
    },

    ---
    --- Português
    ---
    ptBR = {
        REASON_OPTIONAL = "Motivo (opcional)",
        REASON = "Motivo",
        LOCATION = "Localização",
        COMMENT = "Comentário",
        SAVE = "Guardar",
        ME = "Eu",
        LEVEL = "nível",
        MEMORY_OF = "Recordação de: %s",
        CREATE_MEMORY = "Criar recordação...",
        ALREADY_MEMORY = "Este jogador já tem uma recordação.\nSubstituir?",

        REASONS_BAD = {
            "",
            "Ninja",
            "AFK",
            "Mau grupo",
            "Mau curandeiro",
            "Mau tanque",
            "Mau DPS",
        },

        REASONS_GOOD = {
            "",
            "Bom grupo",
            "Bom curandeiro",
            "Bom tanque",
            "Bom DPS",
        },
        GOOD = "Boa",
        BAD = "Má",

        YES = "Sim",
        NO = "Não",

        LINK_FORMAT = [[
PugaMemória %s - Motivo: %s
%s
%s - %s - %s (nível %d)
Eu: %s - %s - %s (nível %d)
Localização: %s - %s
Comentário:
%s
]],
    },

    ---
    --- Français
    ---
    frFR = {
        REASON_OPTIONAL = "Motif (facultatif)",
        REASON = "Motif",
        LOCATION = "Lieu",
        COMMENT = "Commentaire",
        SAVE = "Enregistrer",
        ME = "Moi",
        LEVEL = "niveau",
        MEMORY_OF = "Souvenir de : %s",
        CREATE_MEMORY = "Créer un souvenir...",
        ALREADY_MEMORY = "Un souvenir existe déjà pour ce joueur.\nLe remplacer ?",

        REASONS_BAD = {
            "",
            "Ninja",
            "AFK",
            "Mauvais groupe",
            "Mauvais soigneur",
            "Mauvais tank",
            "Mauvais DPS",
        },

        REASONS_GOOD = {
            "",
            "Bon groupe",
            "Bon soigneur",
            "Bon tank",
            "Bon DPS",
        },
        GOOD = "Bon",
        BAD = "Mauvais",

        YES = "Oui",
        NO = "Non",

        LINK_FORMAT = [[
PugaSouvenir %s - Motif : %s
%s
%s - %s - %s (niveau %d)
Moi : %s - %s - %s (niveau %d)
Lieu : %s - %s
Commentaire :
%s
]],
    },

    ---
    --- Deutsch
    ---
    deDE = {
        REASON_OPTIONAL = "Grund (optional)",
        REASON = "Grund",
        LOCATION = "Ort",
        COMMENT = "Kommentar",
        SAVE = "Speichern",
        ME = "Ich",
        LEVEL = "Stufe",
        MEMORY_OF = "Erinnerung an: %s",
        CREATE_MEMORY = "Erinnerung erstellen...",
        ALREADY_MEMORY = "Für diesen Spieler gibt es bereits eine Erinnerung.\nÜberschreiben?",

        REASONS_BAD = {
            "",
            "Ninja",
            "AFK",
            "Schlechte Gruppe",
            "Schlechter Heiler",
            "Schlechter Tank",
            "Schlechter DPS",
        },

        REASONS_GOOD = {
            "",
            "Gute Gruppe",
            "Guter Heiler",
            "Guter Tank",
            "Guter DPS",
        },
        GOOD = "Gut",
        BAD = "Schlecht",

        YES = "Ja",
        NO = "Nein",

        LINK_FORMAT = [[
PugaErinnerung %s - Grund: %s
%s
%s - %s - %s (Stufe %d)
Ich: %s - %s - %s (Stufe %d)
Ort: %s - %s
Kommentar:
%s
]],
    },
}
NS.Locale.esMX = NS.Locale.esES