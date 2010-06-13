
class CurveGame < Gosu::Window
  include Singleton
  
  attr_reader :track

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Curve"
    
    # Game objects
    @mouse = Mouse.new(self, self)
    @info = DebugInfo.new(self)
    @track = Track.new #load('track.yml')
    @world = World.new
    @world << @mouse << @track << @Seesaw.new(320, 280, self)

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
    @info.text = ''
    @info << "Balls: #{@balls.size}"
    @info << "Mouse x: #{@mouse.x} y:#{@mouse.y}"
    @info.draw(self)
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
    when Gosu::KbReturn then @world.reset
    when Gosu::KbF1 then save('track.yml')
    when Gosu::KbF2 then load('track.yml')
    when Gosu::KbF3 then reset_track
    end
  end

  def add_ball(x,y)
    # @balls << Ball.new(x,y,self)
    @balls << Seesaw.new(x,y,self)
  end


  def save(filename)
    f = File.new(filename, 'w')
    f << YAML::dump(@track)
    f.close
  end

  def load(filename)
    reset_track
    @track = YAML::load(File.new(filename)) rescue Track.new
    @world << @track
  end


  # Drawing
  # TODO - move
  def line(x,y,x2,y2,color,z = 0)
    offset_x = 0 # width / 2
    offset_y = 0 # height / 2
    draw_line(offset_x + x , offset_y + y, color, offset_x + x2, offset_y + y2, color, z)
  end

  def filled_rectangle(x,y,width,height,color,alpha = 1.0, z = 0)
    draw_quad(x,y, color, 
              x + width, y, color,
              x, y + height, color,
              x + width, y + height, color,
              z)

  end



end






