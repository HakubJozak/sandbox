module Drawable

  def draw(canvas)
    each do |o|
      o.draw(canvas)
    end
  end
end
