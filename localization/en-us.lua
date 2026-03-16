return {
    descriptions = {
        Mod = {
            valkredux = {
                name = "Valk:Redux",
                text = {
                    "A full rewrite, rework and remake of {C:attention}VallKarri{}",
                    "The top ranking mod in the B tier of the mod tierlist",
                    "{s:1.2}Developed by {s:1.2,C:valk_grad1}Ophelia Felli{}",
                    "{s:0.8,C:inactive}A.K.A. Lily Felli{}",
                    "{s:1.2}With art by {s:1.2,C:valk_grad2}Various People{}",
                    "{s:0.8,C:inactive}Check out the credits menu! It's full of awesome people!{}",
                    "{s:1.5,C:valk_exquisite}Thank you for playing!{}",
                },
            },
        },
        Back = {
            b_valk_inertia = {
                name = "Inertia Deck",
                text = {
                    "{X:dark_edition,C:white}^#1#{} Blind Size",
                    "{X:valk_grad2,C:white}X#2#{} XP Gain",
                },
            },
            b_valk_encore = {
                name = "Encore Deck",
                text = {
                    "Retrigger all Jokers {C:attention}once{}",
                    "{C:attention}#1#{} Joker slots",
                },
            },
        },
        Blind = {
            bl_valk_high_road = {
                name = "The High Road",
                text = {
                    "Start with {C:blue}#1#{} Hands and {C:red}#2#{} Discards",
                    "Losing this blind {C:attention}does not end the run{}",
                    "Winning this blind creates an {C:valk_exquisite}Exquisite{} Joker",
                },
            },
        },
        Passive = {
            psv_valk_overscore = {
                name = "Upper Limit",
                text = {
                    "{C:red}Instantly lose{} if you score",
                    "more than {C:attention}#1#{}",
                },
            },
            psv_valk_swap = {
                name = "Card Swap",
                text = {
                    "Gain a {C:red}Discard{} when playing hand",
                    "Gain a {C:blue}Hand{} when discarding cards",
                },
            },
            psv_valk_antihighcard = {
                name = "Higher and Higher",
                text = {
                    "Playing a {C:attention}High Card{} will",
                    "multiply Blind Size by {C:attention}X#1#{}",
                },
            },
        },
        Edition = {
            e_valk_cosmic = {
                name = "Cosmic",
                text = {
                    "{X:slib_echips,C:white}^#1#{} Chips",
                },
            },
            e_valk_glow = {
                name = "Glow in the Dark",
                text = {
                    "Creates a random",
                    "{C:tarot}Tarot{} or {C:planet}Planet{} card",
                    "when triggered",
                },
            },
            e_valk_rgb = {
                name = "R.G.B.",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{X:mult,C:white}X#2#{} Mult",
                },
            },
            e_valk_censored = {
                name = "Censored",
                text = {
                    "All values are {C:attention}Hidden{}",
                    "Retrigger this card {C:attention}twice{}",
                },
            },
            e_valk_lordly = {
                name = "Lordly",
                text = {
                    "{X:slib_emult,C:white}^#1#{} Mult per",
                    "Joker owned",
                    "{C:inactive}(Currently {X:slib_emult,C:white}^#2#{C:inactive} Mult)",
                },
            },
        },
        Enhanced = {
            m_valk_mirrored = {
                name = "Mirrored",
                text = {
                    "Copies the {C:attention}Suit{}, {C:attention}Rank{},",
                    "{C:attention}Seal{} and {C:dark_edition}Edition{} of the",
                    "card to the right",
                },
            },
        },
        Joker = {
            j_valk_suck_it = {
                name = "Suck it",
                text = {
                    "{C:green}#1# in #2#{} chance to lose {C:money}$#3#{} when sold",
                    "{C:green}#4# in #5#{} chance to gain {C:money}$#6#{} when sold",
                    "Creates a {C:attention}copy{} of self when sold",
                    "{C:inactive}(Does not create copy when earning money)",
                },
            },
            j_valk_antithesis = {
                name = "Antithesis",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "unscoring card played",
                },
            },
            j_valk_kitty = {
                name = "Kitty",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "create a {C:attention}Kitty Tag{}",
                    "at end of round",
                },
            },
            j_valk_posh = {
                name = "Posh Joker",
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "enhanced card {C:attention}held-in-hand{}",
                },
            },
            j_valk_fancy = {
                name = "Fancy Joker",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "enhanced card {C:attention}held-in-hand{}",
                },
            },
            j_valk_streetlight = {
                name = "Streetlight",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult when",
                    "an {C:attention}Enhanced{} card is scored",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                },
            },
            j_valk_periapt_beer = {
                name = "Periapt Beer",
                text = {
                    "Creates {C:attention}The Fool{}",
                    "and a {C:tarot}Charm Tag{}",
                    "when sold",
                },
            },
            j_valk_stellar_yogurt = {
                name = "Stellar Yogurt",
                text = {
                    "Creates {C:attention}The Fool{}",
                    "and a {C:planet}Meteor Tag{}",
                    "when sold",
                },
            },
            j_valk_hexed_spirit = {
                name = "Hexed Spirit",
                text = {
                    "Creates {C:attention}two{}",
                    "{C:spectral}Ethereal Tags{}",
                    "when sold",
                },
            },
            j_valk_amber = {
                name = "Amber",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult when",
                    "a {V:1}#2#{} is scored",
                    "Increase gain by {X:mult,C:white}X#3#{}",
                    "for each {C:attention}Kitty Tag{} owned",
                    "Resets at end of round",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)",
                },
            },
            j_valk_blackjack = {
                name = "Blackjack",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult when",
                    "a {V:1}#2#{} is scored",
                    "Increase gain by {X:mult,C:white}X#3#{}",
                    "for each {C:attention}Kitty Tag{} owned",
                    "Resets at end of round",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)",
                },
            },
            j_valk_troupe = {
                name = "Troupe",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult when",
                    "a {V:1}#2#{} is scored",
                    "Increase gain by {X:mult,C:white}X#3#{}",
                    "for each {C:attention}Kitty Tag{} owned",
                    "Resets at end of round",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)",
                },
            },
            j_valk_valentine = {
                name = "Valentine",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult when",
                    "a {V:1}#2#{} is scored",
                    "Increase gain by {X:mult,C:white}X#3#{}",
                    "for each {C:attention}Kitty Tag{} owned",
                    "Resets at end of round",
                    "{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)",
                },
            },
            j_valk_uttered_chaos = {
                name = "Uttered Chaos",
                text = {
                    "{C:chips}+#1#{} Chip for every character",
                    "in all owned Jokers",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                },
            },
            j_valk_planedolia = {
                name = "Planedolia",
                text = {
                    "Cards in the shop have",
                    "a {C:green}#1# in #2#{} chance to be",
                    "replaced by a {C:planet}Planet{} card",
                },
            },
            j_valk_tarodolia = {
                name = "Tarodolia",
                text = {
                    "Cards in the shop have",
                    "a {C:green}#1# in #2#{} chance to be",
                    "replaced by a {C:tarot}Tarot{} card",
                },
            },
            j_valk_spectradolia = {
                name = "Spectradolia",
                text = {
                    "Cards in the shop have",
                    "a {C:green}#1# in #2#{} chance to be",
                    "replaced by a {C:spectral}Spectral{} card",
                },
            },
            j_valk_merchant_cat = {
                name = "Merchant Cat",
                text = {
                    "When buying a card",
                    "that costs more than {C:money}$#1#{},",
                    "create a {C:attention}Kitty Tag{}",
                },
            },
            j_valk_roundabout = {
                name = "Roundabout",
                text = {
                    "{C:attention}#1#{} to the next",
                    "change in {C:attention}ante{}",
                },
            },
            j_valk_kopa = {
                name = "Kopa",
                text = {
                    "If {C:attention}first hand{} of round has only {C:attention}one{}",
                    "card, apply {C:dark_edition}Polychrome{} to it",
                },
            },
            j_valk_brainfuck = {
                name = "++++[++++>---<]>-.++++.",
                text = {
                    "On {C:attention}first hand{} of round, add {C:attention}Brainfuck{} code",
                    "to this Joker based on played cards",
                    "{C:attention}Use{} this Joker to run stored code and",
                    "change this Jokers {C:attention}effect{} based on output",
                    "{C:inactive}(Currently stored: {C:attention}#1#{C:inactive})",
                    "{C:inactive}(Will add: {C:attention}#2#{C:inactive})",
                },
            },
            j_valk_takeyourage = {
                name = "Take your age...",
                text = {
                    "{C:mult}+#1#{} Mult before scoring",
                    "{C:mult}#2#{} Mult after scoring",
                },
            },
            j_valk_planetarium = {
                name = "Planetarium",
                text = {
                    "Upgrade the Chips and Mult",
                    "{C:attention}per-level{} of the first",
                    "{C:attention}played{} hand per round by {C:attention}+#1#{}",
                },
            },
            j_valk_familiar_face = {
                name = "Familiar Face",
                text = {
                    "Scored {C:attention}9s{} and {C:attention}Enhanced{}",
                    "cards give {X:mult,C:white}X#1#{} Mult",
                    "{C:attention}Enhanced 9s{} give {X:mult,C:white}X#2#{} Mult instead",
                },
            },
            j_valk_neffy = {
                name = "Neffy",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "Decreases by {X:mult,C:white}X#2#{} Mult",
                    "for every other {C:attention}Kitty Joker{} owned",
                },
            },
            j_valk_box_of_kittens = {
                name = "Box of Kittens",
                text = {
                    "Create a {C:attention}Kitty Tag{}",
                    "when shop is {C:attention}rerolled{}",
                },
            },
            j_valk_dupliCation = {
                name = "Dupli-cat-ion",
                text = {
                    {
                        "Each {C:attention}Kitty Tag{} has a {C:green}#1# in #2#{}",
                        "chance to duplicate at end of round",
                    },
                    {
                        "Increase denominator by {C:attention}#3#{} for every {C:attention}#4#{}",
                        "{C:attention}Kitty Tags{} owned",
                    },
                    {
                        "Each {C:attention}Kitty Tag{} has a {C:green}#5# in #6#{}",
                        "chance to be destroyed at end of round",
                    },
                },
            },
            j_valk_greedy_bastard = {
                name = "Greedy Bastard",
                text = {
                    "Destroy all {C:attention}Kitty Tags{} at",
                    "end of round, and gain {X:mult,C:white}X#1#{} Mult",
                    "for each {C:attention}Kitty Tag{} destroyed",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                },
            },
            j_valk_one_million_beavers = {
                name = "One Million Beavers",
                text = {
                    "Prevents death {C:attention}once{}",
                    "When death prevented, earn {C:money}$#1#{}",
                },
            },
            j_valk_borderline = {
                name = "Borderline Jokever",
                text = {
                    "Gains {C:chips}+#1#{} Chips when",
                    "a {C:clubs}Club{} is scored",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                },
            },
            j_valk_copycat = {
                name = "Copy Cat",
                text = {
                    "Create a {C:attention}Mirrored{} card and",
                    "when {C:attention}Blind{} is selected",
                },
            },
            j_valk_imwithstupid = {
                name = "I'm with {C:red}stupid",
                text = {
                    "Retrigger the Joker to the left {C:attention}#1#{} time#<s>1#",
                    "Increase by {C:attention}#2#{} retrigger",
                    "when {C:attention}#3#{} {C:inactive}[#4#]{} cards are scored",
                },
            },
            j_valk_heavy_hand = {
                name = "Heavy Hand",
                text = {
                    "{C:attention}+#1#{} Card Selection Limit",
                    "{C:attention}+#2#{} Hand Size",
                    "Playing cards give {C:chips}+#3#{} Chips",
                    "when scored",
                },
            },
            j_valk_ancient_fingers = {
                name = "Ancient Fingers",
                text = {
                    "{C:attention}+#1#{} Hand Size when any",
                    "{V:1}#2#{} are scored",
                    "{s:0.8}Resets and changes suit at end of round",
                },
            },
            j_valk_leopard_print = {
                name = "Leopard Print",
                text = {
                    "Retrigger all {C:attention}Kitty{} Jokers {C:attention}once{} ",
                    "for every {C:attention}Kitty{} Joker owned",
                },
            },
            j_valk_callie = {
                name = "Callie",
                text = {
                    "Gains {X:slib_emult,C:white}^#1#{} Mult when",
                    "a {C:attention}Wild{} card is scored",
                    "Increase gain by {X:slib_emult,C:white}^#2#{}",
                    "for each {C:attention}Kitty Tag{} owned",
                    "Resets at end of round",
                    "{C:inactive}(Currently {X:slib_emult,C:white}^#3#{C:inactive} Mult)",
                },
            },
            j_valk_rocky = {
                name = "Rocky",
                text = {
                    "Gains {X:slib_emult,C:white}^#1#{} Mult when",
                    "a {C:attention}Stone{} card is scored",
                    "Increase gain by {X:slib_emult,C:white}^#2#{}",
                    "for each {C:attention}Kitty Tag{} owned",
                    "Resets at end of round",
                    "{C:inactive}(Currently {X:slib_emult,C:white}^#3#{C:inactive} Mult)",
                },
            },
            j_valk_kathleen = {
                name = "Kathleen Rosetail",
                text = {
                    "After first hand drawn, create {C:attention}#1#{}",
                    "{C:dark_edition}Editioned{} {C:attention}CCD{} {C:planet}Planet{} cards",
                    "and add them to hand",
                },
            },
            j_valk_sinep = {
                name = "Sin E. P. Scarlett",
                text = {
                    "Played cards gain",
                    "{X:chips,C:white}X#1#{} Chips",
                    "when scored",
                },
            },
            j_valk_tasal = {
                name = "TASAL",
                text = {
                    "This Joker gains {C:gold}+#1#{} Ascension Power",
                    "if played {C:attention}poker hand{} is a {C:attention}#2#{}",
                    "{C:attention}Poker hand{} changes after hand played",
                    "{C:inactive}(Currently {C:gold}+#3#{C:inactive} Ascension Power)",
                },
            },
            j_valk_frutiger = {
                name = "Frutiger",
                text = {
                    "Adjacent {C:attention}Jokers{} are given {C:dark_edition}#1#{}",
                    "All other Jokers have their editions {C:red}removed{}",
                    "{C:dark_edition}#1#{} Jokers additionally give {X:chips,C:white}X#2#{} Chips",
                },
            },
            j_valk_synth = {
                name = "Synth",
                text = {
                    "Adjacent {C:attention}Jokers{} are given {C:dark_edition}#1#{}",
                    "All other Jokers have their editions {C:red}removed{}",
                    "{C:dark_edition}#1#{} Jokers additionally give {X:mult,C:white}X#2#{} Mult",
                },
            },
            j_valk_chrome = {
                name = "Chrome",
                text = {
                    "Adjacent {C:attention}Jokers{} are given {C:dark_edition}#1#{}",
                    "All other Jokers have their editions {C:red}removed{}",
                    "{C:dark_edition}#1#{} Jokers additionally give {X:slib_emult,C:white}^#2#{} Mult",
                },
            },
            j_valk_vapor = {
                name = "Vapor",
                text = {
                    "Adjacent {C:attention}Jokers{} are given {C:dark_edition}#1#{}",
                    "All other Jokers have their editions {C:red}removed{}",
                    "{C:dark_edition}#1#{} Jokers additionally give {C:chips}+#2#{} Chips and {C:mult}+#2#{} Mult",
                },
            },
            j_valk_memphis = {
                name = "Memphis",
                text = {
                    "Adjacent {C:attention}Jokers{} are given {C:dark_edition}#1#{}",
                    "All other Jokers have their editions {C:red}removed{}",
                    "{C:dark_edition}#1#{} Jokers additionally give {X:slib_echips,C:white}^#2#{} Chips",
                },
            },
            j_valk_scene = {
                name = "Scene",
                text = {
                    "Adjacent {C:attention}Jokers{} are given {C:dark_edition}#1#{}",
                    "All other Jokers have their editions {C:red}removed{}",
                    "{C:dark_edition}#1#{} Jokers additionally give {C:mult}+#2#{} Mult and {X:chips,C:white}X#3#{} Chips",
                },
            },
            j_valk_arkade = {
                name = "Arkade",
                text = {
                    "Adjacent {C:attention}Jokers{} are given {C:dark_edition}#1#{}",
                    "All other Jokers have their editions {C:red}removed{}",
                    "{C:dark_edition}#1#{} Jokers may now spawn {C:spectral}Spectral{} cards",
                },
            },
            j_valk_illena = {
                name = "Illena Vera",
                text = {
                    "At end of round, picks {C:attention}two{} random {C:attention}Jokers{}",
                    "Multiplies one of their values by {C:attention}X#1#{}",
                    "and multiplies the others values by {C:attention}X#2#{}",
                },
            },
            j_valk_ruby = {
                name = "Ruby Crimsonfang",
                text = {
                    "When {C:attention}Blind{} selected, if the ",
                    "Joker to the right is a {C:attention}Kitty{} Joker,",
                    "destroy it and gain {X:mult,C:white}X#1#{} Mult",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                },
            },
            j_valk_madstone_whiskey = {
                name = "Madstone Whiskey",
                text = {
                    "When {C:attention}The Fool{} is used, create a",
                    "{C:tarot}Charm Tag{} and a random {C:tarot}Tarot{} card",
                    "Gains {X:mult,C:white}X#1#{} Mult when a {C:tarot}Tarot{} card is sold",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                },
            },
            j_valk_astracola = {
                name = "Astracola",
                text = {
                    "When a {C:planet}Planet{} card is used, level up",
                    "a random {C:attention}poker hand{} by {C:attention}#1#{} levels",
                    "Increase by {C:attention}#2#{} level when a {C:planet}Planet{}",
                    "card is sold",
                },
            },
            j_valk_phylactequila = {
                name = "Phylactequila",
                text = {
                    "{C:spectral}Spectral{} cards may appear in the shop",
                    "Buying a {C:spectral}Spectral{} card from the shop",
                    "has a {C:green}#1# in #2#{} chance to destroy it",
                    "and give this Joker {X:slib_emult,C:white}^#3#{} Mult",
                    "{C:inactive}(Currently {X:slib_emult,C:white}^#4#{C:inactive} Mult)",
                },
            },
            j_valk_lily = {
                name = "Lily Felli",
                text = {
                    "{X:slib_echips,C:white}^#1#{} Chips for every",
                    "{C:attention}unique{} Joker owned this run",
                    "{C:inactive}(Currently {X:slib_echips,C:white}^#2#{C:inactive} Chips)",
                },
            },
        },
        Other = {
            undiscovered_Planetoid = {
                name = "Mysterious Planetoid",
                text = {
                    "Purchase or use",
                    "this {C:planetoid}Planetoid{}",
                    "in a run to",
                    "see what it does!",
                },
            },
        },
        Planet = {},
        Spectral = {
            c_valk_freeway = {
                name = "Freeway",
                text = {
                    "Upcoming {C:attention}Boss Blind{} is",
                    "replaced by {C:valk_exquisite}The High Road{}",
                },
            },
            c_valk_soteria = {
                name = "Soteria",
                text = {
                    "{C:attention}+#1#{} Card Selection Limit",
                    "{C:attention}+#2#%{} Blind Size",
                },
            },
            c_valk_thilykotita = {
                name = "Thilykotita",
                text = {
                    "Converts up to {C:attention}#1# non-Queen{}",
                    "cards in hand into {C:attention}Queens{}",
                },
            },
            c_valk_andrisimos = {
                name = "Andrisimos",
                text = {
                    "Converts up to {C:attention}#1# non-Jack{}",
                    "cards in hand into {C:attention}Jacks{}",
                },
            },
            c_valk_luck = {
                name = "Luck",
                text = {
                    "Multiply the values of",
                    "up to {C:attention}#1#{} Jokers",
                    "by either {C:attention}X#1#{} or {C:attention}X#2#{}",
                },
            },
            c_valk_missingno = {
                name = "MissingNo",
                text = {
                    "Apply {C:dark_edition}Cosmic{},",
                    "{C:dark_edition}Glow-in-the-dark{}, or",
                    "{C:dark_edition}R.G.B.{} to a selected card",
                    "in hand",
                },
            },
            c_valk_faker = {
                name = "Faker",
                text = {
                    "Select up to {C:attention}#1#{} Joker#<s>1#,",
                    "and create a {C:dark_edition}Negative{} and {C:blue}Perishable{}",
                    "copy of selected Joker#<s>1#",
                },
            },
        },
        Stake = {},
        Tag = {
            tag_valk_kitty = {
                name = "Kitty Tag",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:red}Never{} gets consumed",
                },
            },
            tag_valk_negative_eternal = {
                name = "Negative Eternal Tag",
                text = {
                    "Shop has a free",
                    "{C:dark_edition}Negative{} {C:purple}Eternal{} Joker",
                },
            },
        },
        Tarot = {
            c_valk_judgemeownt = {
                name = "Judgemeownt",
                text = {
                    "Creates a random",
                    "{C:attention}Kitty{} Joker",
                    "{C:inactive}(Must have room)",
                },
            },
            c_valk_iron_maiden = {
                name = "Iron Maiden",
                text = {
                    "Select {C:attention}#1#{} card#<s>1#, convert the {C:attention}left{} card",
                    "into the {C:attention}right{} card, then enhance",
                    "the {C:attention}left{} card to {C:attention}Steel{}, and",
                    "{C:attention}unenhance{} the {C:attention}right{} card",
                },
            },
            c_valk_the_pope = {
                name = "The Pope",
                text = {
                    "Remove the {C:attention}Enhancement{} of",
                    "all cards {C:attention}held-in-hand{}, then roll",
                    "a {C:green}#1# in #2#{} chance to give each card",
                    "a random {C:attention}Enhancement{}",
                },
            },
            c_valk_gods_fingers = {
                name = "God's Fingers",
                text = {
                    "Destroy {C:attention}#1#{} random cards",
                    "{C:attention}held-in-hand{}, and create a",
                    "random {C:dark_edition}Negative{} {C:common}Common{} Joker",
                },
            },
            c_valk_the_killer = {
                name = "The Killer",
                text = {
                    "Create a random",
                    "{C:dark_edition}Negative{} {C:attention}consumable{}",
                    "of the same {C:attention}type{} as the",
                    "last used {C:attention}consumable{}",
                },
            },
            c_valk_gameshow = {
                name = "Gameshow",
                text = {
                    "Roll a {C:green}#1# in #2#{} chance",
                    "to earn {C:money}$#3#{} for each owned Joker",
                },
            },
            c_valk_the_knight = {
                name = "The Knight",
                text = {
                    "Select up to {C:attention}#1#{} cards",
                    "Destroy all cards {C:attention}held-in-hand{}",
                    "that are not selected",
                },
            },
        },
        Voucher = {
            v_valk_reptile = {
                name = "Reptile",
                text = {
                    "Always draw at least",
                    "{C:attention}#1#{} cards",
                },
            },
            v_valk_reptoid = {
                name = "Reptoid",
                text = {
                    "Draw {C:attention}#1#{} additional cards if you",
                    "have not played a hand this round",
                },
            },
            v_valk_xp_alpha = {
                name = "XP Booster Alpha",
                text = {
                    "{X:valk_grad2,C:white}X#1#{} XP Gain",
                },
            },
            v_valk_xp_beta = {
                name = "XP Booster Beta",
                text = {
                    "Earn {C:money}$#1#{} on level-up",
                    "{C:valk_grad1}+#2#{} XP Leniency",
                },
            },
            v_valk_xp_gamma = {
                name = "XP Booster Gamma",
                text = {
                    "Level up your {C:attention}most-played{} ",
                    "{C:attention}poker hand{} on level-up",
                },
            },
            v_valk_xp_delta = {
                name = "XP Booster Delta",
                text = {
                    "{X:valk_grad2,C:white}X#1#{} XP Gain",
                },
            },
            v_valk_xp_epsilon = {
                name = "XP Booster Epsilon",
                text = {
                    "Create a {C:spectral}Spectral{}",
                    "card on level-up",
                },
            },
        },
        Aesthetic = {
            c_valk_aesthetic_base = {
                text = {
                    "Enhance up to {C:attention}#1#{} selected",
                    "Joker#<s>1# or Playing Card#<s>1# to",
                    "{C:dark_edition}#2#{}",
                },
            },
            c_valk_frutiger_aero = {
                name = "Frutiger Aero",
            },
            c_valk_synthwave = {
                name = "Synthwave",
            },
            c_valk_chromecore = {
                name = "Chromecore",
            },
            c_valk_vaporwave = {
                name = "Vaporwave",
            },
            c_valk_scene = {
                name = "Scene!XD",
            },
            c_valk_memphis = {
                name = "Memphis",
            },
            c_valk_arcadecore = {
                name = "Arcadecore",
            },
            c_valk_savior = {
                name = "Savior",
            },
            c_valk_cl___ified = {
                name = "Classified",
            },
        },
        Planetoid = {
            c_valk_planetoid_base = {
                text = {
                    {
                        "({V:1}lvl.#1#{}) Level up",
                        "{C:attention}#2#",
                        "{C:chips}+#3#{} chips and",
                        "{C:mult}+#4#{} Mult",
                    },
                    {
                        "Increase by {C:chips}+#5#{} Chips",
                        "and {C:mult}+#6#{} Mult for each time",
                        "{C:attention}#7#{} is used this run",
                    },
                },
            },
            c_valk_kerberos = {
                name = "Kerberos",
            },
            c_valk_icarus = {
                name = "Icarus",
            },
            c_valk_miranda = {
                name = "Miranda",
            },
            c_valk_daedalus = {
                name = "Daedalus",
            },
            c_valk_pan = {
                name = "Pan",
            },
            c_valk_amalthea = {
                name = "Amalthea",
            },
            c_valk_cardea = {
                name = "Cardea",
            },
            c_valk_eureka = {
                name = "Eureka",
            },
            c_valk_despina = {
                name = "Despina",
            },
            c_valk_tyche = {
                name = "Tyche",
            },
            c_valk_artemis = {
                name = "Artemis",
            },
            c_valk_ixion = {
                name = "Ixion",
            },
        },
    },
    misc = {
        achievement_descriptions = {},
        achievement_names = {},
        blind_states = {},
        challenge_names = {},
        collabs = {},
        dictionary = {
            -- when you do localize(x) it looks here for an entry with key x
            k_valk_artby = "Art by: ",
            k_valk_page = "Page ",
            k_valk_see_creations = "Accredited cards",
            k_valk_social_media = "Social Media",
            k_valk_credits = "Credits",
            k_valk_shaderby = "Shader by: ",
            k_plus_kitty_tag = "+1 Kitty Tag",
            k_replaced_ex = "Replaced!",
            k_per_lv = "Per Lv.",
            ph_lv_display = "Lv. ",
            ph_beavers = "The beavers ravage the blind.",
            ph_valk_xp = "XP Gain",
            ph_valk_xp_score = "(Score Precision)",
            k_created_ex = "Created!",
            k_valk_renowned = "Renowned",
            k_valk_exquisite = "Exquisite",
            ph_upcoming_gate = "Upcoming Ante Gate:",
            ph_gate_intensity = "Gate Intensity:",
            k_level = "Level ",
            ph_gate_consequences = {
                "If below Gate Level",
                "at start of the ante,",
                "Blinds will get stronger.",
            },
            ph_active_gates = "Active Gates",
            ph_no_gates = "No gates active!",
            ph_gate_ExtraScaling = "Extra Blind Scaling",
            ph_gate_BigBoss = "Big Blind is now a Boss Blind",
            ph_gate_ExpensiveCards = "Cards cost more money",
            ph_gate_SmallBoss = "Small Blind is now a Boss Blind",
            ph_gate_HalfDiscards = "Lose half of your Discards",
            ph_gate_UnsellableJokers = "Jokers cannot be sold",
            ph_gate_Skimming = "Lose money at end of round per Joker owned",

            valk_badge_kitty = "Kitty",
            valk_badge_missing_art = "MISSING ART CREDITS",
            valk_badge_eats_kitties = "(Eats Kitties)",
            valk_badge_evil = "(evil)",

            b_planetoid_cards = "Planetoid Cards",
            k_planetoid = "Planetoid",
            b_aesthetic_cards = "Aesthetic Cards",
            k_aesthetic = "Aesthetic",

            k_downgrade_ex = "Downgraded!",
            k_failed = "FAILED",
        },
        high_scores = {},
        labels = {
            valk_cosmic = "Cosmic",
            valk_rgb = "R.G.B",
            valk_glow = "Glow in the Dark",
            valk_censored = "Censored",
            valk_lordly = "Lordly",
            k_valk_renowned = "Renowned",
            k_valk_exquisite = "Exquisite",
            Planetoid = "Planetoid",
            Aesthetic = "Aesthetic",
        },
        poker_hand_descriptions = {},
        poker_hands = {},
        quips = {},
        ranks = {},
        suits_plural = {},
        suits_singular = {},
        tutorial = {},
        v_dictionary = {
            k_plus_sel_limit = "+#1# Selection Limit",
            k_valk_bf_chips = "{C:chips}+#1#{} Chips",
            k_valk_bf_mult = "{C:mult}+#1#{} Mult",
            k_valk_bf_money = "Earn {C:money}$#1#{} when hand played",
            k_valk_bf_blindsize = "{X:attention,C:white}X#1#{} Permanent Blind Size",
            k_valk_bf_forcetrigger = "Force-trigger {C:attention}#1#{} random Jokers",
            k_valk_bf_ante = "{C:attention}+#1#{} Ante",
            k_valk_bf_consumables = "Create {C:attention}#1#{} {C:dark_edition}Negative{} {C:attention}Consumables{}",
            k_valk_bf_negative_blindsize = "{C:attention}-#1#{} Blind Size when hand played",
            a_dollars = "+$#1#",
        },
        v_text = {},
    },
}
