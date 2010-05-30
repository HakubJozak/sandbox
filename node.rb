require 'positioned'
require 'matrix'


class Node

  include Positioned

  def initialize(x,y)
    @position = Vector[x,y]
  end

end
