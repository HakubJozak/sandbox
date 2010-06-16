class GameObject

  def info
    [ "Class: #{self.class.to_s}",
      "Pos#{body.p}",
      "Angle:#{body.a}",
      "Velocity:#{body.v}"
    ]
  end

  def body
    @body
  end
  
end
