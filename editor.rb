#!/usr/bin/env ruby

require 'singleton'
require 'rubygems'
require 'bundler'
Bundler.require

require 'gtk2'
require_all './lib/**/*.rb'



toolbox = Editor::Toolbox.new(3)
toolbox << Editor::ToolButton.new(Ball)
toolbox << Editor::ToolButton.new(Seesaw)

adjuster = Editor::Adjuster.new


editor = Editor::Window.new(toolbox,adjuster)
editor.show_all

Thread.new do
  Sandbox.instance.show
end

Gtk.main

