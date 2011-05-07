module Editor
  class Adjuster < Gtk::VBox

    attr_accessor :tool

    def initialize
      super
      @label = Gtk::Label.new('None')
      pack_start(@label)
    end

    def label=(str)
      @label.text = str
    end

  end
end
