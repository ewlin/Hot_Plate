class Grid
    #initialize grid
    def initialize(gridSize)
        @gridSize = gridSize
        @maxDifference = 0
        @grid = Array.new(gridSize){[]}
        @turns = 0

        outerCounter = 0
        @grid.each do |row|
            innerCounter = 0
            while innerCounter < @gridSize do
                if outerCounter == 0 || outerCounter == (@grid.length - 1)
                    if innerCounter == 0 || innerCounter == @grid.length - 1
                        x = 0
                    else
                        x = 50
                    end
                elsif outerCounter == (@gridSize/2) || outerCounter == (@gridSize/2)-1
                    if innerCounter == (@gridSize/2) || innerCounter == (@gridSize/2)-1
                        x = 100
                    else
                        x = 50
                    end
                else
                    x = 50
                end
                row.push(x)
                innerCounter += 1
            end
            outerCounter += 1
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
            print @grid
            print @maxDifference
        end
    end

end

#if i == 0
#    if @grid[i][j] == 0
#        newValue = 0
#    else
#        newValue = ((@grid[i][j-1] + @grid[i+1][j] + @grid[i][j+1] + @grid[@gridSize-1][j])/4.to_f)
#    end
#elsif i == (@gridSize-1)
#    if @grid[i][j] == 0
#        newValue = 0
#    else
#        newValue = ((@grid[i][j-1] + @grid[i-1][j] + @grid[i][j+1] + @grid[0][j])/4.to_f)
#    end
#else
#    if @grid[i][j] == 100
#        newValue = 100
#    elsif j == 0
#        newValue = ((@grid[i-1][j] + @grid[i+1][j] + @grid[i][j+1] + @grid[i][@gridSize-1])/4.to_f)
#    elsif j == (@gridSize-1)
#        newValue = ((@grid[i-1][j] + @grid[i+1][j] + @grid[i][j-1] + @grid[i][0])/4.to_f)
#    else
#        newValue = ((@grid[i-1][j] + @grid[i+1][j] + @grid[i][j-1] + @grid[i][j+1])/4.to_f)
#    end
#end
    
