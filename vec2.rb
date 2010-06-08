require 'chipmunk'
require 'yaml'

YAML_DOMAIN = "jakub.hozak,2010"

class CP::Vec2

  def to_yaml(opts = {})
    YAML.quick_emit( self.object_id, opts ) do |out|
      out.map( taguri, nil ) do |map|
        map.add('x',self.x)
        map.add('y',self.y)
      end
    end
  end

  def to_yaml_type
    "!#{YAML_DOMAIN}/vec2"
  end

end

YAML::add_domain_type( YAML_DOMAIN, "vec2" ) do |type, val|
  CP::Vec2.new( val['x'].to_f, val['y'].to_f )
end

# TODO - tranform to test
# p( YAML.dump(CP::Vec2.new(1,2)))
# p YAML::load( YAML.dump(CP::Vec2.new(1,2)) )

