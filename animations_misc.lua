function shake()
    local shake_x = rnd(intensity) - (intensity / 2)
    local shake_y = rnd(intensity) - (intensity / 2)

    --offset the camera
    camera(shake_x, shake_y)

    --ease shake and return to normal
    intensity = intensity * .9
    if intensity < .3 then intensity = 0 end
end

function add_fx(x, y, die, dx, dy, grav, grow, shrink, r, c_table)
    local fx = {
        x = x,
        y = y,
        t = 0,
        die = die,
        dx = dx,
        dy = dy,
        grav = grav,
        grow = grow,
        shrink = shrink,
        r = r,
        c = 0,
        c_table = c_table
    }
    add(effects, fx)
end

function update_fx()
    for fx in all(effects) do
        --lifetime
        fx.t = fx.t + 1
        if fx.t > fx.die then del(effects, fx) end

        --color depends on lifetime
        if fx.t / fx.die < 1 / #fx.c_table then
            fx.c = fx.c_table[1]
        elseif fx.t / fx.die < 2 / #fx.c_table then
            fx.c = fx.c_table[2]
        elseif fx.t / fx.die < 3 / #fx.c_table then
            fx.c = fx.c_table[3]
        else
            fx.c = fx.c_table[4]
        end

        --physics
        if fx.grav then
            fx.dy = fx.dy + .5
        end
        if fx.grow then
            fx.r = fx.grow + .1
        end
        if fx.shrink then
            fx.r = fx.r - .1
        end

        --move
        fx.x = fx.x + fx.dx
        fx.y = fx.y + fx.dy
    end
end

function draw_fx()
    for fx in all(effects) do
        --draw pixel for size 1, draw circle for larger
        if fx.r <= 1 then
            pset(fx.x, fx.y, fx.c)
        else
            circfill(fx.x, fx.y, fx.r, fx.c)
        end
    end
end

function explode(x, y, r, c_table, num)
    for i = 0, num do
        --settings
        add_fx(
            x,            -- x
            y,            -- y
            30 + rnd(25), -- die
            rnd(2) - 1,   -- dx
            rnd(2) - 1,   -- dy
            false,        -- gravity
            false,        -- grow
            true,         -- shrink
            r,            -- radius
            c_table       -- color_table
        )
    end
end

function trail(x, y, w, c_table, num)
    for i = 0, num do
        --settings
        add_fx(
            x + rnd(w) - w / 2, -- x
            y + rnd(w) - w / 2, -- y
            40 + rnd(30),       -- die
            0,                  -- dx
            0,                  -- dy
            false,              -- gravity
            false,              -- grow
            false,              -- shrink
            1,                  -- radius
            c_table             -- color_table
        )
    end
end
