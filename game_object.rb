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
