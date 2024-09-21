print("Plugin loaded")

function onInit()
    print("onInit called")
    keybinds = {
        ["F5"] = function()
            print("F5 key pressed")
            editor:print("Hello, World!")
        end
    }
end
