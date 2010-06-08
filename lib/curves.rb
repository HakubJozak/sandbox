
class Space < CP::Space
  include Singleton

  def initialize
    super
    self.gravity = GRAVITY
  end
end


class DrawableComposite < Array
  def draw(canvas)
    each do |o|
      o.draw(canvas)
    end
  end
end



class CurveGame < Gosu::Window
  include Singleton
  
  attr_reader :track

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Curve"
    
    # Game objects
    @track = Track.new
    @mouse = Mouse.new(self, self)

    @balls = DrawableComposite.new
    @balls << Ball.new(200,100,self) << Ball.new(380,100,self)

    @game_objects = DrawableComposite.new
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
    @game_objects.draw(self)
  end

  def toggle_pause
    @running = !@running
  end

  def button_down(id)
    case id
    when Gosu::KbEscape then close      
    when Gosu::MsLeft then @mouse.left_click
    when Gosu::MsRight then @mouse.right_click
    when Gosu::MsMiddle then @mouse.middle_click
    when Gosu::KbSpace then toggle_pause
    when Gosu::KbReturn then reset_balls
    when Gosu::KbF1 then save('track.yml')
    when Gosu::KbF2 then load('track.yml')
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

  def line(x,y,x2,y2,color)
    offset_x = 0 # width / 2
    offset_y = 0 # height / 2
    draw_line(offset_x + x , offset_y + y, color, offset_x + x2, offset_y + y2, color)
  end

  def save(filename)
    f = File.new(filename, 'w')
    f << YAML::dump(@track)
    f.close
  end

  def load(filename)
    @track.delete
    @game_objects.delete(@track)
    @track = YAML::load(File.new(filename))
    @game_objects << @track
  end


end






