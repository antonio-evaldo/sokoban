function _init()
  win = false
  game_over = false

  sprites = {
    wall = 1,
    box = 2,
    goal = 3,
    water = 4,
    player = 16,
    pieces = {
      criar = { 64, 65 },
      po = 66,
      n = 67,
      te = 68
    },
    words = {
      ponte = {
        pieces = { 66, 67, 68 }
      }
    }
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

  print(player.x)
  print(player.y)
end