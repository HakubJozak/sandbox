require "yaml"

class Track

  yaml_mapping 'track', :parts

  def initialize(parts = [])
    @parts = parts
  end

  def <<(part)
    @parts << part if part
  end

  def delete
    @parts.each { |p| p.delete }
  end

  def draw(canvas)
    @parts.each do |part|
      part.draw(canvas)
    end
  end

  private

  def parts
    @parts
  end
  
end


YAML::add_domain_type( YAML_DOMAIN, "track" ) do |type, val|
  Track.new(val['parts'])
end

