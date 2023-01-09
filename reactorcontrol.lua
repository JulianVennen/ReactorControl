----               Main Loop               ----
local rules = dofile("/rules.lua")
local cobalt = dofile("/cobalt/init.lua")
local reactor = peripheral.wrap("BACK")

--[[
function cobalt.draw()
    cobalt.graphics.rect("line", 5, 5, 500, 500)
end

cobalt.init()
]]

while (true) do
    if reactor.getStatus() then
        for name, rule in pairs(rules) do
            if rule.shouldTurnOff(reactor) then
                print("Rule " .. name .. " violated, turning off reactor!")
                reactor.scram()
            end
        end
    else
        local shouldTurnOn = true;
        for name, rule in pairs(rules) do
            if rule.shouldTurnOn(reactor) then
                print("Rule " .. name .. " clear")
            else
                print("Rule " .. name .. " failed")
                shouldTurnOn = false
            end
        end

        if shouldTurnOn then
            print("All rules are clear, turning on reactor!")
            reactor.activate()
        end
    end
end
