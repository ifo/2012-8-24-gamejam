function love.load()
  love.graphics.setMode(600,400,false,true,0)

  -- all tables (except keys)
  g,l,p,w,c = {},{},{},{},{}

  -- ground stuff
  g.y = love.graphics.getHeight() - 50
  g.st = 0
  g.ed = love.graphics.getWidth()
  function g.dr()
    love.graphics.line(g.st,g.y, g.ed,g.y)
  end

  -- platform (ledge) stuff
  function l.dr()
    -- no ledges yet
  end
  
  -- wall stuff
  w.x = 450
  w.h = 100
  w.y = g.y - w.h
  w.w = 2

  function w.dr()
    love.graphics.rectangle("fill", w.x, w.y, w.w, w.h)
  end

  -- quit stuff
  function quitcheck()
    if love.keyboard.isDown("escape") then
      love.event.quit(print("quit"))
    end
  end

  -- win stuff
  function wincheck()
    if p.x + p.w >= g.ed then
      love.event.quit(print("win"))
    end
  end

  -- player stuff
  p.h = 50
  p.w = 25
  p.x = 20
  p.y = g.y - p.h
  p.s = 200
  function p.dr()
    love.graphics.rectangle("fill", p.x, p.y, p.w, p.h)
  end

  function p.mv(dt,r)
    if r then
      return p.x + p.s * dt
    else
      return p.x - p.s * dt
    end
  end

  function p.edgecheck()
    if p.x < 0 then
      p.x = 0
    end
  end

  -- collision checks (player, wall, ledge)
  function c.rectcheck(r1, r2)
    if r1.x + r1.w < r2.x or
      r1.x > r2.x + r2.w or
      r1.y + r1.h < r2.y or
      r1.y > r2.y + r2.h then
      return false
    else
      return true
    end
  end
end

function love.update(dt)
  if love.keyboard.isDown("right") then
    p.x = p.mv(dt,true)
  end
  if love.keyboard.isDown("left") then
    p.x = p.mv(dt,false)
  end
  quitcheck()
  wincheck()
  p.edgecheck()
end

function love.draw()
  g.dr()
  p.dr()
  w.dr()
  l.dr() -- no ledges yet
  love.graphics.print("move to this edge to win -->", g.ed - 200, 100)
  love.graphics.print('ignore this "wall" -->', w.x - 130, 280)
  if c.rectcheck(p,w) then
    love.graphics.print("touching the wall", 15, 15)
  else
    love.graphics.print("not touching the wall", 15, 15)
  end
end
