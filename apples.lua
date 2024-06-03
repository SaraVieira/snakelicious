function make_apple()
    apple = {
        x = flr(rnd(120 / grid_size)),
        y = flr(rnd(120 / grid_size)),
        draw = function(self)
            circfill(
                (self.x * grid_size) + 4,
                (self.y * grid_size) + 4,
                2,
                8
            )
        end
    }

    return apple
end
