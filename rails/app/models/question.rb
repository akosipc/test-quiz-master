class Question < ActiveRecord::Base

  validates :question, :answer, presence: true

  scope :unanswered, -> { where(answered: false) }

  def is_correct?(submission)
    sanitize(answer) == sanitize(submission)
  end

  def answered!
    update_attributes(answered: true)
  end

private

  def sanitize(text)
    convert_number_to_words text.gsub(/\s+/, " ").strip.downcase
  end

  def convert_number_to_words(text)
    has_exclusive_numbers_only?(text) ? 
      text.to_i.humanize :
      text
  end

  def has_exclusive_numbers_only?(text)
    (text =~ /^\d*[^a-zA-Z]$/).present?
  end

end
