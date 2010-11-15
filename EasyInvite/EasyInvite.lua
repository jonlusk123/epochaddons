EasyInvite_Enabled = "disabled"; --"enabled";

function EasyInvite() 
	SLASH_EASYINVITE1, SLASH_EASYINVITE2 = '/ei', '/easyinvite';
	local function handler(msg, editbox)
		if (EasyInvite_Password == nil) then EasyInvite_Password = "addme"; end
		if msg == 'on' then
			EasyInvite_Enabled = "enabled";
		elseif msg == 'off' then
			EasyInvite_Enabled = "disabled";
		elseif msg == '' then
			print("|cffffff00".."EasyInvite by".."|r".."|cffa37748".." Undone".."|r".."|cffffff00".." and ".."|r".."|cffa37748".."Elunora".."|r");
			print("|cffffff00".."/ei on to Enable".."|r");
			print("|cffffff00".."/ei off to Disable".."|r");
			print("|cffffff00".."/ei <password> to set invite password.".."|r");
		else
			EasyInvite_Password = msg;
		end
		print("|cffffff00".."EasyInvite is "..EasyInvite_Enabled.."|r");
		if (EasyInvite_Enabled == "enabled") then print("|cffffff00".."Password is "..EasyInvite_Password.."|r"); end
	end

	SlashCmdList["EASYINVITE"] = handler; -- Also a valid assignment strategy

	local function EasyInvite_OnEvent(self,event,arg1,arg2) 
		if ((not UnitExists("party1") or IsPartyLeader("player")) and (arg1:lower():match(EasyInvite_Password)) and (EasyInvite_Enabled == "enabled")) then
			if (GetNumPartyMembers() == 4) then 
				ConvertToRaid();
			end
			InviteUnit(arg2);
			--print("|cffffff00".."Password "..EasyInvite_Password.." Enabled "..EasyInvite_Enabled.."|r");
		else
			--print("|cffffff00".."Something went wrong "..GetNumPartyMembers().." "..UnitExists("party1").." "..IsPartyLeader("player").."|r");
		end
	end

	local f = CreateFrame("frame") 
	f:RegisterEvent("CHAT_MSG_WHISPER") 
	f:SetScript("OnEvent", EasyInvite_OnEvent); --function(self,event,arg1,arg2) 

end

