require 'rubygems'
require 'chipmunk'
require 'gosu'

class GameObject
  attr_reader :body

  def initialize(x,y)
    @body = CP::Body.new(10,5)
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
    Space.instance.add_shape(@shape)
  end

  def draw(canvas)
    @image.draw_rot(@body.p.x, @body.p.y, 0, @body.a)
  end
  
end

class Stick < GameObject
  def initialize(x,y, color = Gosu::blue)
    super(x,y)
    @size = 30
    @color = color
    @shape = CP::Shape::Segment.new( @body, CP::Vec2.new(-@size,0), CP::Vec2.new(@size,0), 1)
    space = Space.instance
    space.add_body(@body)
    space.add_shape(@shape)
  end

  def draw(canvas)
    p = @body.p
    canvas.line(p.x - @size, p.y, p.x + @size, p.y, @color)
  end
end
