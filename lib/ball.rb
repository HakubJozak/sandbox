require 'game_object'

class Ball < GameObject

  def initialize(x,y, canvas)
    @body = CP::Body.new(20,5)
    @body.p.x = x
    @body.p.y = y
    Space.instance.add_body(@body)

    @image = Gosu::Image.new(canvas, pick_image, false)
    @shape = CP::Shape::Circle.new(@body, @image.width / 2, NULL_VECTOR)
    @shape.u = 5
    @shape.e = 1.5
    @shape.obj = self
    Space.instance.add_shape(@shape)
  end

  def draw(canvas)
    @image.draw_rot(@body.p.x, @body.p.y, Z_GAME_OBJECTS, @body.a.radians_to_gosu)
  end

  def draw_bb(canvas)
    canvas.draw_bounding_box(@shape.bb)
  end

  def pick_image
    case rand(2)
      when 0 then "images/yellow_ball.png"
      when 1 then "images/blue_ball.png"
    end
  end

  def delete
    Space.instance.remove_shape(@shape)
    Space.instance.remove_body(@body)
  end
  
end
