#!/usr/bin/env ruby

require 'singleton'
require 'rubygems'
require 'bundler'
require 'chipmunk'
require 'gosu'



$: << File.join(File.dirname(__FILE__), "/lib")


Dir['lib/*.rb'].each do |file|
  require File.basename(file)
  puts "Loaded #{file}"
end

CurveGame.instance.show

#p YAML::load(CP::Vec2.new(2,1).to_yaml)
#p YAML::load(Track.new([Stick.new(CP::Vec2.new(0,1), CP::Vec2.new(2,1))]).to_yaml )

