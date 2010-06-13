require 'constants'

class Object

  def self.yaml_mapping(name, *attrs)
    raise 'Type name missing' unless name

    self.send(:define_method, :attrs_to_serialize) do
      attrs
    end
    
    self.send(:define_method, :to_yaml_type) do
      "!#{YAML_DOMAIN}/#{name}"
    end
    
    self.send(:include, YAMLSerializer)
  end

end

module YAMLSerializer

  def to_yaml(opts = {})
    YAML.quick_emit( self.object_id, opts ) do |out|
      out.map( taguri, nil ) do |map|
        attrs_to_serialize.each do |attr|
          map.add( attr.to_s, self.send(attr))
        end
      end
    end
  end

end
