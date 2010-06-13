require 'drawable'

class World
  include 'drawable'

  def initialize
    @objects = []
  end
  
  def each(*args)
    @objects.each(args)    
  end

  def reset_track
    if @track
      @track.delete
      @world.delete(@track)
    end
  end

  def delete_all
    @balls.each do |ball|
      ball.delete
    end

    @balls.clear
  end


end
