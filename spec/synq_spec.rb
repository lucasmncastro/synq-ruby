require './spec/spec_helper'

describe Synq do

  it "#api_key shoul get env var value" do
    ENV['SYNQ_API_KEY'] = 'abc'
    assert_equal 'abc', Synq.api_key
  end

  it "#api_keu should raise an exception if the env var isn't set" do
    ENV['SYNQ_API_KEY'] = nil
    assert_raises do
      Synq.api_key
    end
  end

end
