function hcenter(s)
    -- screen center minus the
    -- string length times the
    -- pixels in a char's width,
    -- cut in half
    return 64 - #s * 2
end

function vcenter(s)
    -- screen center minus the
    -- string height in pixels,
    -- cut in half
    return 61
end

tim = 0

function wavey_wavey(text, speed, height, y)
    tim = tim + 1
    colors = { 8, 9, 10, 11, 12, 2 }
    local current_color = 0
    for i = 0, #text, 1 do
        if current_color >= #colors then
            current_color = 1
        elseif sub(text, i, i) != " " then
            current_color = current_color + 1
        end

        print(
            sub(text, i, i),
            (hcenter(text) - 8) + (i * 4),
            y + sin((tim + i) / speed) * height, colors[current_color])
    end
end