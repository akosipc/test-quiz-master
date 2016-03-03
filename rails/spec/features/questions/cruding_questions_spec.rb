require "rails_helper"

RSpec.describe "CRUD for Questions", type: :feature do

  scenario "Creating a new question" do
    visit root_path

    within ".well" do
      expect(page).to have_content "here are no questions as of this time. You can create question by click on the `Add a new question` button below."
    end

    click_link "Add a new question" 

    within ".new_question" do
      fill_in "question_question", with: "What is the circumference of the sun?"
      fill_in "question_answer", with: "2,713,406 miles"
      click_button "Create Question"
    end

    within ".alert" do
      expect(page).to have_content "Question created successfully."
    end

    within ".well" do
      expect(page).to have_content "What is the circumference of the sun?"
    end
  end

  scenario "Creating a new question with errors" do
    visit new_question_path

    within ".new_question" do
      fill_in "question_question", with: "What is the circumference of the sun?"
      click_button "Create Question"
    end

    within ".alert" do
      expect(page).to have_content "Answer can't be blank"
    end
  end

  scenario "Editing a existing question" do
    create :question
    visit root_path

    click_link "edit" 

    within ".edit_question" do
      fill_in "question_question", with: "What is the circumference of the earth?"
      fill_in "question_answer", with: "24,901 miles"
      click_button "Update Question"
    end

    within ".alert" do
      expect(page).to have_content "Question updated successfully."
    end

    within ".well" do
      expect(page).to have_content "What is the circumference of the earth?"
    end
  end

  scenario "Deleting a existing question" do
    create :question
    visit root_path

    click_link "delete" 

    within ".alert-success" do
      expect(page).to have_content "Question deleted successfully."
    end

    within ".well" do
      expect(page).to have_no_content "What is the circumference of the sun?"
    end
  end
end
