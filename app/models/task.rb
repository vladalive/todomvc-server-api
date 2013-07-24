class Task < ActiveRecord::Base

  after_initialize :set_defaults!

  validates :title,
    presence: true

  private

  def set_defaults!
    self.completed = false  if self.completed.nil?
  end

end
