require "rails_helper"

describe Question, type: :model do

  let!(:question) { create :question }
  
  describe ".unanswered" do
    it "returns an array of unanswered questions" do
      expect(Question.unanswered).to include question
    end
  end

  describe "#answered!" do
    it "change the status to the question to answered" do
      question.answered!

      expect(question.reload.answered?).to be_truthy
    end
  end

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
