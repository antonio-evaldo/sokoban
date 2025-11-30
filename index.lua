function _init()
  win = false

  sprites = {
    wall = 1,
    box = 2,
    goal = 3
  }

  make_player()
  make_boxes()
end

function _update()
  if not win then
    move_player_and_boxes()
    check_win()
  end
end

function _draw()
  cls()
  map()

  draw_player()
  draw_boxes()

  if (win) print('you won!', 50, 10)
end