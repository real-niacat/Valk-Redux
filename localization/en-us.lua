return {
    descriptions = {
        Back = {},
        Blind = {},
        Edition = {},
        Enhanced = {},
        Joker = {
            j_valk_suck_it = {
                name = "Suck it",
                text = {
                    "Creates a copy of self when sold",
                    "{C:green}#1# in #2#{} chance to lose {C:money}$#3#{} when sold",
                    "{C:green}#4# in #5#{} chance to gain {C:money}$#6#{} when sold",
                    "Does not recreate self when gaining money"
                }
            },
            j_valk_antithesis = {
                name = "Antithesis",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "unscoring card played",
                }
            },
            j_valk_kitty = {
                name = "Kitty",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "create a {C:attention}Kitty Tag{}",
                    "at end of round"
                }
            },
            j_valk_posh = {
                name = "Posh Joker",
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "enhanced card {C:attention}held-in-hand{}"
                }
            },
            j_valk_fancy = {
                name = "Fancy Joker",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "enhanced card {C:attention}held-in-hand{}"
                }
            },
            j_valk_streetlight = {
                name = "Streetlight",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult when",
                    "an {C:attention}Enhanced{} card is scored",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                }
            },
            j_valk_periapt_beer = {
                name = "Periapt Beer",
                text = {
                    "Creates {C:attention}The Fool{}",
                    "and a {C:tarot}Charm Tag{}",
                    "when sold",
                }
            },
            j_valk_stellar_yogurt = {
                name = "Stellar Yogurt",
                text = {
                    "Creates {C:attention}The Fool{}",
                    "and a {C:planet}Meteor Tag{}",
                    "when sold",
                }
            },
            j_valk_hexed_spirit = {
                name = "Hexed Spirit",
                text = {
                    "Creates {C:attention}two{}",
                    "{C:spectral}Ethereal Tags{}",
                    "when sold",
                }
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
                }
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
                }
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
                }
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
                }
            },
            j_valk_uttered_chaos = {
                name = "Uttered Chaos",
                text = {
                    "{C:chips}+#1#{} Chip for every character",
                    "in all owned Jokers",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                }
            },
            j_valk_planedolia = {
                name = "Planedolia",
                text = {
                    "Cards in the shop have",
                    "a {C:green}#1# in #2#{} chance to be",
                    "replaced by a {C:planet}Planet{} card"
                }
            },
            j_valk_tarodolia = {
                name = "Tarodolia",
                text = {
                    "Cards in the shop have",
                    "a {C:green}#1# in #2#{} chance to be",
                    "replaced by a {C:tarot}Tarot{} card"
                }
            },
            j_valk_spectradolia = {
                name = "Spectradolia",
                text = {
                    "Cards in the shop have",
                    "a {C:green}#1# in #2#{} chance to be",
                    "replaced by a {C:spectral}Spectral{} card"
                }
            },
            j_valk_merchant_cat = {
                name = "Merchant Cat",
                text = {
                    "When buying a card",
                    "that costs more than {C:money}$#1#{},",
                    "create a {C:attention}Kitty Tag{}",
                }
            },
            j_valk_roundabout = {
                name = "Roundabout",
                text = {
                    "{C:attention}#1#{} to the next",
                    "change in {C:attention}ante{}"
                }
            },
            j_valk_takeyourage = {
                name = "Take your age...",
                text = {
                    "{C:mult}+#1#{} Mult before scoring",
                    "{C:mult}#2#{} Mult after scoring"
                }
            },
        },
        Other = {},
        Planet = {},
        Spectral = {},
        Stake = {},
        Tag = {
            tag_valk_kitty = {
                name = "Kitty Tag",
                text = {
                    "{C:chips}+#1#{} Chips for every",
                    "{C:attention}Kitty Tag{} owned",
                    "{C:red}Never{} gets consumed"
                }
            }
        },
        Tarot = {},
        Voucher = {},
    },
    misc = {
        achievement_descriptions = {},
        achievement_names = {},
        blind_states = {},
        challenge_names = {},
        collabs = {},
        dictionary = {
            -- when you do localize(x) it looks here for an entry with key x
            k_valk_artby = "Art by ",
            k_plus_kitty_tag = "+1 Kitty Tag",
            k_replaced_ex = "Replaced!",
        },
        high_scores = {},
        labels = {},
        poker_hand_descriptions = {},
        poker_hands = {},
        quips = {},
        ranks = {},
        suits_plural = {},
        suits_singular = {},
        tutorial = {},
        v_dictionary = {},
        v_text = {},
    },
}
