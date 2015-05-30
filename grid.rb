class Grid
    #initialize grid
    def initialize(gridDimension)
        #declare grid dimensions 
        @gridSize = gridDimension
        @maxDifference = 0
        
        #create grid container 
        @grid = Array.new(gridDimension){[]}
        @turns = 0
        
        #fill grid with values 
        rowCounter = 0
        @grid.each do |row|
            columnCounter = 0
            while columnCounter < @gridSize do
                if rowCounter == 0 || rowCounter == (@grid.length - 1)
                    if columnCounter == 0 || columnCounter == @grid.length - 1
                        x = 0
                    else
                        x = 50
                    end
                elsif rowCounter == (@gridSize/2) || rowCounter == (@gridSize/2)-1
                    if columnCounter == (@gridSize/2) || columnCounter == (@gridSize/2)-1
                        x = 100
                    else
                        x = 50
                    end
                else
                    x = 50
                end
                row.push(x)
                columnCounter += 1
            end
            rowCounter += 1
        end
        
    end

    def hot_plate()
        cycle_max_diff = 0
        newGrid = Array.new(@gridSize){[]}
        for i in 0..(@gridSize-1)
            for j in 0..(@gridSize-1)
                if i == 0
                    if @grid[i][j] == 0
                        newValue = 0
                    else
                        newValue = (((@grid[i][j-1] + @grid[i+1][j] + @grid[i][j+1])/3.to_f).round(5))
                    end
                elsif i == (@gridSize-1)
                    if @grid[i][j] == 0
                        newValue = 0
                    else
                        newValue = (((@grid[i][j-1] + @grid[i-1][j] + @grid[i][j+1])/3.to_f).round(5))
                    end
                else
                    if @grid[i][j] == 100
                        newValue = 100
                    elsif j == 0
                        newValue = (((@grid[i-1][j] + @grid[i+1][j] + @grid[i][j+1])/3.to_f).round(5))
                    elsif j == (@gridSize-1)
                        newValue = (((@grid[i-1][j] + @grid[i+1][j] + @grid[i][j-1])/3.to_f).round(5))
                    else
                        newValue = (((@grid[i-1][j] + @grid[i+1][j] + @grid[i][j-1] + @grid[i][j+1])/4.to_f).round(5))
                    end
                end

                newGrid[i][j] = newValue
                (newValue-@grid[i][j]).abs > cycle_max_diff ? cycle_max_diff = (newValue-@grid[i][j]).abs : cycle_max_diff
            end
        end
        @grid = newGrid
        @maxDifference = cycle_max_diff

        if @maxDifference > 0.001
            @turns += 1
            hot_plate()
        else
            return self
        end
    end

end
