require 'drawable'

class World
  attr_reader :track
  
  def initialize(track = nil)
    @objects = []
    @track = track || Track.new
  end
  
  # Add game object to the world.
  def << (obj)
    @objects << obj if obj
  end

  def draw(canvas)
    @objects.each { |o| o.draw(canvas) }
  end

  def info
    "Objects: #{@objects.count}\n" +
    "Track: #{@track}\n"
  end
  
  # Remove all game objects
  def delete_all
    @objects.each do |o|
      o.delete     
    end

    @objects.clear
  end

  def delete_track
    @track.delete
    @track = Track.new
  end
  
  def save_track(filename)
    f = File.new(filename, 'w')
    f << YAML::dump(@track)
    f.close
  end

  def load_track(filename)
    delete_track
    @track = YAML::load(File.new(filename)) rescue Track.new
    @world << @track
  end
  


end
