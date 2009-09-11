local AddonParent = LibStub("AceAddon-3.0"):GetAddon("SickOfClickingDailies")
local L = LibStub("AceLocale-3.0"):GetLocale("SOCD_Core")
local module = AddonParent:NewModule("DailyLogoutWarning")
module.noModuleControl = true

local titleText = ("|cff9933FF%s:|r "):format(L["Sick of Clicking Dailies"])
local hasWarnedLogout, hasWarnedQuit, orgi_Logout, orgi_Quit, orgi_CancelLogout = nil, nil, Logout, Quit, CancelLogout
local function printCompleteDailyQuests()
	local f = false
	for i  = 1, GetNumQuestLogEntries() do
		local questTitle, _, _, _, _, _, isComplete, isDaily= GetQuestLogTitle(i)
		if isDaily and isComplete then
			print(titleText, L["Daily Quest '%s' completed but not turned in"]:format(questTitle)); f = true
		end
	end	
	return f
end
function SOCD_Logout()
	if hasWarnedLogout then hasWarned = false; orgi_Logout()
	else
		hasWarnedLogout = true
		return printCompleteDailyQuests() or orgi_Logout(); 
	end
end
function SOCD_Quit()
	if hasWarnedQuit then hasWarnedQuit = false; orgi_Quit()
	else
		hasWarnedQuit = true
		return printCompleteDailyQuests() or orgi_Quit()
	end
end
function SOCD_CancelLogout()
	hasWarnedLogout, hasWarnedQuit = nil, nil
	orgi_CancelLogout(); StaticPopup_Hide("CAMP"); StaticPopup_Hide("QUIT")
end


function module:OnEnable()
	Logout, Quit, CancelLogout = SOCD_Logout, SOCD_Quit, SOCD_CancelLogout
end

function module:OnDisable()
	Logout, Quit, CancelLogout = orgi_Logout, orgi_Quit, orgi_CancelLogout
end


function module:GetOptionsTable(rootTable)
	local t = {
		DLW = { name = L["Warn when loging out with completed daily quests that are not turned in."],
			type = "toggle", width = "full", get = "GetModuleState", set = "ToggleModule", arg = "DailyLogoutWarning",
		},
	}
	rootTable.args.MiscOpt.plugins.DLW = t
	return nil
end
