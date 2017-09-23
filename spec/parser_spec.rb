require './spec/spec_helper'

describe Synq::Parser do
  include SpecHelper

  include Synq::Parser

  it ".parse should convert simple string response into a Video object" do
    response = fake_response(
      {
        "state": "created",
        "userdata": {},
        "video_id": "10",
        "created_at": "2017-03-07T12:03:34.477Z",
        "updated_at": "2017-03-07T12:03:34.477Z"
      },
      200
    )

    parsed_response = parse(response)
    assert_equal '10', parsed_response.video_id
    assert_equal 'created', parsed_response.state
    assert_equal Synq::Resources::Video, parsed_response.class
  end
end
