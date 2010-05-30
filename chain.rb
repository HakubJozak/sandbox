require 'node'
require 'positioned'

class Chain

  include Positioned

  def initialize(nodes_count)
    @nodes = []

    nodes_count.times do |i|
      x = i * 10
      @nodes << Node.new(x,20 * Math::sin(x))
    end
  end

  def draw(window)
    last = @nodes.first
    @nodes[1..-1].each do |current|
      window.draw_track(last.x, last.y, current.x, current.y, Gosu::red)
      window.draw_quad(last.x, last.y, current.x, current.y, Gosu::red)
      last = current
    end
  end

end
