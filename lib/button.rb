require 'widget'

class Button < Widget

  attr_accessor :x, :y 
  attr_accessor :up_image, :down_image
  attr_accessor :scale
  
  
  def initialize(window, x, y, label, options = {}, &on_click)
    super(window, x, y)
    raise ArgumentError.new("On click block missing") unless on_click

    label, @on_click = label, on_click
    set_images
    
    # So that we can draw Strings the same way as Gosu::Image
    if String === label
      @label = Gosu::Image.from_text(window, label, Gosu::default_font_name, 16)
    else
      @label = label
    end

    @scale = 1.0
  end

  # shape can be :rectangle or :square
  def set_images(shape = :rectangle)
    @up_image = Gosu::Image.new(@window, "images/buttons/#{shape.to_s}_up.png")
    @down_image = Gosu::Image.new(@window, "images/buttons/#{shape.to_s}_down.png")    
  end

  def w() @up_image.width * @scale end
  def h() @up_image.height * @scale end
  
  
  def draw(canvas)
    offset_x = (w - @label.width) * 0.5
    offset_y = (h - @label.height) * 0.5

    if @pressed
      @down_image.draw(x,y,Z_GUI, @scale, @scale)
    else
      @up_image.draw(x,y,Z_GUI, @scale, @scale)
    end
    
    @label.draw(x + offset_x,y + offset_y,Z_GUI, 1.0, 1.0, Gosu::black)
  end


  def button_down(key)
    @pressed = true
  end

  def click
    @pressed = false
    @on_click.yield    
  end
  
end
