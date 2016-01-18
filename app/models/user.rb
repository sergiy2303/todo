class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :works
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  def completed_works?
    return true unless self.works.where(complete: true).count.zero?
    false
  end
end
