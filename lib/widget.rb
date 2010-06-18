class Widget

  def initialize(window, x, y)
    @window, @x, @y = window, x, y
  end

  def contains?(x2,y2)
    x2 >= x and y2 >= y and x + w >= x2 and y + h >= y2
  end
  
    
end
