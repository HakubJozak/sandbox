class Editor::ToolButton < Gtk::ToggleButton

  def initialize(clazz)
    super(clazz.to_s)
    #signal_connect("clicked") { self.destroy }
  end
  

end
