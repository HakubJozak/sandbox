class Mouse

  attr_accessor :world, :window
  
  def initialize(window, world)
    @window, @world = window, world
    @last_click = nil
    @mouse_image = Gosu::Image.new(window, "images/mouse.png", false)
    @info = DebugInfo.new(window)
  end

  def x() @window.mouse_x end
  def y() @window.mouse_y end

  def draw(canvas)
    canvas.line( @last_click.x, @last_click.y, x, y , Gosu::red) if @last_click
    size = @mouse_image.width / 2
    @mouse_image.draw(x - size, y - size, Z_MOUSE)

    @info.reset
    @info << @world.info
    @info.draw(canvas)
  end

  def left_click
    build_point(x, y)
  end

  def right_click
    reset_builder
  end

  def middle_click
    @world << Seesaw.new(x,y,self)
  end

  private

  def build_point(x,y)
    if @last_click
      current = CP::Vec2.new(x,y)
      @world.track << Stick.new(@last_click, current)
      @last_click = current
    else
      @last_click = CP::Vec2.new(x,y)
    end
  end

  def reset_builder
    @last_click = nil
  end


end
