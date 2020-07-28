grid = {}
gridSize = 10
tileSize = 50

function love.load()
  math.randomseed(os.time())
  for i=1,gridSize + 1 do
    grid[i] = {}
    for j=1,gridSize + 1 do
      grid[i][j] = 0;
    end
  end

  for i=1,gridSize do
    for j=1,gridSize do
      x = math.random()
      if x < 0.2 then
        grid[i][j] = -1
      elseif x < 0.4 then
        grid[i][j] = 1
      end
    end
  end
end

timer = 0
function love.update(dt)
  timer = timer + dt
  if timer >= 0.4 then
    updateAll()
    timer = 0
  end
end

function love.keypressed()
  updateAll()
end

function love.draw()
  love.graphics.setBackgroundColor(1, 1, 1)
  for i=1,gridSize do
    for j=1,gridSize do
      if grid[i][j] == -1 then
        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("fill", j * tileSize, i * tileSize, tileSize, tileSize)
      end
      if grid[i][j] > 0 then
        love.graphics.setColor(0, 0, 1, 0.5)
        love.graphics.rectangle("fill", j * tileSize, (i + 1 - grid[i][j]) * tileSize, tileSize, tileSize * grid[i][j])
      end
      -- love.graphics.setColor(0, 0, 0)
      -- love.graphics.printf(math.floor(grid[i][j]*100)/100, j * 50, i * 50 + tileSize / 2, 50, "center")
    end
  end
end

function updateAll()
  for i = gridSize, 1, -1 do
    for j = gridSize, 1, -1 do
      if grid[i][j] > 0 and grid[i + 1][j] ~= -1 and grid[i + 1][j] < 1 then
        newVol = grid[i + 1][j] + grid[i][j]
        if (newVol > 1) then
          grid[i + 1][j] = 1
          grid[i][j] = newVol - 1
        else
          grid[i + 1][j] = newVol
          grid[i][j] = 0
        end
      end
      if grid[i][j] > 0 and (grid[i + 1][j] == -1 or grid[i + 1][j] >= 1) then
        spread(i, j)
      end
    end
  end
end

function spread(i, j)
  if j + 1 <= gridSize and j - 1 >= 1 and grid[i][j + 1] ~= grid[i][j] and grid[i][j - 1] ~= grid[i][j] and grid[i][j + 1] ~= -1  and grid[i][j - 1] ~= -1 then
    newVol = (grid[i][j] + grid[i][j + 1] + grid[i][j - 1]) / 3
    grid[i][j] = newVol
    grid[i][j + 1] = newVol
    grid[i][j - 1] = newVol
  elseif j + 1 <= gridSize and grid[i][j + 1] ~= grid[i][j] and grid[i][j + 1] ~= -1 then
    newVol = (grid[i][j] + grid[i][j + 1]) / 2
    grid[i][j] = newVol
    grid[i][j + 1] = newVol
  elseif j - 1 >= 1 and grid[i][j - 1] ~= grid[i][j] and grid[i][j - 1] ~= -1 then
    newVol = (grid[i][j] + grid[i][j - 1]) / 2
    grid[i][j] = newVol
    grid[i][j - 1] = newVol
  end
end