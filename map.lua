function make_map()
  for x = 0, 15 do
    for y = 0, 15 do
      if mget(x, y) == player.sprite then
        player.x = x * 8
        player.y = y * 8
        mset(x, y, 0) -- remove player from static map
      elseif mget(x, y) == box.sprite then
        box.x = x * 8
        box.y = y * 8
        mset(x, y, 0) -- remove box from static map
      end
    end
  end
end

function draw_map()
  local map_tx = (level - 1) * 16
  map(map_tx, 0)
end