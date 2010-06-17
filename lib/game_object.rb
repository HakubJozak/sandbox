class GameObject

  def info
    [ "Class: #{self.class.to_s}",
      "Pos#{body.p}",
      "Angle:#{body.a.radians_to_gosu}",
      "Velocity:#{body.v}"
    ]
  end

  def body
    @body
  end

  def shape
    @shape
  end
  
end
