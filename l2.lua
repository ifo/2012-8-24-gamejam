-- set initial values
l2 = {}
-- all tables (except keys)
l2.g,l2.p,l2.w,l2.c = {},{},{},{}

-- ground stuff
l2.g.y = love.graphics.getHeight() - 50
l2.g.st = 0
l2.g.ed = love.graphics.getWidth()
function l2.g.dr()
  love.graphics.line(l2.g.st,l2.g.y, l2.g.ed,l2.g.y)
end

-- wall stuff
l2.w.x = 450
l2.w.h = 100
l2.w.y = l2.g.y - l2.w.h
l2.w.w = 2

function l2.w.dr()
  love.graphics.rectangle("fill", l2.w.x, l2.w.y, l2.w.w, l2.w.h)
end

-- quit stuff
function l2.quitcheck()
  if love.keyboard.isDown("escape") then
    love.event.quit(print("quit"))
  end
end

-- win stuff
function l2.wincheck()
  if l2.p.x + l2.p.w >= l2.g.ed then
    flag = flag + 1
  end
end

-- player stuff
l2.p.h = 50
l2.p.w = 25
l2.p.x = 20
l2.p.y = l2.g.y - l2.p.h
l2.p.s = 200
function l2.p.dr()
  love.graphics.rectangle("fill", l2.p.x, l2.p.y, l2.p.w, l2.p.h)
end

function l2.p.mv(dt,r)
  if r then
    return l2.p.x + l2.p.s * dt
  else
    return l2.p.x - l2.p.s * dt
  end
end

function l2.p.edgecheck()
  if l2.p.x < 0 then
    l2.p.x = 0
  end
end

-- collision checks (player, wall, ledge)
function l2.c.rectcheck(r1, r2)
  if r1.x + r1.w < r2.x or
    r1.x > r2.x + r2.w or
    r1.y + r1.h < r2.y or
    r1.y > r2.y + r2.h then
    return false
  else
    return true
  end
end

-- love function stuff
function l2.update(dt)
  if love.keyboard.isDown("right") then
    l2.p.x = l2.p.mv(dt,true)
  end
  if love.keyboard.isDown("left") then
    l2.p.x = l2.p.mv(dt,false)
  end
  l2.quitcheck()
  l2.wincheck()
  l2.p.edgecheck()
end

function l2.draw()
  l2.g.dr()
  l2.p.dr()
  l2.w.dr()
  love.graphics.print("move to this edge to win -->", l2.g.ed - 200, 100)
  love.graphics.print('ignore this "wall" -->', l2.w.x - 130, 280)
  if l2.c.rectcheck(l2.p,l2.w) then
    love.graphics.print("touching the wall", 15, 15)
  else
    love.graphics.print("not touching the wall", 15, 15)
  end
end
