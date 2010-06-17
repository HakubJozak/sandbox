class DebugInfo
  
  def initialize(window)
    @font = Gosu::Font.new(window, Gosu::default_font_name, 20)
    @selected = nil
  end

  def object_selected(selected)
    @selected = selected
  end

  
  def draw(canvas)
    lines = @selected.nil? ? ["No object selected"] : @selected.info
    chars = lines.max_by { |l| l.length }

    canvas.filled_rectangle(0,0, 14 + @font.text_width(chars), 17 * lines.count, Gosu::Color.new(0x5c5c5c22), Z_DEBUG )

    lines.each_with_index do |line,i|
      @font.draw(line, 5,16 * i, Z_DEBUG,1,1,Gosu::black)      
    end

    draw_grid(canvas)
  end

  private 
  
  def draw_grid(canvas)
    size = 20
    c = Gosu::Color.new(0xcececeff)
    w = SCREEN_WIDTH / size
    h = SCREEN_HEIGHT / size

    h.downto(0) do |y|
      canvas.draw_line(0 , y*size, c, SCREEN_WIDTH, y*size, c, Z_GRID)            
    end

    w.downto(0) do |x|
      canvas.draw_line(x*size,0, c, x*size, SCREEN_HEIGHT, c, Z_GRID)      
    end
  end
end
