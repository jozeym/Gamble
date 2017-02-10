--initialize variables
local theMax
local low = 0;
local high = 0;
local chatmethod = "RAID";
local highplayername = "";
local lowplayername = "";
local difference = 0;
local t = {};

--set up slash command
SLASH_GAMBLE1 = "/gamble";
SlashCmdList["GAMBLE"] = function Gamble_SlashCmd(msg)
	local msg = msg:lower();
	local msgPrint = 0;
	if (msg == "" or msg == nil) then
	    print("Please set a maximum bet e.g. /gamble 10000. Maximum can be 1000, 10000, 50000, 100000, 250000, 500000 or 1000000.");
		msgPrint = 1;
	end
	--setting max bet price
	if (msg == "1000") then
		msgPrint = 1;
		theMax = 1000;
		takeBets(theMax);
	end
	if (msg == "10000") then
		msgPrint = 1;
		theMax = 10000;
		takeBets(theMax);
	end
	if (msg == "50000") then
		msgPrint = 1;
		theMax = 50000;
		takeBets(theMax);
	end
	if (msg == "100000") then
		msgPrint = 1;
		theMax = 100000;
		takeBets(theMax);
	end
	if (msg == "250000") then
		msgPrint = 1;
		theMax = 250000;
		takeBets(theMax);
	end
	if (msg == "500000") then
		msgPrint = 1;
		theMax = 500000;
		takeBets(theMax);
	end
	if (msg == "1000000") then
		msgPrint = 1;
		theMax = 1000000;
		takeBets(theMax);
	end
	if (msg == "reset") then
		reset();
		msgPrint = 1;		
	end
	--error handling
	if (msgPrint == 0) then
		print("Invalid argument for command /gamble.");
	end
end

function takeBets(theMax)
	--detecting chat method
	self:RegisterEvent("CHAT_MSG_RAID");
	self:RegisterEvent("CHAT_MSG_RAID_LEADER");
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	--output initial message for countdown
	SendChatMessage("Max bet is for " ..themax.. ". You have fifteen seconds to roll in chat to be included.", "RAID");
	C_Timer.After(15, function()
		--creat frame to collect rolls
		local f = CreateFrame("Frame")
		f:SetScript("OnEvent", function(self,event,...)
			local arg1 = select(1,...)
			if arg1 then
				print(arg1)
				--match rolls to collect data
				local name,roll,minRoll,maxRoll = arg1:match("^(.+) rolls (%d+) % ((%d+)%-(%d+)%)$")
				if name then	
					--typecast input to integers
					roll = tonumber(roll);
					minRoll = tonumber(minRoll);
					maxRoll = tonumber(maxRoll);
					
					--add name and roll to table
					table.insert(t,{key=name, value=roll});
					
					--get max
					local key, max = 0, t[1]
					for k, v in pairs(t) do
						if t[k] > max then
							key, max = k, v
						end
					end	
					highplayername = key;
					high = max;
					
					--get min
					local key, min = (theMax+1), t[1]
					for k, v in pairs(t) do
						if t[k] < min then
							key, min = k, v
						end
					end	
					lowplayername = key;
					low = min;
					
					--calculate amount to pay
					difference = max-min;
					
					--announce in chat who pays who what
					SendChatMessage(..lowplayername.. " Must pay " ..highplayername.. ..difference.. " gold.", "RAID");
			
					--reset variables
					reset();
				end	
			end
		)end
		f:RegisterEvent("CHAT_MSG_SYSTEM")
	end)
end

function reset()
	theMax = 0;
	low = 0;
	high = 0;
	highplayername = "";
	lowplayername = "";
	difference = 0;
	t = {};
	print("Gambling reset");
end
	
	
	
	
	
	
	
	
	
	
	
	