# TODO - DRY by +define_method+
module Container
  
  def draw(canvas)
    @widgets.each { |w| w.draw(canvas) }
  end

  def click
    @widgets.each { |w| w.click }
  end

  def contains?(x,y)
    @widgets.any? { |w| w.contains?(x,y) }
  end

  def button_down(key)
    @widgets.each { |w| w.button_down(key) }
  end

  def button_up(key)
    @widgets.each { |w| w.button_up(key) }
  end
  
end
