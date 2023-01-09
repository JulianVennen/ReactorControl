----               Main Loop               ----
local rules = dofile("/rc/rules.lua")
local cobalt = dofile("/cobalt/init.lua")
local reactor = peripheral.wrap("BACK")

function round(number)
    return math.floor(number + 0.5)
end

function drawValue(name, value, color, offset)
    cobalt.graphics.setColor("white")
    cobalt.graphics.print(name, 2 + offset, 16)
    cobalt.graphics.rect("line", 1 + offset, 1, 5, 13)
    cobalt.graphics.setColor(color)

    local length = round(value * 10);
    cobalt.graphics.rect("fill", 2 + offset, 13 - length, 2, length)
end

function cobalt.draw()
    drawValue("Fuel", reactor.getFuelFilledPercentage(), "green", 0)
    drawValue("Waste", reactor.getWasteFilledPercentage(), "orange", 7)
    drawValue("Water", reactor.getCoolantFilledPercentage(), "blue", 14)
    drawValue("Steam", reactor.getHeatedCoolantFilledPercentage(), "gray", 21)
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
