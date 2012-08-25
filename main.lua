function love.load()
  love.graphics.setMode(600,400,false,true,0)

  -- all tables (except keys)
  g,l,p = {},{},{}

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
  l.dr() -- no ledges yet
  love.graphics.print("move to this edge to win -->", g.ed - 200, 200)
end
