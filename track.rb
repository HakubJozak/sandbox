require "yaml"

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

  def save(filename)
    f = File.new(filename, 'w')
    f << YAML::dump(@parts)
    f.close
  end

  def load(file)
  end
  
end
