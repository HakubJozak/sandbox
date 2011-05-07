#!/usr/bin/env ruby

require 'singleton'
require 'rubygems'
require 'bundler'
Bundler.require
require_all './lib/*.rb'
require_all './lib/objects/*.rb'





Sandbox.instance.show


