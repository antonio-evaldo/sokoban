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

  local empty_or_wall = findNextEmptyTileOrWall(move)

  if empty_or_wall == nil or empty_or_wall.type == "wall" then return end

  -- if there's at least one empty tile before the next wall/limit, move the player.
  player.x = newPlayerPosition.x
  player.y = newPlayerPosition.y

  -- move all boxes (if any) between player and next empty tile
  local tileToMove = { x = newPlayerPosition.x, y = newPlayerPosition.y }

  while not samePoints(tileToMove, empty_or_wall) do
    local box_id = get_collinding_box(tileToMove)

    if box_id then
      boxes[box_id].x += move.x
      boxes[box_id].y += move.y
    end

    tileToMove.x += move.x
    tileToMove.y += move.y
  end
end

function findNextEmptyTileOrWall(move)
  local check_point = {
    x = player.x + move.x,
    y = player.y + move.y
  }

  while pointInScreen(check_point) do
    local box_id = get_collinding_box(check_point)

    if not collinding_wall(check_point) and box_id == nil then
      check_point.type = "empty"

      return check_point
    elseif collinding_wall(check_point) then
      check_point.type = "wall"

      return check_point
    end

    check_point.x += move.x
    check_point.y += move.y
  end

  -- returns nil when couldn't find any empty tile or wall until screen limit. It happens when you have colliding boxes between player and the limit, for example.
  return nil
end

function collinding_wall(point)
  return mget_coord(point.x, point.y) == sprites.wall
end

function collinding_water(point)
  return mget_coord(point.x, point.y) == sprites.water
end

-- If there's a colliding box in the given point, returns the box's id. If not, returns nil.
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