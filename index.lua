function _init()
  win = false
  game_over = false

  sprites = {
    wall = 1,
    box = 2,
    goal = 3,
    water = 4,
    player = 16
  }

  level = 2

  make_player()
  make_boxes()
  make_map()
end

function _update()
  if not win and not game_over then
    move_player_and_boxes()
    check_win()
  end
end

function _draw()
  cls()

  draw_map()
  draw_player()
  draw_boxes()

  if win then
    print('you won!', 50, 10)
  elseif game_over then
    print('you lost.', 50, 10)
  end
end