Water = {}
Water_mt = {__index = Water}
tiles = 10
gridSize = math.floor(math.min(love.graphics.getWidth(), love.graphics.getHeight()) / tiles)

function Water:Create(state, volume, row, col)
    local this = {
      state = state or "liquid",
      volume = volume or 1,
      row,
      col,
    }
    setmetatable(this, Water_mt)
    return this
end

function Water:Draw()
  if self.state == "solid" then
    love.graphics.setColor(0, 0, 1, 1)
    love.graphics.rectangle("fill", self.col * gridSize, self.row * gridSize,gridSize, gridSize)
  elseif self.state == "liquid" then
    love.graphics.setColor(0, 0, 1, 0.4)
    love.graphics.rectangle("fill", self.col * gridSize, (self.row + (1 - self.volume)) * gridSize, gridSize, gridSize * self.volume)
  elseif self.state == "gas" then
  end
end

-- simulates water behavior
function Water:Update()
  if self.state == "solid" then
  elseif self.state == "liquid" then
    -- check if the block under is empty
    if self.row < tiles then
      if grid[self.row + 1][self.col][cur].state == "liquid" then
        grid[self.row + 1][self.col][next].volume = 
      elseif grid[self.row + 1][self.col][cur].state == "gas" then
        grid[self.row + 1][self.col][next] = self
      end
    elseif self.volume >= 0.25 then
      -- spread the water
      if grid[self.row][self.col - 1].volume < self.volume then
      end
      if grid[self.row][self.col + 1].volume < self.volume then
    end
  elseif self.state == "gas" then
  end
end