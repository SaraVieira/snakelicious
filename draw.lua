function _draw_menu()
    map(0)
    clip(30, 0, current_clip_x, 128)
    -- wavey_wavey(game_name, hcenter(game_name), vcenter(game_name) - 16)
    wavey_wavey(game_name, 30, 6, vcenter() - 16)
    line(30, vcenter(), 90, vcenter(), 7)
    clip()
    textlabel = "press ❎  to start"
    print(textlabel, hcenter(textlabel), 114, 7)
    current_clip_x = current_clip_x + 2


    if btn(❎) then
        current_state = "game"
    end
end

function _draw_game()
    -- lines
    line(0, 0, 126, 0, line_color)
    line(0, 0, 0, 126, line_color)
    line(127, 0, 127, 127, line_color)
    line(0, 127, 127, 127, line_color)
    print(#snake.body, 10, 10, 7)
    draw_fx()

    snake:draw()
    for apple in all(apples) do
        apple:draw()
    end
end

function _draw_game_over()
    map(0)
    if current_high_score < #snake.body then
        local score = tostring(#snake.body)
        dset(0, #snake.body)
        local label = "new high score"
        print(label, hcenter(label), vcenter(label) - 12, 7)
        print(score, hcenter(score), vcenter(score), 7)
    else
        local label1 = "score: " .. #snake.body
        local label2 = "your high score is " .. current_high_score
        print(label2, hcenter(label2), vcenter(label2), 7)
        print(label1, hcenter(label1), vcenter(label1) - 12, 7)
    end
    textlabel = "press ❎  to restart"
    wavey_wavey(textlabel, 30, 6, 113)


    if btn(❎) then
        current_state = "game"
        _restart()
    end
end
