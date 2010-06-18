require 'widget'
require 'container'

class PlusMinus < Widget

  attr_accessor :amount
  
  include Container
  
  def initialize(window,x,y,target, property)
    super(window, x, y)
    @target = target
    @amount = 0.1

    minus = Button.new(window, x, y, '-') { @target.send("#{property.to_s}-", @amount) }
    plus = Button.new(window, x + 20, y, '+') { @target.send("#{property.to_s}+", @amount) }

    @widgets = [ plus, minus ]

    @widgets.each do |button|
      button.set_images(:square)
      button.scale = 0.4
    end

  end
end
