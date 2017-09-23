require 'httparty'

# API interface to communicate with Synq.fm API.
module Synq::Api
  extend Synq::Parser

  include HTTParty
  base_uri 'https://api.synq.fm'

  class << self
    def build_url(action)
      "/v1/video/#{action}"
    end

    def synq_body(options={})
      { api_key: Synq.api_key }.merge(options)
    end

    def synq_post(action, options={})
      url      = build_url(action)
      body     = synq_body(options)
      response = post(url, body: body)
      parse(response)
    end

    def create(metadata=nil)
      synq_post('create', metadata: metadata)
    end

    def query(filter)
      synq_post('query', filter: filter)
    end

    def details(video_id)
      synq_post('details', video_id: video_id)
    end

    def update(video_id, source)
      synq_post('update', video_id: video_id, source: source)
    end

    def upload(video_id)
      synq_post('upload', video_id: video_id)
    end

    def uploader(video_id, timeout=nil)
      synq_post('uploader', video_id: video_id, timeout: timeout)
    end

    def stream(video_id)
      synq_post('stream', video_id: video_id)
    end
  end
end
