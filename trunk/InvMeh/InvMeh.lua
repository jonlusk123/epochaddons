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
			print("InvMeh by Undone and Elunora");
			print("/im on to Enable");
			print("/im off to Disable");
			print("/im <password> to set invite password.");
		else
			InvMeh_Password = msg;
		end
		print("InvMeh is "..InvMeh_Enabled);
		if (InvMeh_Enabled == "enabled") then print("Password is "..InvMeh_Password); end
	end

	SlashCmdList["INVMEH"] = handler; -- Also a valid assignment strategy

	local function InvMeh_OnEvent(self,event,arg1,arg2) 
		if (not UnitExists("party1") or IsPartyLeader("player") and arg1:lower():match(InvMeh_Password) and InvMeh_Enabled == "enabled") then
			if (GetNumPartyMembers() == 4) then 
				ConvertToRaid();
			end
			InviteUnit(arg2);
		else
			print("something went wrong "..GetNumPartyMembers().." "..UnitExists("party1").." "..UnitExists("party1"));
		end
	end

	local f = CreateFrame("frame") 
	f:RegisterEvent("CHAT_MSG_WHISPER") 
	f:SetScript("OnEvent", InvMeh_OnEvent); --function(self,event,arg1,arg2) 

end

