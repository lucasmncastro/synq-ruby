require 'minitest/autorun'

require 'synq'

module SpecHelper
  def fake_response(body, status)
    OpenStruct.new(body: body.to_json, code: status)
  end
end
