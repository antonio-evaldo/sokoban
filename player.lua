function make_player()
  player = {
    x = nil,
    y = nil,
    sprite = sprites.player
  }
end

function make_boxes()
  boxes = {}
end

function move_player_and_boxes()
  local move = { x = 0, y = 0 }

  if (btnp(0)) move.x = -8
  if (btnp(1)) move.x = 8
  if (btnp(2)) move.y = -8
  if (btnp(3)) move.y = 8
  local newPlayerPos = {
    x = player.x + move.x,
    y = player.y + move.y
  }

  if collinding_wall(newPlayerPos) then return end

  if collinding_water(newPlayerPos) then game_over = true end

  if not collinding_box(newPlayerPos) then
    player.x += move.x
    player.y += move.y
  end

  if collinding_box(newPlayerPos) then
    local box_id = get_collinding_box(newPlayerPos)

    local newBoxPos = {
      x = newPlayerPos.x + move.x,
      y = newPlayerPos.y + move.y
    }

    if not collinding_wall(newBoxPos) then
      player.x += move.x
      player.y += move.y

      boxes[box_id].x += move.x
      boxes[box_id].y += move.y
      -- elseif collinding_box(newBoxPos) then
      --   local newSecondBoxPos = {
      --     x = newBoxPos.x + move.x,
      --     y = newBoxPos.y + move.y
      --   }
    end
    -- and can_move(newPlayerPos, move)
  end
end

function can_move(point, move)
  return true
  -- return collinding_nothing(box.x + move.x, box.y + move.y)
  -- return not collinding_wall(box.x + move.x, box.y + move.y)
  -- return false
end

function collinding_nothing(point)
  return mget_coord(point.x, point.y) == 0
end

function collinding_wall(point)
  return mget_coord(point.x, point.y) == sprites.wall
end

function collinding_water(point)
  return mget_coord(point.x, point.y) == sprites.water
end

function collinding_box(point)
  for box in all(boxes) do
    if (point.x == box.x and point.y == box.y) return true
  end
end

function get_collinding_box(point)
  for box in all(boxes) do
    if (point.x == box.x and point.y == box.y) return box.id
  end
end

function check_win()
  -- if mget_coord(box.x, box.y) == sprites.goal then
  --   win = true
  -- end
end

function draw_player()
  spr(player.sprite, player.x, player.y)
end

function draw_boxes()
  for box in all(boxes) do
    spr(sprites.box, box.x, box.y)
  end
end