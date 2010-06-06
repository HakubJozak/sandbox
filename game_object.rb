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
    @image.draw_rot(@body.p.x, @body.p.y, 0, @body.a.radians_to_gosu)
  end
  
end
