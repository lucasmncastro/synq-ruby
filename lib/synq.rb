module Synq
  def self.api_key
    api_key = ENV['SYNQ_API_KEY']
    raise "Please, set SYNQ_API_KEY environment variable." unless api_key

    api_key
  end
end

require 'synq/resources/video'
require 'synq/parser'
require 'synq/api'
