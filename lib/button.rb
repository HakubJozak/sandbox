class Button

  attr_reader :x, :y
  
  def initialize(window, x, y, label, options = {}, &on_click)
    raise ArgumentError.new("On click block missing") unless on_click

    @x, @y, @window, label, @on_click = x, y, window, label, on_click
    @up_image = Gosu::Image.new(window, "images/buttons/up.png")
    @down_image = Gosu::Image.new(window, "images/buttons/down.png")

    # So that we can draw Strings the same way as Gosu::Image
    if String === label
      @label = Gosu::Image.from_text(window, label, Gosu::default_font_name, 15)
    else
      @label = label
    end

    # @state = options[:toggle] ? ButtonToggleState.new : ButtonState.new
  end

  def w() @up_image.width end
  def h() @up_image.height end
  
  def draw(canvas)
    offset_x = (@up_image.width - @label.width) * 0.5
    offset_y = (@up_image.height - @label.height) * 0.5

    if @pressed
      @down_image.draw(x,y,Z_GUI)
    else
      @up_image.draw(x,y,Z_GUI)      
    end
    
    @label.draw(x + offset_x,y + offset_y,Z_GUI, 1.0, 1.0, Gosu::black)
  end

  def contains?(x2,y2)
    x2 >= x and y2 >= y and x + w >= x2 and y + h >= y2
  end

  def button_down(key)
    @pressed = true
  end

  def click
    @pressed = false
    @on_click.yield    
  end
  
end
