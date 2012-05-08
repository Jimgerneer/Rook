require 'spec_helper'

require_relative '../rook'

def app()
  Sinatra::Application
end

describe Rook do
#  it "should run" do
#    get '/opportunities'
#    assert_equal '[{title: "Hey Learn", skills: "Ruby", description: "you bastard"}]',
#      last_response.body
#  end
end

describe Rook::Course do
  def subject
    attrs = {
      title: 'This Course',
      description: 'This course includes loads of opportunity sessions' }

    Rook::Course.new(attrs)
  end

  it 'has an id' do
    subject.must_respond_to :id
  end

  it 'has a title' do
    subject.title.must_equal 'This Course'
  end

  it 'has a description' do
    subject.description.must_equal 'This course includes loads of opportunity sessions'
  end
end



