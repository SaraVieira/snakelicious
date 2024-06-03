grid_size = 4
refresh_rate = 5
explode_size = 5
explode_colors = { 8, 9, 6, 5 }
explode_amount = 5
trail_width = 1.5
trail_colors = { 12, 13, 1 }
trail_amount = 2
line_color = 1


function _init()
    effects = {}
    intensity = 0
    shake_control = 5
    cartdata("snakeit")
    current_high_score = dget(0)
    game_over = false
    apples = {}
    for i = 1, 25 do
        add(apples, make_apple())
    end
    snake = {
        clr = 9,
        dx = 1,
        dy = 0,
        x = 2,
        y = 3,
        prev_x = 0,
        prev_y = 0,
        body = {},
        draw = function(self)
            rectfill(
                self.x * grid_size,
                self.y * grid_size,
                (self.x + 1) * grid_size - 1,
                (self.y + 1) * grid_size - 1,
                snake.clr
            )

            for part in all(self.body) do
                rectfill(
                    part.x * grid_size,
                    part.y * grid_size,
                    (part.x + 1) * grid_size - 1,
                    (part.y + 1) * grid_size - 1,
                    snake.clr
                )
            end
        end,
        update = function(self)
            snake.x = snake.x + (snake.dx / refresh_rate)
            snake.y = snake.y + (snake.dy / refresh_rate)

            if #snake.body > 0 then
                local lastinBody = self.body[#self.body]

                trail(
                    (lastinBody.x * grid_size) + 2, (lastinBody.y * grid_size) + 2, trail_width, trail_colors,
                    trail_amount)
            else
                trail((snake.x * grid_size) + 2, (snake.y * grid_size) + 2, trail_width, trail_colors,
                    trail_amount)
            end


            for part in all(self.body) do
                local orig_y = part.y
                local orig_x = part.x

                part.x = snake.prev_x
                part.y = snake.prev_y


                snake.prev_x = orig_x
                snake.prev_y = orig_y
            end

            ate_apple = false
            for apple in all(apples) do
                if (apple.y == flr(snake.y) and apple.x == flr(snake.x)) or (apple.y == ceil(snake.y) and apple.x == ceil(snake.x)) then
                    del(apples, apple)
                    add(apples, make_apple())
                    ate_apple = true
                end
            end

            if ate_apple then
                intensity = intensity + shake_control
                explode(
                    snake.x * grid_size,
                    snake.y * grid_size,
                    explode_size,
                    explode_colors,
                    explode_amount
                )
                sfx(0)
                if refresh_rate > 1.2 then
                    refresh_rate = refresh_rate - .2
                end
                add(snake.body, {
                    x = self.prev_x,
                    y = self.prev_y
                })
            end
        end
    }
end

function _draw()
    cls()

    -- lines

    line(0, 0, 126, 0, line_color)
    line(0, 0, 0, 126, line_color)
    line(126, 0, 126, 126, line_color)
    line(0, 126, 126, 126, line_color)
    -- dset(0, 0)

    if (game_over) then
        if current_high_score < #snake.body then
            dset(0, #snake.body)
            print("New high score", 20, 20, 7)
            print(#snake.body)
        else
            print(#snake.body, 20, 20, 7)
            print("Your high score is " .. current_high_score)
        end
    else
        draw_fx()
        print(#snake.body, 5, 5, 7)

        snake:draw()
        for apple in all(apples) do
            apple:draw()
        end
    end
end
