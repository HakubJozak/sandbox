#!/usr/bin/env ruby

require 'rubygems'
require 'chipmunk'
require 'gosu'
require 'singleton'

$: << File.join(File.dirname(__FILE__), "/lib")

require 'game_object'

Dir['lib/*.rb'].each do |file|
  require file
  puts "Loaded #{file}"
end

CurveGame.instance.show

#p YAML::load(CP::Vec2.new(2,1).to_yaml)
#p YAML::load(Track.new([Stick.new(CP::Vec2.new(0,1), CP::Vec2.new(2,1))]).to_yaml )

