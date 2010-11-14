
-- Slash Command
SLASH_HAI1 = '/hai';

function HelloWorld() 
  message("Welcome to World of Warcraft");
  SendWhisperMessage();
end

function SendWhisperMessage()
  -- SendChatMessage("Hello! I am testing my addon at login. You suck.", "WHISPER", "COMMON", "Ieroog");
end


function SlashCmdList.HAI(msg)
	msg = string.lower(msg)
	if (msg == "?") then  	print("Type /invmeh <keyword> to change the thing.");
							print("Note: Not case sensitive. 'on' and 'off' are reserved words.");
	elseif (msg == "allu") then SendChatMessage("plx dun kill mes allus", "PARTY");
	elseif (msg == "elu") then SendChatMessage("plx dun kill mes elus", "PARTY");
	elseif (msg == "nou") then SendChatMessage("plx dun kill mes nuzzrish", "PARTY");
	elseif (msg == "und") then SendChatMessage("plx dun kill mes undeons", "PARTY");
	else SendChatMessage("Attention Guild: Allurain smells. Also this is an addon.", "GUILD"); end
end

--[[
SlashCmdList['HAI'] = function()
  DEFAULT_CHAT_FRAME:AddMessage("Oh hai! I <3 u!");
end]]

-- 1. Pick HELLOWORLD as the unique identifier.
-- 2. Pick /hiw and /hellow as slash commands (/hi and /hello are actual emotes)

--[[
function SlashCmdList.HAI(msg) -- 4.
  DEFAULT_CHAT_FRAME:AddMessage(msg or 'nil');
end]]

--[[
SlashCmdList_AddSlashCommand('HAI', function(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg or 'nil');
end, 'hai')]]