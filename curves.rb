require 'rubygems'
require 'gosu'
require 'chain'

class CurveGame < Gosu::Window

  SCREEN_WIDTH = 640
  SCREEN_HEIGHT = 480

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Curve"
    @chain = Chain.new(50)
  end

  def update
    true if button_down? Gosu::KbUp
  end

  def draw
    @chain.draw(self)
  end

  def button_down(id)
    if id == Gosu::KbEscape then
      close
    end
  end

  def draw_track(x,y,x2,y2,color)
    offset_x = 0 # width / 2
    offset_y = height / 2
    draw_line(offset_x + x , offset_y + y, color, offset_x + x2, offset_y + y2, color)
  end

end

window = CurveGame.new
window.show

