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
  property :active, Boolean, :default => true, :writer => :protected
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
  has n, :gratitude_sent, :model => 'Gratitude', :chlid_key => :sender_id

  #optional associations
  has n, :skill_desired, :model => 'Skill', :required => false, :through => Resource
  has n, :skills_aquired, :model => 'Skill', :required => false, :through => Resource

  #validations
  validates_presence_of :password_confirmation
  validates_confirmation_of :password

  def self.authenticate(username_or_email, pass)
    current_user = first(:username => username_or_email)# || first(:email => username_or_email)
    return nil if current_user.nil? || self.encrypt(pass, current_user.salt) != current_user.hashed_password
    current_user
  end

  def password=(pass)
    @password = pass
    self.salt = (1..12).map{(rand(26)+65).chr}.join if !self.salt
    self.hashed_password = self.class.encrypt(@password, self.salt)
  end

  protected
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end
end
