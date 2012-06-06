require_relative '../spec_helper'
require_relative '../../models/opportunity'

describe Opportunity do
  def subject
    attrs = {
      title: 'Some Title',
      skills: 'Ruby, Javascript, Perl, ActionScript',
      description: 'To hell and back again, a short story' }

    Opportunity.new(attrs)
  end

  it "has an id" do
    subject.must_respond_to :id
  end

  it "has a title" do
    subject.title.must_equal 'Some Title'
  end

  it "has skills" do
    subject.skills.must_equal 'Ruby, Javascript, Perl, ActionScript'
  end

  it "has a description" do
    subject.description.must_equal 'To hell and back again, a short story'
  end
end
