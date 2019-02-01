
require 'test_helper'

class NumberToWordTest < ActiveSupport::TestCase
  test "should retrun words" do
    assert_equal(7, NumberToWord.new.letter_combinations("6686787825").length)
    assert_equal(8, NumberToWord.new.letter_combinations("2282668687").length)
  end
end