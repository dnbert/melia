#!/usr/bin/env ruby

require 'yaml'

class Configuration
  def initialize()
  end
 
  def loadConfig(path)
    config = YAML.load_file(path)
    return config
  end
end
