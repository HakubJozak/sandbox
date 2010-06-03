require 'node'
require 'positioned'
require 'chipmunk'

class Chain

  CHAIN_COLLISION_GROUP = 1

  include Positioned

  def initialize(nodes_count, space)
    @space = space
    @segments = []
    body = CP::Body.new(10.0, 150.0)
    space.add_body(body)
    last = nil

    nodes_count.times do |i|
      x = i * 10
      thickness = 1.0
      current = CP::Vect2.new(x,20 * Math::sin(x*0.01))

      if last
        shape = CP::Shape::Segment.new(body, last, current, thickness)
        shape.group = CHAIN_COLLISION_GROUP
        space.add_static_shape(shape)
        @segments << shape
      end

      last = current
    end
  end


  def draw(window)
    @segments.each do |seg|
      qsize = 3

      a = @space.static_shape_point_query(seg)
      #b = @space.shape_point_query(seg)

      window.draw_track(a.x, a.y, to.x, to.y, Gosu::red)
      window.draw_track_quad(a.x - qsize, a.y - qsize,  Gosu::red,
                             a.x - qsize, a.y + qsize,  Gosu::red,
                             a.x + qsize, a.y + qsize,  Gosu::red,
                             a.x + qsize, a.y - qsize,  Gosu::red)
      
    end
  end




end
