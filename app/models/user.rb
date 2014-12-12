class User < ActiveRecord::Base
  has_one :student
  has_one :mentor
  has_one :admin
  authenticates_with_sorcery!
  validates_format_of :email,
    with: /.*@.*\.?uni-tuebingen\.de/i,
    on: :create,
    message: "Nur Email-Adressen der Universität werden akzeptiert"
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, on: :create, allow_blank: false
  validates_length_of :password, minimum: 4, maximum: 12
  validates_format_of :password,
    with: /\A\w\w*\z/i,
    message: "Passwort enthält ungültige Zeichen"


  after_create   :create_accounts
  before_destroy :destroy_accounts

  def name
    first_name.capitalize + " " + last_name.capitalize
  end

  def make_admin!
    self.admin = Admin.create(user_id: id) if self.admin.nil?
  end

  def admin?
    !self.admin.nil?
  end

  def destroy_admin!
    self.admin.destroy if admin?
  end
  private
  def create_accounts
    self.student = Student.create(user_id: id)
    self.mentor = Mentor.create(user_id: id)
  end

  def destroy_accounts
    self.student.destroy
    self.mentor.destroy
    destroy_admin!
  end
end
