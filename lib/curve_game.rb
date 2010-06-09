
class CurveGame < Gosu::Window
  include Singleton
  
  attr_reader :track

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Curve"
    
    # Game objects
    @mouse = Mouse.new(self, self)
    @balls = DrawableComposite.new
    @balls << Ball.new(200,100,self) << Ball.new(380,100,self)
    @info = DebugInfo.new(self)

    @game_objects = DrawableComposite.new
    load('track.yml')
    @game_objects << @mouse << @track << @balls

    # Game utilities
    @running = false

    # Physics
    @dt = (1.0/60.0)
  end

  def update
    # true if button_down? Gosu::KbUp
    Space.instance.step(@dt) if @running
  end

  def draw
    filled_rectangle(0,0, SCREEN_WIDTH, SCREEN_HEIGHT, Gosu::white)
    @game_objects.draw(self)
    @info.text = "Balls: #{@balls.size}"
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
    when Gosu::KbReturn then reset_balls
    when Gosu::KbF1 then save('track.yml')
    when Gosu::KbF2 then load('track.yml')
    when Gosu::KbF3 then reset_track
    end
  end

  def add_ball(x,y)
    @balls << Ball.new(x,y,self)    
  end

  def reset_balls
    @balls.each do |ball|
      ball.delete
    end

    @balls.clear
  end

  def save(filename)
    f = File.new(filename, 'w')
    f << YAML::dump(@track)
    f.close
  end

  def reset_track
    if @track
      @track.delete
      @game_objects.delete(@track)
    end
  end

  def load(filename)
    reset_track
    @track = YAML::load(File.new(filename)) rescue Track.new
    @game_objects << @track
  end


  # Drawing
  # TODO - move
  def line(x,y,x2,y2,color)
    offset_x = 0 # width / 2
    offset_y = 0 # height / 2
    draw_line(offset_x + x , offset_y + y, color, offset_x + x2, offset_y + y2, color)
  end

  def filled_rectangle(x,y,width,height,color,alpha = 1.0)
    draw_quad(x,y, color, 
              x + width, y, color,
              x, y + height, color,
              x + width, y + height, color)

  end



end






