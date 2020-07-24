grid = {}
function love.load()
  for i=1,20 do
    grid[i] = {}
    for j=1,20 do
      grid[i][j] = 0
    end
  end
  grid[1][5] = 1
  grid[5][5] = -1
  grid[6][6] = -1
  grid[6][7] = -1
  turn = 1
end

function love.keypressed()
  for i = 10, 2, -1 do
    for j = 10, 2, -1 do
      if grid[i - 1][j] > 0 and grid[i][j] ~= -1 then
        grid[i][j] = grid[i][j] + grid[i - 1][j]
        grid[i - 1][j] = 0
        if grid[i + 1][j] == -1 then
          if grid[i][j + 1] ~= grid[i][j] and grid[i][j - 1] ~= grid[i][j] and grid[i][j + 1] ~= -1  and grid[i][j - 1] ~= -1 then
            newVol = (grid[i][j] + grid[i][j + 1] + grid[i][j - 1]) / 3
            grid[i][j] = newVol
            grid[i][j + 1] = newVol
            grid[i][j - 1] = newVol
          else
            if grid[i][j + 1] ~= grid[i][j] and grid[i][j + 1] ~= -1 then
              newVol = (grid[i][j] + grid[i][j + 1]) / 2
              grid[i][j] = newVol
              grid[i][j + 1] = newVol
            end
            if grid[i][j - 1] ~= grid[i][j] and grid[i][j - 1] ~= -1 then
              newVol = (grid[i][j] + grid[i][j - 1]) / 2
              grid[i][j] = newVol
              grid[i][j - 1] = newVol
            end
          end
        end
      end
    end
  end
end

function love.draw()
  love.graphics.setBackgroundColor(1, 1, 1)
  for i=1,10 do
    for j=1,10 do
      if grid[i][j] == -1 then
        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("fill", j * 50, i * 50, 50, 50)
      end
      if grid[i][j] > 0 then
        love.graphics.setColor(0, 0, 1, 0.5)
        love.graphics.rectangle("fill", j * 50, (i + 1 - grid[i][j]) * 50, 50, 50 * grid[i][j])
      end
      love.graphics.setColor(0, 0, 0)
      love.graphics.print(math.floor(grid[i][j]*100)/100, j * 50, i * 50)
    end
  end
end