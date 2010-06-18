require './test/test_helper'

class ButtonTest <  MiniTest::Unit::TestCase
  
  def setup
    @window = Gosu::Window.new(10,10,false)
    @button = Button.new(@window, 1,1, 'Label') { @clicked = true }
  end
   
  def test_dimensions
    assert_equal 1, @button.x
    assert_equal 1, @button.y
    assert_equal 170, @button.w
    assert_equal 40, @button.h
   end
  
  def test_click
    @button.click
    assert @clicked, "Button not registering clicks!"
  end

  def test_button_toggle
  end
  
end
