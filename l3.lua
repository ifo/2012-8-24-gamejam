-- set initial values
l3 = {}
-- all tables (except keys)
l3.g,l3.p,l3.w,l3.c,l3.k = {},{},{},{},{}

-- ground stuff
l3.g.y = love.graphics.getHeight() - 50
l3.g.st = 0
l3.g.ed = love.graphics.getWidth()
function l3.g.dr()
  love.graphics.line(l3.g.st,l3.g.y, l3.g.ed,l3.g.y)
end

-- wall stuff
l3.w.x = 450
l3.w.h = 100
l3.w.y = l3.g.y - l3.w.h
l3.w.w = 2

function l3.w.dr()
  love.graphics.rectangle("fill", l3.w.x, l3.w.y, l3.w.w, l3.w.h)
end

-- quit stuff
function l3.quitcheck()
  if love.keyboard.isDown("escape") then
    love.event.quit(print("quit"))
  end
end

-- win stuff
function l3.wincheck()
  if l3.p.x + l3.p.w >= l3.g.ed then
    flag = flag + 1
  end
end

-- player stuff
l3.p.h = 50
l3.p.w = 25
l3.p.x = 20
l3.p.y = l3.g.y - l3.p.h
l3.p.y2 = 0
l3.p.jumping = false
l3.p.s = 200
function l3.p.dr()
  love.graphics.rectangle("fill", l3.p.x, l3.p.y, l3.p.w, l3.p.h)
end

function l3.p.walk(dt,r)
  if r then
    return l3.p.x + l3.p.s * dt
  else
    return l3.p.x - l3.p.s * dt
  end
end

function l3.p.startjump()
  l3.p.jumping = true
  l3.p.y2 = 300
end

function l3.p.jump(dt)
  l3.p.y = l3.p.y - l3.p.y2 * dt
  l3.p.y2 = l3.p.y2 - 400 * dt
  if l3.p.y > l3.g.y - l3.p.h then
    l3.p.y = l3.g.y - l3.p.h
    l3.p.y2 = 0
    l3.p.jumping = false
  end
end

function l3.p.edgecheck()
  if l3.p.x < 0 then
    l3.p.x = 0
  end
end

function l3.p.mv(dt)
  if l3.k.r then
    l3.p.x = l3.p.walk(dt,true)
  end
  if l3.k.l then
    l3.p.x = l3.p.walk(dt,false)   
  end
  if l3.k.u and not l3.p.jumping then
    l3.p.startjump()
  else
    l3.p.jump(dt)
  end
end

-- 'stupid' wall 'blocking'
function l3.p.wall()
  if l3.c.rectcheck(l3.p, l3.w) then
    l3.p.x = l3.w.x - l3.p.w
  end
end

-- collision checks (player, wall, ledge)
function l3.c.rectcheck(r1, r2)
  if r1.x + r1.w < r2.x or
    r1.x > r2.x + r2.w or
    r1.y + r1.h < r2.y or
    r1.y > r2.y + r2.h then
    return false
  else
    return true
  end
end

-- key handler
l3.k.u, l3.k.d, l3.k.r, l3.k.l = false,false,false,false
function l3.k.check(key, bool)
  if key == "left" then
    l3.k.l = bool
  elseif key == "right" then
    l3.k.r = bool
  elseif key == "up" then
    l3.k.u = bool
  end
end

-- love function stuff
function l3.update(dt)
  --[[
  if love.keyboard.isDown("right") then
    l3.p.x = l3.p.walk(dt,true)
  end
  if love.keyboard.isDown("left") then
    l3.p.x = l3.p.walk(dt,false)
  end
  --]]
  l3.quitcheck()
  l3.wincheck()
  l3.p.mv(dt)
  l3.p.edgecheck()
  l3.p.wall()
end

function l3.draw()
  l3.g.dr()
  l3.p.dr()
  l3.w.dr()
  love.graphics.print("move to this edge to win -->", l3.g.ed - 200, 100)
  love.graphics.print('don\'t ignore this "wall" -->', l3.w.x - 170, 280)
end
