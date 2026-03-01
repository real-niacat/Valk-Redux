local create_mod_badges_hook = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	create_mod_badges_hook(obj, badges)
	if not obj then
		return
	end

	for _, badge in pairs(Valk.badges) do
		if badge.should_apply(obj) then
			table.insert(badges, 2, Valk.util.generate_badge(badge, obj))
		end
	end

	if not SMODS.config.no_mod_badges and obj and obj.valk_artist then
		local function calc_scale_fac(text)
			local size = 0.9
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			-- Math reproduced from DynaText:update_text
			for _, c in utf8.chars(text) do
				local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
					+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
				calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
			return scale_fac
		end
		local scale_fac = {}
		local min_scale_fac = 1
		local strings =
			{ Valk.mod.display_name, localize("k_valk_artby") .. Valk.artists[obj.valk_artist].display_name }
		for i = 1, #strings do
			scale_fac[i] = calc_scale_fac(strings[i])
			min_scale_fac = math.min(min_scale_fac, scale_fac[i])
		end
		local ct = {}
		for i = 1, #strings do
			ct[i] = {
				string = strings[i],
			}
		end
		local artist_badge = {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						colour = Valk.mod.badge_colour,
						r = 0.1,
						minw = 2 / min_scale_fac,
						minh = 0.36,
						emboss = 0.05,
						padding = 0.03 * 0.9,
					},
					nodes = {
						{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						{
							n = G.UIT.O,
							config = {
								object = DynaText({
									string = ct or "ERROR",
									colours = { G.C.WHITE },
									silent = true,
									float = true,
									shadow = true,
									offset_y = -0.03,
									spacing = 1,
									scale = 0.33 * 0.9,
								}),
							},
						},
						{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
					},
				},
			},
		}
		for i = 1, #badges do
			if badges[i].nodes[1].nodes[2].config.object.string == Valk.mod.display_name then --this was meant to be a hex code but it just doesnt work for like no reason so its hardcoded
				badges[i].nodes[1].nodes[2].config.object:remove()
				badges[i] = artist_badge
				break
			end
		end
	end
end

---@class Badge
---@field colour function
---@field text_colour function
---@field get_text function
---@field should_apply function

---@type Badge[]
Valk.badges = {
	{
		should_apply = function(center)
			return center.pools and center.pools.Kitty
		end,
		get_text = function(center)
			return { localize("valk_badge_kitty") }
		end,
		colour = function()
			return SMODS.Gradients["valk_grad2"]
		end,
	},
	{
		should_apply = function(center)
			return (not center.valk_artist) and center.original_mod and center.original_mod.id == Valk.mod.id
		end,
		get_text = function(center)
			return { localize("valk_badge_missing_art") }
		end,
		colour = function()
			return SMODS.Gradients["warning_bg"]
		end,
		text_colour = function()
			return SMODS.Gradients["warning_text"]
		end,
	},
}

function Valk.util.generate_badge(badge, obj)
	local strs = badge.get_text(obj)
	if type(strs) == "string" then
		strs = { strs }
	end
	local strings = {}
	for i = 1, #strs do
		strings[i] = {
			string = strs[i],
		}
	end

	return {
		n = G.UIT.R,
		config = { align = "cm" },
		nodes = {
			{
				n = G.UIT.R,
				config = {
					align = "cm",
					colour = badge.colour and badge.colour() or G.C.RED,
					r = 0.1,
					minw = 2,
					minh = 0.36,
					emboss = 0.05,
					padding = 0.03 * 0.9,
				},
				nodes = {
					{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
					{
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = strings or "ERROR",
								colours = { badge.text_colour and badge.text_colour() or G.C.WHITE },
								silent = true,
								float = true,
								shadow = true,
								offset_y = -0.03,
								spacing = 1,
								scale = 0.33 * 0.9,
							}),
						},
					},
					{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
				},
			},
		},
	}
end
