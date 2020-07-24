class User < ApplicationRecord
  # Map association to orders (ONE User HAS MANY Orders)
  has_many :orders, dependent: :destroy
  
  # Map association to active relationships (Following)
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
                                  
   # Map association to passive relationships (Followers)
  has_many :passive_relationships,  class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
                                  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  # Create an accessible attribute
  attr_accessor :remember_token, :activation_token
  
  before_save     :downcase_email
  before_create   :create_activation_digest
  
 
  validates :name,  presence: true, 
                    length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates :email, presence: true, 
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
                    
  has_secure_password
                    
  validates :password,  presence: true,
                        length: { minimum: 6 },
                        allow_nil: true
                      
                        
  # Returns the hash digest of a given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
  
  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # User orders
  def order_feed
    Order.where("user_id = ?", id)
  end
  
   def social_feed
    following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
    Order.where("user_id IN (#{following_ids}) 
                  OR user_id = :user_id", user_id: id)
  end
  
  # Follows a user
  def follow(other_user)
    following << other_user
  end
  
  # Unfollow a user
  def unfollow(other_user)
    following.delete(other_user)
  end
  
  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
  
  private
  
    # Convert all emails to lowercase
    def downcase_email
      email.downcase! 
      # self.email = email.downcase (Alternate Notation)
    end
    
    # Creates and assigns the activation token and digest
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
  
end