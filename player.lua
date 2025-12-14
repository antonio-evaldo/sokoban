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

function pointInScreen(point)
  return point.x >= 0 and point.x < 128 and point.y >= 0 and point.y < 128
end

function samePoints(pointA, pointB)
  return pointA.x == pointB.x and pointA.y == pointB.y
end

function move_player_and_boxes()
  if not btnp(0) and not btnp(1) and not btnp(2) and not btnp(3) then return end

  local move = { x = 0, y = 0 }

  if (btnp(0)) move.x = -8
  if (btnp(1)) move.x = 8
  if (btnp(2)) move.y = -8
  if (btnp(3)) move.y = 8
  local newPlayerPosition = {
    x = player.x + move.x,
    y = player.y + move.y
  }

  if not pointInScreen(newPlayerPosition) then return end

  if collinding_water(newPlayerPosition) then game_over = true end

  if collinding_wall(newPlayerPosition) then return end

  local empty_tile = findNextEmptyTileForMovement(move)

  if empty_tile == nil then return end

  player.x = newPlayerPosition.x
  player.y = newPlayerPosition.y

  local tileToMove = { x = newPlayerPosition.x, y = newPlayerPosition.y }

  while not samePoints(tileToMove, empty_tile) do
    local box_id = get_collinding_box(tileToMove)

    if box_id then
      boxes[box_id].x += move.x
      boxes[box_id].y += move.y
    end

    tileToMove.x += move.x
    tileToMove.y += move.y
  end

  -- local box_id = get_collinding_box(newPlayerPosition)

  -- if box_id == false then
  --   player.x = newPlayerPosition.x
  --   player.y = newPlayerPosition.y
  -- else
  --   local newBoxPosition = {
  --     x = newPlayerPosition.x + move.x,
  --     y = newPlayerPosition.y + move.y
  --   }

  --   if collinding_wall(newBoxPosition) then return end

  --   local second_box_id = get_collinding_box(newBoxPosition)

  --   if second_box_id == false then
  --     player.x = newPlayerPosition.x
  --     player.y = newPlayerPosition.y

  --     boxes[box_id].x = newBoxPosition.x
  --     boxes[box_id].y = newBoxPosition.y
  --   else
  --     local newSecondBoxPosition = {
  --       x = newBoxPosition.x + move.x,
  --       y = newBoxPosition.y + move.y
  --     }

  --     if collinding_wall(newSecondBoxPosition) then return end

  --     local third_box_id = get_collinding_box(newSecondBoxPosition)

  --     if third_box_id == false then
  --       player.x = newPlayerPosition.x
  --       player.y = newPlayerPosition.y

  --       boxes[box_id].x = newBoxPosition.x
  --       boxes[box_id].y = newBoxPosition.y

  --       boxes[second_box_id].x = newSecondBoxPosition.x
  --       boxes[second_box_id].y = newSecondBoxPosition.y
  --     else
  --     end
  --   end

  -- and can_move(newPlayerPosition, move)
  -- end
end

-- For now, an empty tile is any tile that isn't a wall or box
function findNextEmptyTileForMovement(move)
  local check_point = {
    x = player.x + move.x,
    y = player.y + move.y
  }

  while pointInScreen(check_point) do
    local box_id = get_collinding_box(check_point)

    if not collinding_wall(check_point) and box_id == nil then
      return check_point
    end

    check_point.x += move.x
    check_point.y += move.y
  end

  return nil
end

-- function can_move(point, move)
--   return true
--   -- return collinding_nothing(box.x + move.x, box.y + move.y)
--   -- return not collinding_wall(box.x + move.x, box.y + move.y)
--   -- return false
-- end

-- function collinding_nothing(point)
--   return mget_coord(point.x, point.y) == 0
-- end

function collinding_wall(point)
  return mget_coord(point.x, point.y) == sprites.wall
end

function collinding_water(point)
  return mget_coord(point.x, point.y) == sprites.water
end

-- If there's a colliding box in the given point, returns the box's id. If not, return nil.
function get_collinding_box(point)
  for box in all(boxes) do
    if (samePoints(point, box)) return box.id
  end

  return nil
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