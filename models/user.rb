class Rook
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
    
    has n, :opportunities, :model => "Rook::Opportunity" 

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
end


 # has n, :profile
 # has n, :courses
