require "rails_helper"

describe Question, type: :model do
  describe "is_correct?" do
    it "requires the correct answer" do
      expect(Question.new(answer: "Paris").is_correct?("London")).to be false
      expect(Question.new(answer: "Paris").is_correct?("Paris")).to be true
    end

    it "ignores whitespace" do
      expect(Question.new(answer: "  the  moon").is_correct?("the moon")).to be true
    end

    it "ignores case" do
      expect(Question.new(answer: "France").is_correct?("france")).to be true
    end

    it "understands numbers as words" do
      expect(Question.new(answer: "7").is_correct?("seven")).to be true
      expect(Question.new(answer: "seven").is_correct?("7")).to be true
    end
  end
end
