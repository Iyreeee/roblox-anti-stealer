getgenv().notif = newcclosure(function(_,t,d)
    game:GetService("StarterGui"):SetCore('SendNotification', {
        Title = _,
        Text = t,
        Duration = d,
    })
end)

local ld; ld = hookfunction(loadstring, newcclosure(function(code, _)
    local string_blacklist = {
        "stealer",
        "stolen",
        "tobi's",
        "trade",
        "cmd.exe",
        "linkingservice",
        "messagebusservice",
        "trade",
        "gift",
        "ratt",
        "all your items",
        "getdiscuser",
        ":5000/",
        "canihazip",
        "ipify",
        "grabify",
        "ipinfo",
        "ipconfig",
        "myip",
        "externalip",
        "checkip",
        "mailbox",
    }; for _,v in string_blacklist do
        if tostring(code):lower():find(v) then
            getgenv().notif("WARNING","Script execution halted; blacklisted string: " .. v, 10)
            return coroutine.yield();
        end;
    end;
    
    if code:find('This file was protected with MoonSec V3') then
        local function constant_getter_name(code: string)
            local find_pos = code:find("return'';")
            if not find_pos then
                return;
            end

            local sub = code:sub(1, find_pos);

            local func_name;
            for name in sub:gmatch("()([%w_%.]+)%s*%=%s*function%s*%(") do
                func_name = name;
            end
            for name in sub:gmatch("function%s+([%w_%.]+)%s*%(") do
                func_name = name;
            end
            for name in sub:gmatch("local%s+function%s+([%w_%.]+)%s*%(") do
                func_name = name;
            end

            if func_name then
                return func_name;
            end
        end

        local function add_to_str(original: string, index: number, toInsert: string): string
            return original:sub(1, index - 1) .. toInsert .. original:sub(index);
        end

        local name = constant_getter_name(code);
        local var_loc, reference_loc = code:find(`={name}()`);
        local variable_name = code:sub(var_loc-1, var_loc-1);

        code = add_to_str(code, reference_loc+4, ([[
        local string_blacklist = {
            "stealer",
            "stolen",
            "tobi's",
            "trade",
            "cmd.exe",
            "linkingservice",
            "messagebusservice",
            "trade",
            "gift",
            "ratt",
            "all your items",
            "getdiscuser",
            ":5000/",
            "canihazip",
            "ipify",
            "grabify",
            "ipinfo",
            "ipconfig",
            "myip",
            "externalip",
            "checkip",
            "mailbox",
        }; for _,v in string_blacklist do
            if tostring(VAR_NAME):lower():find(v) then
                getgenv().notif("WARNING","Script execution halted; blacklisted string: " .. tostring(VAR_NAME),10)
                return coroutine.yield();
            end;
        end;
        ]]):gsub('VAR_NAME', variable_name));
    end;

    return ld(code, _);
end));
