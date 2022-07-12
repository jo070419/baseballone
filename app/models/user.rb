class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :recruitments
  has_many :applies
  has_many :agreements
  has_many :entries, dependent: :destroy
  has_many :message_rooms, through: :entries
  has_many :messages, dependent: :destroy
end

