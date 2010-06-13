class Seesaw
  
  def initialize(x,y, canvas)
    @board_image = Gosu::Image.new(canvas, 'images/seesaw_board.png', false)
    w = @board_image.width * 0.5
    h = @board_image.height * 0.5

    @board = CP::Body.new(20, 20)
    @board.p.x = x
    @board.p.y = y
    @board_shape = CP::Shape::Poly.new( @board, 
                                        [ CP::Vec2.new(-w, h), 
                                        CP::Vec2.new( w, h),
                                        CP::Vec2.new( w, -h),
                                        CP::Vec2.new( -w, -h) ],
                                        CP::Vec2.new(0,0))   

    Space.instance.add_body(@board)
    Space.instance.add_shape(@board_shape)

    # @pivot = CP::Body.new(1.0 / 0.0, 1.0 / 0.0)    
    # @pivot_shape = CP::Shape::Circle.new(@pivot, Vec2.new(0,0), 5)
    # @joint = CP::PivotJoint(@pivot, @board, Vec2.new(x,y))
  end

  def draw(canvas)
    @board_image.draw_rot(@board.p.x, @board.p.y, Z_GAME_OBJECTS, (@board.a + Math::PI/2).radians_to_gosu)
  end

  def delete
  end
end
