module Editor
  class Toolbox < Gtk::VButtonBox

    def initialize(w)
      super()
      @w = w
      new_row
    end

    def <<(button)
      new_row if @rows.children.size == @w
      @rows.pack_start(button)
    end

    protected

    def new_row
      @rows = Gtk::HButtonBox.new
      @rows.layout_style = Gtk::HButtonBox::START
      pack_start(@rows)
    end

  end
end
