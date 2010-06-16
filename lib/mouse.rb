class Mouse

  attr_reader :world
  attr_accessor :selection_listener
  
  def initialize(window, world)
    @window, @world = window, world
    @mouse_image = Gosu::Image.new(window, "images/mouse.png", false)
    @last_click = nil
  end

  def x() @window.mouse_x end
  def y() @window.mouse_y end

  def points_on
    Space.instance.shape_point_query(CP::Vec2.new(x,y)) do |shape|
      return shape.obj
    end
  end
  
  def draw(canvas)
    if @is_over
      box = @is_over.bb
      c = Gosu::red
      @window.draw_quad( box.l, box.t, c,
                         box.r, box.t, c,
                         box.l, box.b, c,
                         box.r, box.b, c,
                         Z_GAME_OBJECTS)
    end
    
    canvas.line( @last_click.x, @last_click.y, x, y , Gosu::red) if @last_click
    size = @mouse_image.width / 2
    @mouse_image.draw(x - size, y - size, Z_MOUSE)
  end

  def left_click
    if @selected = points_on
      @selection_listener.object_selected(@selected) if @selection_listener
    else
      build_point(x, y)
    end
  end

  def right_click
    reset_builder
  end

  def middle_click
    #    @world << Seesaw.new(x,y,@window)
    @world << Ball.new(x,y,@window)
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
