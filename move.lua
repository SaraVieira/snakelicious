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
        if btn(⬇️) then
            snake.dx = 0
            snake.dy = 1
        end
        if btn(⬆️) then
            snake.dx = 0
            snake.dy = -1
        end

        if btn(➡️) then
            snake.dx = 1
            snake.dy = 0
        end

        if btn(⬅️) then
            snake.dx = -1
            snake.dy = 0
        end

        snake:update()
    end
end
