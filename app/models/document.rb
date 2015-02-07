class Document < ActiveRecord::Base
  belongs_to :user
  CATEGORIES = [ :other, :transcript, :resume, :insurance]
  enum category: CATEGORIES

  has_attached_file :file
  validates_attachment_content_type :file, content_type: ['application/pdf']
  validates_attachment_presence :file
  validates_attachment_size :file, less_than: 2.megabyte
end
