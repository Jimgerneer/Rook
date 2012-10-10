class User
  include DataMapper::Resource

  attr_accessor :password, :password_confirmation

  property :id, Serial, :writer => :protected, :key => true
  property :email, String, :required => true, :length => (5..40),
           :unique => true, :format => :email_address
  property :username, String, :required => true, :length => (2..32), 
           :unique => true
  property :hashed_password, String, :writer => :protected
  property :salt, String, :required => true, :writer => :protected
  property :created_at, DateTime
  property :account_type, String, :required => true, :default => 'standard',
           :writer => :protected
  property :active, Boolean, :default => false, :writer => :protected
  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date

  #optional properties
  property :first_name, String, :required => false
  property :last_name, String, :required => false
  property :bio, String, :required => false, :length => 150

  #associations
  has n, :opportunities
  has n, :bookings
  has n, :booked_opportunities, :model => 'Opportunity', :child_key => [:id],
         :parent_key => [:user_id], :through => :bookings

  has n, :messages_received, :model => 'Message', :child_key => :recipient_id
  has n, :messages_sent, :model => 'Message', :child_key => :sender_id

  has n, :gratitude_received, :model => 'Gratitude', :child_key => :recipient_id
  has n, :gratitude_sent, :model => 'Gratitude', :child_key => :sender_id

  has n, :user_wanted_skills, :constraint => :destroy
  has n, :skills_desired, :model => 'Skill', :child_key => [:id],
         :parent_key => [:user_id], :through => :user_wanted_skills
  has n, :user_skills, :constraint => :destroy
  has n, :skills_acquired, :model => 'Skill', :child_key => [:id],
         :parent_key => [:user_id], :through => :user_skills

  #validations
  validates_presence_of :password_confirmation, :if => lambda { |u| u.has_password? }
  validates_confirmation_of :password, :if => lambda { |u| u.has_password? }
  validates_presence_of :password, :if => lambda { |u| u.new? }

  def self.authenticate(username, pass)
    current_user = first(:username => username, :active => true)
    return nil unless current_user && current_user.valid_pass?(pass)
    current_user
  end

  def valid_pass?(password)
    User.encrypt(password, self.salt) == self.hashed_password
  end

  def activate!
    self.active = true
    self.save
  end

  def password=(pass)
    @password = pass
    self.salt = (1..12).map{(rand(26)+65).chr}.join if !self.salt
    self.hashed_password = self.class.encrypt(@password, self.salt)
  end

  def has_password?
    !! @password
  end

  protected
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end
end
