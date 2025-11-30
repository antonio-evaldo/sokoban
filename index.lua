function _init()
  make_player()
end

function _update()
  move_player()
end

function _draw()
  cls()
  map()
  draw_player()
end