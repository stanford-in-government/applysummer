class Recommendation < ActiveRecord::Base
  belongs_to :application
  validates :email, :name, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validate :letter_or_text_present


  has_attached_file :letter
  validates_attachment_content_type :letter, content_type: ['application/pdf']
  validates_attachment_size :letter, less_than: 3.megabyte

  private

  def letter_or_text_present
    if !self.letter? && self.text.blank?
      errors[:text] << ("Please either upload a file or paste the letter's content into the text box.")
      errors[:letter] << ("Please either upload a file or paste the letter's content into the text box.")
    end
  end
end
