require_relative "../spec_helper"
require_relative "../../routes/routes_helper"

class RookeryHelpersTest
  include Rookery::Helpers

end

describe 'routes helpers' do

  before do
    @helper = RookeryHelpersTest.new
  end

  describe '#santize_input' do

    it 'sanitizes a simple hash' do
      data = {:name => '<script>alert("Hello there, this is script")</script>'}
      result = @helper.sanitize_input(data)
      expected = 'alert("Hello there, this is script")'
      assert_equal expected, result[:name]
    end

    it 'sanitizes a deeply nested hash' do
      data = {:level1 => { :level2 => {:name => '<script>alert("Hello there, this is script")</script>'}}}
      result = @helper.sanitize_input(data)
      expected = 'alert("Hello there, this is script")'
      assert_equal expected, result[:level1][:level2][:name]
    end

    it 'sanitizes a string' do
    end

  end
end
