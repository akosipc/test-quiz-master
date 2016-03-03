require "rails_helper"

RSpec.describe "Answering Questions", type: :feature do
  let!(:question) { create :question }

  before do
    visit root_path

    within ".well" do
      click_link question.question
    end
  end

  scenario "Answering the Question correctly" do

    within "form" do
      fill_in "answer_answer", with: "2,713,406 miles"
      click_button "Submit answer"
    end

    within ".alert-success" do
      expect(page).to have_content "You got the correct answer!"
    end

    within ".well" do
      expect(page).to have_no_content "What is the circumference of the sun?"
    end
  end

  scenario "Answering the Question correctly" do
    within "form" do
      fill_in "answer_answer", with: "2,713,xxx miles"
      click_button "Submit answer"
    end

    within ".alert-danger" do
      expect(page).to have_content "Sorry, but that's the wrong answer. Please try again."
    end

    within ".well" do
      expect(page).to have_content "What is the circumference of the sun?"
    end
  end
end
