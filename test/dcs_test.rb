require "test_helper"

class DcsTest < Minitest::Test
  def test_good_examples
    Dir[Dir.pwd + "/test/good_examples/*"].each do |f|
      guess = Dcs.solve(f)
      answer = File.basename(f, ".png")
      assert_equal answer, guess
    end
  end

  def test_bad_examples
    Dir[Dir.pwd + "/test/bad_examples/*"].each do |f|
      guess = Dcs.solve(f)
      answer = File.basename(f, ".png")
      refute_equal answer, guess
    end
  end
end
