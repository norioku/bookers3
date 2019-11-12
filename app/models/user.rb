class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :books, dependent: :destroy
         attachment :profile_image

         validates :introduction, length: { maximum: 50 }
         validates :name, length: { in: 2..20 }
         validates :name, presence: true
end
