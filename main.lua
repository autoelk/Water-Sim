require "Water"

grid = {}
numTiles = 10
gridSize = math.floor(math.min(love.graphics.getWidth(), love.graphics.getHeight()) / tiles)

function love.load()
  t = 1 -- stores the current turn
  -- add a second layer to the grid array that stores what the grid will look like on the next turn
  for i = 1, numTiles do
    grid[i] = {}
    for j = 1, numTiles do
      grid[i][j] = {}
      for k = 1, 2 do
        grid[i][j][k] = Water:Create("gas", 0, i, j)
      end
    end
  end
  grid[1][4] = Water:Create("liquid", 1, 1, 4)
  grid[1][6] = Water:Create("liquid", 1, 1, 6)
  grid[3][4] = Water:Create("solid", 1, 3, 4)
  grid[4][5] = Water:Create("solid", 1, 4, 5)
  grid[4][6] = Water:Create("solid", 1, 4, 6)
  grid[5][7] = Water:Create("solid", 1, 5, 7)
end

function love.keypressed(key, isrepeat)
  for i = 1, numTiles do
    for j = 1, numTiles do
      grid[i][j][cur]:Update()
    end
  end
  t = t + 1
  cur = t % 2 + 1
  next = (cur + 1) % 2
end

function love.draw()
  love.graphics.setBackgroundColor(1,1,1)
  for i = 1, numTiles do
    for j = 1, numTiles do
      grid[i][j][t%2+1]:Draw()
    end
  end
  for i = 1, numTiles do
    love.graphics.setColor(0,0,0,0.4)
    love.graphics.line(gridSize * i, 0, gridSize * i, gridSize * numTiles)
    love.graphics.line(0, gridSize * i, gridSize * numTiles, gridSize * i)
  end
end