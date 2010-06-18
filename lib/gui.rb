class Gui
  def initialize
    @widgets = []
  end

  def add_widget(w)
    @widgets << w
    self
  end

  def draw(canvas)
    @widgets.each do |w|
      w.draw(canvas)
    end
  end

  # <code>x,y</code> - coordinates of the click
  # <code>key</code> is Gosu input code
  #
  # returns true if the event was handled, false otherwise
  def button_down(mouse,key)
    if key == Gosu::MsLeft
      @pressed = @widgets.find { |w| w.contains?(mouse.x,mouse.y) }

      if @pressed
        p '!!!'
        @pressed.button_down(key)
        return true
      end
    end

    return false    
  end

  def button_up(mouse,id)
    if @pressed and @pressed.contains?(mouse.x,mouse.y)
      @pressed.click
      @pressed = nil
    end
  end

end
