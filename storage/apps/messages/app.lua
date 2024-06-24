function newMessage(number)
    local msg = gui:keyboard("Message au " .. number, "")

    if(msg ~= "") then
        gsm.newMessage(number, msg)
    end

    return msg
end

function appendMessage(msg, list)
    local bull = gui:box(list, 0, 0, 184, 30)
    
    local label = gui:label(bull, 0, 0, 184, 0)
    label:setHorizontalAlignment(CENTER_ALIGNMENT)
    label:setText(msg)
    label:setFontSize(18)

    local labelHeight = label:getTextHeight() + 8

    label:setHeight(labelHeight)

    local canva = gui:canvas(bull, 0, labelHeight, 68, 1)
    canva:fillRect(0, 0, 68, 1, COLOR_DARK)
    canva:setX(57)

    bull:setX(96)
end

function converation(number)
    win2=gui:window()

    local c = gsm.getContactByNumber(number)

    local title=gui:label(win2, 90, 30, 141, 18)
    title:setHorizontalAlignment(CENTER_ALIGNMENT)
    title:setFontSize(20)
    if(c.name ~= "") then
        title:setText(c.name)
    else
        title:setText(number)
    end

    list = gui:vlist(win2, 20, 76, 280, 320)
    
    messages = gsm.getMessages(number)

    for i, message in pairs(messages) do
        local bull = gui:box(list, 0, 0, 184, 30)
        
        local label = gui:label(bull, 0, 0, 184, 0)
        label:setHorizontalAlignment(CENTER_ALIGNMENT)
        label:setText(message.message)
        label:setFontSize(18)

        local labelHeight = label:getTextHeight() + 8

        label:setHeight(labelHeight)

        local canva = gui:canvas(bull, 0, labelHeight, 68, 1)
        canva:fillRect(0, 0, 68, 1, COLOR_DARK)
        canva:setX(57)

        if(message.who == false) then
            bull:setX(96)
        end

        bull:setHeight(labelHeight + 9)
    end

    local add = gui:box(win2, 250, 410, 40, 40)
    add:setMainColor(COLOR_DARK)
    add:setRadius(20)
        local icon_plus = gui:image(add, "plus.png", 14, 14, 12, 12, COLOR_DARK)
        

    add:onClick(function ()
        local msg = newMessage(number)

        if(msg ~= "") then
            appendMessage(msg, list)
        end
    end)

    local back = gui:image(win2, "back.png", 30, 30, 18, 18)
    back:onClick(function() 
        time:setTimeout(function () gui:del(win2) gui:setWindow(win) end, 0) end)

    gui:setWindow(win2)
end

function run()
    contactList = gsm:listContacts()

    win=gui:window()

    local title=gui:label(win, 35, 35, 144, 28)
    title:setFontSize(24)
    title:setText("Message")

    listO = gui:vlist(win, 35, 90, 250, 280)

    local files = storage:listDir("data")

    for i, file in ipairs(files) do
        local case = gui:box(listO, 0, 0, 250, 36)

        local number = file:match("(.+)%.json")

        local c = gsm.getContactByNumber(number)

        local name = gui:label(case, 0, 0, 230, 18)
        if c.name ~= "" then
            name:setText(c.name)
            name:setFontSize(16)
        else
            name:setText(number)
            name:setFontSize(16)
        end

        local num = gui:label(case, 0, 18, 230, 18)
        if c.name ~= "" then
            num:setText(c.phone)
        else
            num:setText("-")
        end

        num:setTextColor(COLOR_GREY)
        num:setFontSize(16)

        case:onClick(function() converation(number) end)
    end

    gui:setWindow(win)
end
