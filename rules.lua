local FuelRule = { }
function FuelRule.shouldTurnOn (reactor)
    return reactor.getFuelFilledPercentage() > 0.15;
end
function FuelRule.shouldTurnOff (reactor)
    return reactor.getFuelFilledPercentage() < 0.05;
end

local WasteRule = { }
function WasteRule.shouldTurnOn (reactor)
    return reactor.getWasteFilledPercentage() < 0.15;
end
function WasteRule.shouldTurnOff (reactor)
    return reactor.getWasteFilledPercentage() > 0.30;
end

local CoolantRule = { }
function CoolantRule.shouldTurnOn (reactor)
    return reactor.getCoolantFilledPercentage() > 0.90;
end
function CoolantRule.shouldTurnOff (reactor)
    return reactor.getCoolantFilledPercentage() < 0.75;
end

local SteamRule = { }
function SteamRule.shouldTurnOn (reactor)
    return reactor.getHeatedCoolantFilledPercentage() < 0.30;
end
function SteamRule.shouldTurnOff (reactor)
    return reactor.getHeatedCoolantFilledPercentage() > 0.50;
end

local TemperatureRule = { }
function TemperatureRule.shouldTurnOn (reactor)
    return reactor.getTemperature() < 500;
end
function TemperatureRule.shouldTurnOff (reactor)
    return reactor.getTemperature() > 800;
end

return { fuel = FuelRule, waste = WasteRule, coolant = CoolantRule, steam = SteamRule }
