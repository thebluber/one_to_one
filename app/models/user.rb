class User < ActiveRecord::Base
  has_one :student
  has_one :mentor
  authenticates_with_sorcery!
  validates_format_of :email,
    with: /.*@.*\.?uni-tuebingen\.de/i,
    on: :create,
    message: "Nur Email-Adressen der Universität werden akzeptiert"
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, :on => :create

  after_create   :create_accounts
  before_destroy :destroy_accounts

  def name
    first_name.capitalize + " " + last_name.capitalize
  end

  private
  def create_accounts
    student = Student.create(user_id: id)
    mentor = Mentor.create(user_id: id)
  end

  def destroy_accounts
    student.destroy
    mentor.destroy
  end
end
