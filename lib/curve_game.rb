class CurveGame < Gosu::Window
  include Singleton
  
  attr_reader :track

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Chipmunk Sandbox"
    
    @world = World.new
    @mouse = Mouse.new(self, @world)
    @world << Seesaw.new(320, 280, self)
    
    # Game utilities
    @running = false
  end

  def update
    # true if button_down? Gosu::KbUp
    PHYSICS_ITERATION.times { Space.instance.step(DT) } if @running
  end

  def draw
    filled_rectangle(0,0, SCREEN_WIDTH, SCREEN_HEIGHT, Gosu::white, Z_BACKGROUND)
   
    @world.draw(self)
    @mouse.draw(self)
  end

  def toggle_pause
    @running = !@running
  end

  def button_down(key)
    case key
    when Gosu::KbEscape then close      
    when Gosu::MsLeft then @mouse.left_click
    when Gosu::MsRight then @mouse.right_click
    when Gosu::MsMiddle then @mouse.middle_click
    when Gosu::KbSpace then toggle_pause
    when Gosu::KbReturn then @world.delete_objects
    when Gosu::KbF1 then @world.save_track('track.yml')
    when Gosu::KbF2 then @world.load_track('track.yml')
    when Gosu::KbF3 then @world.delete_track
    end
  end


  # Drawing
  # TODO - move
  def line(x,y,x2,y2,color,z = 0)
    offset_x = 0 # width / 2
    offset_y = 0 # height / 2
    draw_line(offset_x + x , offset_y + y, color, offset_x + x2, offset_y + y2, color, z)
  end

  def filled_rectangle(x,y,width,height,color, z)
    draw_quad(x,y, color, 
              x + width, y, color,
              x, y + height, color,
              x + width, y + height, color, z)

  end



end






