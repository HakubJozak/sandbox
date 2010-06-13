require 'chipmunk'
require 'yaml'
require 'yaml_serializer'

class CP::Vec2
  yaml_mapping 'vec2', :x, :y

  YAML::add_domain_type( YAML_DOMAIN, "vec2" ) do |type, val|
    CP::Vec2.new( val['x'].to_f, val['y'].to_f )
  end
end


# TODO - tranform to test
# p( YAML.dump(CP::Vec2.new(1,2)))
# p YAML::load( YAML.dump(CP::Vec2.new(1,2)) )

