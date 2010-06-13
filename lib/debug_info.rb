class DebugInfo
  attr_accessor :text
  
  def initialize(window)
    @font = Gosu::Font.new(window, Gosu::default_font_name, 20)
    @text = "\n"
  end

  def <<(text)
    @text += text.strip + "\n"
  end
  
  def draw(canvas)
    lines = @text.lines
    canvas.filled_rectangle(0,0,250,lines.count * 17, Gosu::Color.new(0x11111122), Z_DEBUG)

    lines.each_with_index do |line,i|
      @font.draw(line, 5,16 * i, Z_DEBUG,1,1,Gosu::black)      
    end

    draw_grid(canvas)
  end

  private 
  
  def draw_grid(canvas)
    size = 20
    #c = Gosu::Color.new(0xc8feffff)
    c = Gosu::blue
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