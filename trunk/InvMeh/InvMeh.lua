InvMeh_Enabled = "enabled"; --"disabled";
InvMeh_Password = "invmeh";

function InvMeh() 
	SLASH_INVMEH1, SLASH_INVMEH2 = '/im', '/invmeh';
	local function handler(msg, editbox)
		if msg == 'on' then
			InvMeh_Enabled = "enabled";
		elseif msg == 'off' then
			InvMeh_Enabled = "disabled";
		elseif msg == '' then
			print("|cffffff00".."InvMeh by Undone and Elunora".."|r");
			print("|cffffff00".."/im on to Enable".."|r");
			print("|cffffff00".."/im off to Disable".."|r");
			print("|cffffff00".."/im <password> to set invite password.".."|r");
		else
			InvMeh_Password = msg;
		end
		print("|cffffff00".."InvMeh is "..InvMeh_Enabled.."|r");
		if (InvMeh_Enabled == "enabled") then print("|cffffff00".."Password is "..InvMeh_Password.."|r"); end
	end

	SlashCmdList["INVMEH"] = handler; -- Also a valid assignment strategy

	local function InvMeh_OnEvent(self,event,arg1,arg2) 
		if ((not UnitExists("party1") or IsPartyLeader("player")) and arg1:lower():match(InvMeh_Password) and InvMeh_Enabled == "enabled") then
			if (GetNumPartyMembers() == 4) then 
				ConvertToRaid();
			end
			InviteUnit(arg2);
		else
			print("|cffffff00".."Something went wrong "..GetNumPartyMembers().." "..UnitExists("party1").." "..UnitExists("party1").."|r");
		end
	end

	local f = CreateFrame("frame") 
	f:RegisterEvent("CHAT_MSG_WHISPER") 
	f:SetScript("OnEvent", InvMeh_OnEvent); --function(self,event,arg1,arg2) 

end

