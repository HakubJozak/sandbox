class CP::Body
  DUMMY = CP::Body.new( 1.0/0.0, 1.0/0.0).freeze
end


class Space < CP::Space
  include Singleton

  def initialize
    super
    self.gravity = GRAVITY
    self.elastic_iterations = 1
  end

  def info
    [ "Iterations: #{iterations}",
      "Elastic iterations: #{elastic_iterations}",
      "Damping: #{damping}",
      "Gravity: #{gravity}",
      # "-------",
      # "Bias coefficient: #{CP::bias_coef}",
      # "Collision slop: #{CP::collision_slop}"
    ]
  end
end
