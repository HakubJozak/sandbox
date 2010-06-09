class Space < CP::Space
  include Singleton

  def initialize
    super
    self.gravity = GRAVITY
    self.elastic_iterations = 1

  end
end
