function isnb = IsNeighbor(center,test)
    isnb = false;
    for x = (center(1) - 1) : (center(1) + 1)
        for y = (center(2) - 1) : (center(2) + 1)
            if (x == test(1)) & (y == test(2))
                isnb = true;
                break;
            end
        end
    end