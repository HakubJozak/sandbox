require 'monitor'

class Editor::Window < Gtk::Window

  include MonitorMixin
  
  def initialize(toolbox, display)
    super()
    signal_connect('delete_event') { false }
    signal_connect('destroy') { Gtk.main_quit }

    title = "Chipmunk Sandbox - Toolbox"

    @layout = Gtk::VBox.new(false,5)
    add(@layout)
    
    @layout.add(toolbox)
    @layout.add(Gtk::HSeparator.new)
    @layout.add(display)
  end


end
