class DebugInfo
  attr_accessor :text
  
  def initialize(window)
    @font = Gosu::Font.new(window, Gosu::default_font_name, 20)
    @text = ''
  end
  
  def draw(canvas)
    canvas.filled_rectangle(0,0,200,30, Gosu::Color.new(0x11111122))
    @font.draw(@text, 5,5, 0,1,1,Gosu::black)
  end
end
