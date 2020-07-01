local TW = TerritoryWars

TW.FontsExist = {}

function TW:GenerateFonts()

	surface.CreateFont(
		"TW.Font" .. ScrH(),
		{
			font = "DermaDefault",
			extended = true,
			size = ScrH() * 0.045,
			weight = 500,
			blursize = 0,
			scanlines = 0,
			antialias = true,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = false,
			additive = false,
			outline = false
		}
	)

	surface.CreateFont(
		"TW.SFont" .. ScrH(),
		{
			font = "DermaDefault",
			extended = true,
			size = ScrH() * 0.025,
			weight = 500,
			blursize = 0,
			scanlines = 0,
			antialias = true,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = false,
			additive = false,
			outline = false
		}
	)

	surface.CreateFont(
		"TW.MFont" .. ScrH(),
		{
			font = "DermaDefault",
			extended = true,
			size = ScrH() * 0.015,
			weight = 500,
			blursize = 0,
			scanlines = 0,
			antialias = true,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = false,
			additive = false,
			outline = false
		}
	)

	TW.FontsExist[ScrH()] = true
end

timer.Create("TerritoryWars.ResolutionChecker", 1, 0, function()
	if not TW.FontsExist[ScrH()] then
		TW:GenerateFonts()
	end
end)
