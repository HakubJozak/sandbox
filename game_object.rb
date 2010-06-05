require 'rubygems'
require 'chipmunk'
require 'gosu'

class GameObject
  attr_reader :body

  def initialize(x,y)
    @body = CP::Body.new(20,5)
    @body.p.x = x
    @body.p.y = y
    Space.instance.add_body(@body)
  end
end


class Ball < GameObject
  
  def initialize(x,y, canvas, color = Gosu::green)
    super(x,y)
    @image = Gosu::Image.new(canvas, "images/ball.png", false)
    @shape = CP::Shape::Circle.new(@body, @image.width / 2, NULL_VECTOR)
    @shape.u = 5
    @shape.e = 10
    Space.instance.add_shape(@shape)
  end

  def draw(canvas)
    @image.draw_rot(@body.p.x, @body.p.y, 0, @body.a)
  end
  
end

class Stick
  def initialize(x,y, color = Gosu::blue)
    @body = CP::Body.new(1.0 / 0.0, 1.0 / 0.0)
    @body.p.x, @body.p.y, @color = x, y, color

    @size = 30
    @shape = CP::Shape::Segment.new( @body, CP::Vec2.new(-@size,0), CP::Vec2.new(@size,0), 1)
    @shape.u = 5
    @body.a = Math::PI/4

    Space.instance.add_static_shape(@shape)
  end

  def draw(canvas)
    p = @body.p    
    a = @body.a
    dx = @size * Math::sin(a)
    dy = @size * Math::cos(a)
    canvas.line(p.x - dx, p.y - dy, p.x + dx, p.y + dy, @color)
  end
end
