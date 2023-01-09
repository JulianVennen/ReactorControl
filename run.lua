----               Main Loop               ----
local rules = dofile("/rules.lua")
local cobalt = dofile("/cobalt/init.lua")
local reactor = peripheral.wrap("BACK")

function round(number)
    return math.floor(number + 0.5)
end

function cobalt.draw()

    cobalt.graphics.print("Fuel", 2, 16)
    cobalt.graphics.rect("line", 1, 1, 5, 13)
    cobalt.graphics.setColor("green")
    cobalt.graphics.rect("fill", 2, 2, 2, round(reactor.getFuelFilledPercentage() * 10))


    cobalt.graphics.print("Waste", 7, 16)
    cobalt.graphics.rect("line", 6, 1, 5, 13)
    cobalt.graphics.setColor("orange")
    cobalt.graphics.rect("fill", 7, 2, 2, round(reactor.getWasteFilledPercentage() * 10))

end

cobalt.init()

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
