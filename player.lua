function make_player()
  player = {
    x = 7 * 8,
    y = 6 * 8,
    sprite = 16
  }
end

function make_boxes()
  box = {
    x = 8 * 8,
    y = 8 * 8,
    sprite = sprites.box
  }
end

function move_player_and_boxes()
  local move = { x = 0, y = 0 }

  if (btnp(0)) move.x = -8
  if (btnp(1)) move.x = 8
  if (btnp(2)) move.y = -8
  if (btnp(3)) move.y = 8
  local newPlayerX = player.x + move.x
  local newPlayerY = player.y + move.y

  if collinding_wall(newPlayerX, newPlayerY) then return end

  if not collinding_box(newPlayerX, newPlayerY) then
    player.x += move.x
    player.y += move.y
  end

  if collinding_box(newPlayerX, newPlayerY) and not collinding_wall(box.x + move.x, box.y + move.y) then
    player.x += move.x
    player.y += move.y

    box.x += move.x
    box.y += move.y
  end
end

function collinding_wall(x, y)
  return mget_coord(x, y) == sprites.wall
end

function mget_coord(x, y)
  return mget(x / 8, y / 8)
end

function collinding_box(x, y)
  return x == box.x and y == box.y
end

function check_win()
  if mget_coord(box.x, box.y) == sprites.goal then
    win = true
  end
end

function draw_player()
  spr(player.sprite, player.x, player.y)
end

function draw_boxes()
  spr(box.sprite, box.x, box.y)
end