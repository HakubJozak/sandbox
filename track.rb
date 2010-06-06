class Track

  def initialize
    @parts = []
  end

  def <<(part)
    @parts << part if part
  end

  def draw(canvas)
    @parts.each do |part|
      part.draw(canvas)
    end
  end

  def save(file)
  end

  def load(file)
  end
  
end
