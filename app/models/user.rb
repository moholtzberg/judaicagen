class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  before_save :generate_username
  
  validates_uniqueness_of :user_name
  
  def generate_username
    if self.user_name.blank?
      prefixes = ["RebYid", "GadolHador", "IshChashuv", "YehudiYakar", "TalmidChacham", "Amcha"]
      self.user_name = "#{prefixes.sample}-#{ SecureRandom.hex(10)}"
    end
  end
end