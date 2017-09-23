module Synq::Parser
  include Synq::Resources

  def parse(response)
    JSON.parse(response.body, object_class: Video) 
  end
end
