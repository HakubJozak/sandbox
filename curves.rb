require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'singleton'

SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480

GRAVITY = CP::Vec2.new(0,9.8)
NULL_VECTOR = CP::Vec2.new(0.0, 0.0)


class Space < CP::Space
  include Singleton
end

class GameObject
  attr_reader :body

  def initialize(x,y,color = Gosu::red)
    @body = CP::Body.new(10,5)
    @body.p.x = x
    @body.p.y = y
    @color = color    
  end
end


class Ball < GameObject
  
  def initialize(x,y, color = Gosu::green)
    super(x,y,color)
  end
  
end

class Stick < GameObject
  def initialize(x,y, color = Gosu::blue)
    super(x,y,color)
    space = Space.instance


    @size = 30
    @shape = CP::Shape::Segment.new( @body, CP::Vec2.new(-@size,0), CP::Vec2.new(@size,0), 1)

    space.add_body(@body)
    space.add_shape(@shape)
  end

  def draw(canvas)
    p = @body.p
    canvas.line(p.x - @size, p.y, p.x + @size, p.y, @color)
  end
end


class CurveGame < Gosu::Window
  include Singleton

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Curve"
    @game_objects = [ Stick.new(0,0,Gosu::green), Stick.new(-50,50,Gosu::red) ]

    # Time increment over which to apply a physics "step" ("delta t")
    @dt = (1.0/60.0)
  end

  def self.painter
    instance
  end

  def update
    @game_objects.each do |o|
      o.body.apply_force(GRAVITY * o.body.m,NULL_VECTOR)
      break
    end

    # true if button_down? Gosu::KbUp
    Space.instance.step(@dt)
  end

  def draw
    @game_objects.each { |o| o.draw(self) }
  end

  def button_down(id)
    if id == Gosu::KbEscape then
      close
    end
  end

  def line(x,y,x2,y2,color)
    offset_x = width / 2
    offset_y = height / 2
    draw_line(offset_x + x , offset_y + y, color, offset_x + x2, offset_y + y2, color)
  end

  def draw_track_quad(x1,y1,c1,x2,y2,c2,x3,y3,c3,x4,y4,c4)
    offset_x = 0 # width / 2
    offset_y = height / 2
    draw_quad(offset_x + x1, offset_y + y1, c1,
              offset_x + x2, offset_y + y2, c2,
              offset_x + x3, offset_y + y3, c3,
              offset_x + x4, offset_y + y4, c4)
  end


end

window = CurveGame.instance.show


