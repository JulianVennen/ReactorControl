local gitget = "https://gist.githubusercontent.com/SquidDev/e0f82765bfdefd48b0b15a5c06c0603b/raw/clone.min.lua"
function clone (url, dir)
    if (fs.exists(dir)) then
        fs.delete(dir)
    end
    shell.run("wget", "run", gitget, url, dir)
end

clone("https://github.com/JulianVennen/ReactorControl", "rc")
clone("https://github.com/ebernerd/cobalt-2", "cobalt")

shell.run("clear")
textutils.slowPrint("Donwloaded. Use rc/run.lua to execute it.")