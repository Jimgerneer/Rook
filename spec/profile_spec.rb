require_relative './spec_helper'

require_relative '../lib/profile'

describe Rook::Profile do
  def subject
    attrs = {
      first_name: 'Joe',
      last_name: 'Eats',
      city: 'Denver',
      timezone: 'MST'}

    Rook::Profile.new(attrs)
  end

  it 'has an id' do
    subject.must_respond_to :id
  end

  it 'has a first name' do
    subject.first_name.must_equal 'Joe'
  end

  it 'has a last name' do
    subject.last_name.must_equal 'Eats'
  end

  it 'has a city' do
    subject.city.must_equal 'Denver'
  end

  it 'has a timezone' do
    subject.timezone.must_equal 'MST'
  end
end
