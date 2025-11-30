function make_player()
  player = {
    x = 7 * 8,
    y = 6 * 8,
    sprite = 16
  }
end

function move_player()
  local move = { x = 0, y = 0 }

  if (btnp(0)) move.x = -8
  if (btnp(1)) move.x = 8
  if (btnp(2)) move.y = -8
  if (btnp(3)) move.y = 8
  if check_collision(player.x + move.x, player.y + move.y) then
    player.x += move.x
    player.y += move.y
  end
end

function check_collision(x, y)
  -- for sprite in all(collision_sprites) do
  --   local is_colliding = mget(x / 8, y / 8) == sprite

  --   if is_colliding then
  --     return true
  --   end
  -- end

  -- return false

  return mget(x / 8, y / 8) != 1 and mget(x / 8, y / 8) != 2
end

function get_player_tile_map()
  return mget(flr(player.x / 8), flr(player.y / 8))
end

function draw_player()
  spr(player.sprite, player.x, player.y)
end