grid_size = 4
refresh_rate = 5
explode_size = 5
explode_colors = { 8, 9, 6, 5 }
explode_amount = 5
trail_width = 1.5
trail_colors = { 12, 13, 1 }
trail_amount = 2
line_color = 1
current_clip_x = 0
game_name = "snakelicious"



function _restart()
    effects = {}
    intensity = 0
    shake_control = 5

    apples = {}
    for i = 1, 2 do
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
                    (part.x * grid_size),
                    (part.y * grid_size),
                    ((part.x + 1) * grid_size - 1),
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
                -- local n = .9;

                part.x = snake.prev_x
                part.y = snake.prev_y

                -- if snake.dx == 1 then
                --     part.x = snake.prev_x - n
                -- elseif snake.dx == -1 then
                --     part.x = snake.prev_x + n
                -- else
                --     part.x = snake.prev_x
                -- end

                -- if snake.dy == 1 then
                --     part.y = snake.prev_y - n
                -- elseif snake.dy == -1 then
                --     part.y = snake.prev_y + n
                -- else
                --     part.y = snake.prev_y
                -- end




                snake.prev_x = orig_x
                snake.prev_y = orig_y
            end

            ate_apple = false
            for apple in all(apples) do
                if (
                        (flr(apple.y) or ceil(apple.Y)) == (flr(snake.y) or ceil(snake.Y))
                        and
                        (flr(apple.x) or ceil(apple.x)) == (flr(snake.x) or ceil(snake.x))
                    )

                then
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

function _init()
    current_state = "menu"
    cartdata(game_name)
    current_high_score = dget(0)
    _restart()
end

function _draw()
    cls()

    if current_state == "menu" then
        _draw_menu()
    end


    if current_state == "game" then
        _draw_game()
    end

    if (current_state == "game_over") then
        _draw_game_over()
    end
end
