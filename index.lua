function _init()
  collision_sprites = { 0, 2 }

  make_player()
end

function _update()
  move_player()
end

function _draw()
  cls()
  map()
  draw_player()
  print(flr(player.x / 8))
  print(flr(player.y / 8))
end