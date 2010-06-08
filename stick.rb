require 'yaml'
require 'chipmunk'


YAML_DOMAIN = "neorural.cz,2010"


class Stick

  def initialize(from,to, options = {})
    @from, @to = from, to

    @body = CP::Body.new(1.0 / 0.0, 1.0 / 0.0)
#    @body.p = from + ((to - from).length / 2.0)
    @body.p = CP::Vec2.new(0,0)

    @shape = CP::Shape::Segment.new( @body, from, to, 1)
    @shape.u = 5
    @color = Gosu::green
    Space.instance.add_static_shape(@shape)
  end

  def to_yaml(ops = {})
    { :a => @from, :b => @to }.to_yaml(ops)
  end

  def draw(canvas)
    canvas.line( @from.x, @from.y, @to.x, @to.y , @color)
  end
end


