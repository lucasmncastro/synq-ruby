require './spec/spec_helper'

describe Synq::Api do

  include SpecHelper

  def setup
    ENV['SYNQ_API_KEY'] = 'abc'
  end

  it ".build_url should point to API's base url" do
    assert_equal "/v1/video/create", Synq::Api.build_url(:create)
  end

  it ".synq_body should merge the request params with api key" do
    metadata = '{"title": "Hello"}'
    expected = {api_key: 'abc', metadata: metadata}
    assert_equal expected, Synq::Api.synq_body(metadata: metadata)
  end

  it ".create should handle request correctly" do
    response = fake_response({ video_id: '10' }, 201)

    Synq::Api.stub :post, response do
      video = Synq::Resources::Video.new(video_id: '10')
      assert_equal video, Synq::Api.create
    end
  end

  it ".query should handle request correctly" do
    response = fake_response(
      [
        {
          "state": "created",
          "userdata": {},
          "video_id": "10",
          "created_at": "2017-09-20T00:32:13.076Z",
          "updated_at": "2017-09-20T00:32:13.076Z"
        },
        {
          "state": "created",
          "userdata": {},
          "video_id": "20",
          "created_at": "2017-09-20T23:56:23.910Z",
          "updated_at": "2017-09-20T23:56:23.910Z"
        },
      ],
      200
    )

    Synq::Api.stub :post, response do
      videos = Synq::Api.query('10')
      assert videos.is_a?(Array)
      assert_equal '10', videos.first.video_id
    end
  end

  it ".details should handle request correctly" do
    response = fake_response(
      {
        "state": "created",
        "userdata": {},
        "video_id": "10",
        "created_at": "2017-09-20T00:32:13.076Z",
        "updated_at": "2017-09-20T00:32:13.076Z"
      },
      200
    )

    Synq::Api.stub :post, response do
      video = Synq::Api.details('10')
      assert_equal 'created', video.state
      assert_equal '10', video.video_id
    end
  end

  it ".update should handle request correctly" do
    response = fake_response(
      {
        "state": "created",
        "userdata": { title: 'Welcome to SYNQ!' },
        "video_id": "10",
        "created_at": "2017-09-20T00:32:13.076Z",
        "updated_at": "2017-09-20T00:32:13.076Z"
      },
      200
    )

    Synq::Api.stub :post, response do
      video = Synq::Api.update('10', "video.userdata.title = 'Welcome to SYNQ!'")
      assert_equal 'Welcome to SYNQ!', video.userdata.title
    end
  end

  it ".upload should handle request correctly" do
    response = fake_response(
      {
        "action": "https://synqfm.s3.amazonaws.com/",
        "AWSAccessKeyId": "<keyId>",
        "Content-Type": "video/mp4",
        "Policy":   "<longPolicy>",
        "Signature": "<theSugnature>",
        "acl": "public-read",
        "key": "<videoKey>"
      },
      200
    )

    Synq::Api.stub :post, response do
      response = Synq::Api.upload('10')
      assert_equal '<longPolicy>', response['Policy']
    end
  end

  it ".stream should handle request correctly" do
    response = fake_response(
      {
        "stream_url": "<streamUrl>",
        "playback_url": "<playbackUrl>"
      },
      200
    )

    Synq::Api.stub :post, response do
      response = Synq::Api.stream('10')
      assert_equal '<streamUrl>',   response.stream_url
      assert_equal '<playbackUrl>', response.playback_url
    end
  end

end
