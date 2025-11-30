function make_player()
  player = {
    x = 7 * 8,
    y = 6 * 8,
    sprite = 16
  }
end

function move_player()
  if (btn(0)) player.x -= 1
  if (btn(1)) player.x += 1
  if (btn(2)) player.y -= 1
  if (btn(3)) player.y += 1
end

function draw_player()
  spr(player.sprite, player.x, player.y)
end