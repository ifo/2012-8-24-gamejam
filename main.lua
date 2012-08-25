function love.load()
  love.graphics.setMode(600,400,false,true,0)

  function quitcheck()
    if love.keyboard.isDown("escape") then
      love.event.quit(print("quit"))
    end
  end

  function win()
    love.event.quit(print("win"))
  end

  require 'l1'
  require 'l2'
  require 'l3'

  flag = 1
end

function love.update(dt)
  ---[[
  if     flag == 1 then l1.update(dt)
  elseif flag == 2 then l2.update(dt)
  elseif flag == 3 then l3.update(dt)
  else
    quitcheck()
    win()
  end
  --]]
end

function love.draw()
  ---[[
  if     flag == 1 then l1.draw()
  elseif flag == 2 then l2.draw()
  elseif flag == 3 then l3.draw()
  else
    --l3.draw()
  end
  --]]
end

function love.keypressed(key)
  if flag == 3 then
    l3.k.check(key, true)
  end
end

function love.keyreleased(key)
  if flag == 3 then
    l3.k.check(key, false)
  end
end
