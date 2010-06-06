require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'singleton'
require './game_object'
require './stick'
require './track'
require './mouse'




SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480

GRAVITY = CP::Vec2.new(0,9.8)
NULL_VECTOR = CP::Vec2.new(0.0, 0.0)


class Space < CP::Space
  include Singleton

  def initialize
    super
    self.gravity = CP::Vec2.new(0,90)
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

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Curve"
    
    # Game objects
    @track = Track.new
    @mouse = Mouse.new(self, @track)

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

end

window = CurveGame.instance.show





