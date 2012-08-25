-- set initial values (level1)
l1 = {}
l1.g,l1.p = {}, {}

-- ground
l1.g.y = love.graphics.getHeight() - 50
l1.g.st = 0
l1.g.ed = love.graphics.getWidth()
function l1.g.dr()
  love.graphics.line(l1.g.st,l1.g.y, l1.g.ed,l1.g.y)
end

-- quit stuff
function l1.quitcheck()
  if love.keyboard.isDown("escape") then
    love.event.quit(print("quit"))
  end
end

-- win stuff
function l1.wincheck()
  if l1.p.x + l1.p.w >= l1.g.ed then
    flag = flag + 1
  end
end

-- player stuff
l1.p.h = 50
l1.p.w = 25
l1.p.x = 20
l1.p.y = l1.g.y - l1.p.h
l1.p.s = 200
function l1.p.dr()
  love.graphics.rectangle("fill", l1.p.x, l1.p.y, l1.p.w, l1.p.h)
end

function l1.p.mv(dt,r)
  if r then
    return l1.p.x + l1.p.s * dt
  else
    return l1.p.x - l1.p.s * dt
  end
end

function l1.p.edgecheck()
  if l1.p.x < 0 then
    l1.p.x = 0
  end
end

-- love function stuff
function l1.update(dt)
  if love.keyboard.isDown("right") then
    l1.p.x = l1.p.mv(dt,true)
  end
  if love.keyboard.isDown("left") then
    l1.p.x = l1.p.mv(dt,false)
  end
  l1.quitcheck()
  l1.wincheck()
  l1.p.edgecheck()
end

function l1.draw()
  l1.g.dr()
  l1.p.dr()
  love.graphics.print("move to this edge to win -->", l1.g.ed - 200, 200)
end
