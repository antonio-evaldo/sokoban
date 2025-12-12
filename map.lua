function make_map()
  for x = 0, 15 do
    for y = 0, 15 do
      if mget_in_level(x, y) == player.sprite then
        player.x = x * 8
        player.y = y * 8
        mset_in_level(x, y, 0) -- remove player from static map
      elseif mget_in_level(x, y) == box.sprite then
        box.x = x * 8
        box.y = y * 8
        mset_in_level(x, y, 0) -- remove box from static map
      end
    end
  end
end

function mget_coord(x, y)
  return mget_in_level(x / 8, y / 8)
end

function mget_in_level(x, y)
  return mget(x + (level - 1) * 16, y)
end

function mset_in_level(x, y)
  return mset(x + (level - 1) * 16, y)
end

function draw_map()
  local map_tx = (level - 1) * 16
  map(map_tx, 0)
end