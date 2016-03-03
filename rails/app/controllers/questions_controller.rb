class QuestionsController < ApplicationController
  before_filter :find_question, only: [:show, :edit, :update, :destroy, :answer]

  def index
    @questions = Question.unanswered
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      redirect_to root_path, notice: "Question created successfully."
    else
      render :new
    end
  end

  def update
    if @question.update_attributes question_params
      redirect_to root_path, notice: "Question updated successfully."
    else
      render :edit
    end
  end

  def answer
    if @question.is_correct?(answer_params[:answer])
      @question.answered!
      redirect_to root_path, notice: "You got the correct answer!"
    else
      flash[:error] = "Sorry, but that's the wrong answer. Please try again."
      render :show
    end
  end

  def destroy
    @question.destroy

    redirect_to root_path, notice: "Question deleted successfully."
  end

private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question, :answer)
  end

  def answer_params
    params.require(:answer).permit(:answer)
  end
end
