NeedsAssist = nil;

-------------------------------------------------------------
--EasyInvite function including all major logic for slash commands and events
function EasyInvite() 
	local function EasyInviteHandler(msg, editbox)
		local command, parameter = string.split(" ", msg, 2); -- tokenize the input into up to 2 inputs and assign to command and parameter

		EasyInvite_Init();
		
		if command == 'on' then
			EasyInvite_Enabled = "Enabled";
		elseif command == 'off' then
			EasyInvite_Enabled = "Disabled";
		elseif (command == '' or command == 'help') then
			EasyInvite_Feedback();
		elseif command == 'assist' then --handle the odd situation that someone picks "assist" as the normal invite password
			if parameter == nil then
				print("|c0000ffff".."assist is not a valid password".."|r");
			elseif parameter == 'on' then
				EasyInvite_Assist_Enabled = "Enabled";
			elseif parameter == 'off' then
				EasyInvite_Assist_Enabled = "Disabled";
			else
				EasyInvite_Assist_Password = parameter;
			end
		else
			EasyInvite_Password = command;
		end
		EasyInvite_Status();
	end


	local function EasyInvite_OnWhisper(self,event,arg1,arg2) 
		if ((arg1:lower():match(EasyInvite_Password) and (EasyInvite_Enabled == "Enabled")) or (arg1:lower():match(EasyInvite_Assist_Password) and (EasyInvite_Assist_Enabled == "Enabled"))) then
			if (GetNumPartyMembers() == 4) then 
				ConvertToRaid();
			end
			InviteUnit(arg2);
			if (arg1:lower():match(EasyInvite_Assist_Password) and (EasyInvite_Assist_Enabled == "Enabled")) then
				PromoteToAssistant(arg2);
				NeedsAssist = arg2;
				print("RX assist"..NeedsAssist);
			end
			--print("|cffffff00".."Password "..EasyInvite_Password.." Enabled "..EasyInvite_Enabled.."|r");
		else
			--print("|cffffff00".."Something went wrong "..GetNumPartyMembers().." "..UnitExists("party1").." "..IsPartyLeader("player").."|r");
		end
	end
	
	local function EasyInvite_OnRosterUpdate()
		if (NeedsAssist == nil) then
			print("No one to promote");
		else
			print("Attempting to promote "..NeedsAssist);
			PromoteToAssistant(NeedsAssist);
			NeedsAssist = nil;
		end
	end

	--Impliment valid slash commands
	SLASH_EASYINVITE1, SLASH_EASYINVITE2 = '/ei', '/easyinvite';
	SlashCmdList["EASYINVITE"] = EasyInviteHandler; -- Also a valid assignment strategy
	
	local Whisper = CreateFrame("frame") 
	Whisper:RegisterEvent("CHAT_MSG_WHISPER") 				--attach a chat whisper to OnEvent
	Whisper:SetScript("OnEvent", EasyInvite_OnWhisper); --attach the OnEvent function to EasyInvite_OnEvent
	local Whisper = CreateFrame("frame") 
	Whisper:RegisterEvent("RAID_ROSTER_UPDATE") 				--attach a chat whisper to OnEvent
	Whisper:SetScript("OnEvent", EasyInvite_OnRosterUpdate); --attach the OnEvent function to EasyInvite_OnEvent
	--PARTY_CONVERTED_TO_RAID RAID_ROSTER_UPDATE
end

-------------------------------------------------------------
--EasyInvite_Init defines saved global variables if they are not defined
function EasyInvite_Init()
	if (EasyInvite_Enabled == nil) then EasyInvite_Enabled = "Disabled"; end
	if (EasyInvite_Password == nil) then EasyInvite_Password = "addme"; end
	if (EasyInvite_Assist_Enabled == nil) then EasyInvite_Assist_Enabled = "Disabled"; end
	if (EasyInvite_Assist_Password == nil) then EasyInvite_Assist_Password = "addassist"; end
end

-------------------------------------------------------------
--EasyInvite_Feedback gives help feedback
function EasyInvite_Feedback()
	print("|cffffff00".."EasyInvite by".."|r".."|cffa37748".." Undone".."|r".."|cffffff00".." and ".."|r".."|cffa37748".."Elunora".."|r");
	print("|cffffff00".."/ei on".."|r".."|c0000ffff".." to Enable".."|r");
	print("|cffffff00".."/ei off".."|r".."|c0000ffff".." to Disable".."|r");
	print("|cffffff00".."/ei <password>".."|r".."|c0000ffff".." to set invite password.".."|r");
	print("|cffffff00".."/ei assist on".."|r".."|c0000ffff".." to Enable assist password".."|r");
	print("|cffffff00".."/ei assist off".."|r".."|c0000ffff".." to Disable assist password".."|r");
	print("|cffffff00".."/ei assist <password>".."|r".."|c0000ffff".." to set invite password with auto-promote to raid assist.".."|r");
end

-------------------------------------------------------------
--EasyInvite_Status gives comprehensive status feedback
function EasyInvite_Status()
	print("|c0000ffff".."EasyInvite is "..EasyInvite_Enabled.."|r".."|c0000ffff"..", Assist is "..EasyInvite_Assist_Enabled.."|r");
	print("|cffffff00".."Invite password is "..EasyInvite_Password.."|r".."|cffffff00"..", Assist password is "..EasyInvite_Assist_Password.."|r");
end

