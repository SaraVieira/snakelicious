function _update()
    update_fx()
    if current_state == "game" then
        if intensity > 0 then shake() end

        if ceil(snake.x) == 32 or
            ceil(snake.x) == 0 or
            ceil(snake.y) == 0 or
            ceil(snake.y) == 32 then
            current_state = "game_over"
        end

        -- game over on touch itself
        for part in all(snake.body) do
            if part.x == snake.x and snake.y == part.y then
                current_state = "game_over"
            end
        end




        snake.prev_x = snake.x
        snake.prev_y = snake.y
        local check_y_collision = snake.dy == 0 or (#snake.body == 0)
        local check_x_collision = snake.dx == 0 or (#snake.body == 0)
        if btn(⬇️) then
            if check_y_collision then
                snake.dx = 0
                snake.dy = 1
            end
        end
        if btn(⬆️) then
            if check_y_collision then
                snake.dx = 0
                snake.dy = -1
            end
        end

        if btn(➡️) then
            if check_x_collision then
                snake.dx = 1
                snake.dy = 0
            end
        end

        if btn(⬅️) then
            if check_x_collision then
                snake.dx = -1
                snake.dy = 0
            end
        end

        snake:update()
    end
end
