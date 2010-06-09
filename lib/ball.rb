require 'chipmunk'

class Ball
  
  def initialize(x,y, canvas)
    @body = CP::Body.new(20,5)
    @body.p.x = x
    @body.p.y = y
    Space.instance.add_body(@body)

    @image = Gosu::Image.new(canvas, pick_image, false)
    @shape = CP::Shape::Circle.new(@body, @image.width / 2, NULL_VECTOR)
    @shape.u = 5
    @shape.e = 1.02
    Space.instance.add_shape(@shape)
  end

  def draw(canvas)
    @image.draw_rot(@body.p.x, @body.p.y, 0, @body.a.radians_to_gosu)
  end

  def pick_image
    case rand(2)
      when 0: "images/yellow_ball.png"
      when 1: "images/blue_ball.png"
    end
  end
  
  def delete
    Space.instance.remove_shape(@shape)
    Space.instance.remove_body(@body)
  end
  
end
