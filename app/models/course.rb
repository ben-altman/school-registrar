class Course < ApplicationRecord
  validates :title, presence: :true
  validates :size, presence: :true

  belongs_to :teacher
  belongs_to :subject

  has_many :course_requirements, :dependent => :destroy
  has_many :requirements, through: :course_requirements

  accepts_nested_attributes_for :subject, reject_if: proc { |attr| attr["name"].blank? }
  accepts_nested_attributes_for :requirements, reject_if: proc {|attr| attr["name"].blank? }
  
  # could write a custom setter for a single attribute
  # def subject_attributes=(attributes)
  #   subject = Subject.find_or_create_by(attributes)
  #   self.subject = subject if subject.valid? || !self.vet
  # end

  def new_requirement_attributes=(attributes)
    requirement = Requirement.find_or_create_by(attributes)
    self.requirements << requirement if requirement.valid? || !self.requirements
  end

  scope :alpha, -> { order title: :asc}
  scope :by_subject, ->(subject) {where(subject_id: subject.id)}

end
