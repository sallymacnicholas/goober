class User < ActiveRecord::Base
  has_secure_password
  validates :password, confirmation: true
  validates :phone_number, presence: true, format: {with:/\d/, message:"can only contain numbers"}
  validates :email, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :car_make, presence: true, unless: ->(user){user.role == "rider"}
  validates :car_model, presence: true, unless: ->(user){user.role == "rider"}
  validates :car_capacity, numericality: true, presence: true, unless: ->(user){user.role == "rider"}
end
