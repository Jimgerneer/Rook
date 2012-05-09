require 'spec_helper'

require_relative '../lib/course'

describe Rook::Course do
  def subject
    attrs = {
      title: 'This Course',
      description: 'This course is a discourse' }

    Rook::Opportunity.new(attrs)
  end

  it "has an id" do
    subject.must_respond_to :id
  end

  it "has a title" do
    subject.title.must_equal 'This Course'
  end

  it "has a description" do
    subject.description.must_equal 'This course is a discourse'
  end
end
