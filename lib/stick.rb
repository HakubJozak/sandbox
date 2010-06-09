require 'yaml'
require 'chipmunk'


class Stick
  
  attr_reader :from, :to
  yaml_mapping 'stick', :from, :to

  def initialize(from,to, options = {})
    @from, @to = from, to

    @body = CP::Body.new(1.0 / 0.0, 1.0 / 0.0)
#    @body.p = from + ((to - from).length / 2.0)
    @body.p = CP::Vec2.new(0,0)

    @shape = CP::Shape::Segment.new( @body, from, to, 1)
    @shape.u = 5
    @shape.e = 0.5
    @color = Gosu::black
    Space.instance.add_static_shape(@shape)
  end

  def delete
    Space.instance.remove_static_shape(@shape)
    Space.instance.remove_body(@body)
  end

  def draw(canvas)
    canvas.line( @from.x, @from.y, @to.x, @to.y , @color)
  end

end


YAML::add_domain_type( YAML_DOMAIN, "stick" ) do |type, val|
  Stick.new( val['from'], val['to'] )
end


