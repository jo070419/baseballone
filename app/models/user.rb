class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\d|a-z]{1}[a-z|\d|\-|.|_]{2,29}@(yahoo.co.jp|gmail.com|ezweb.ne.jp|au.com|docomo.ne.jp|i.softbank.jp|softbank.ne.jp|excite.co.jp|googlemail.com|hotmail.co.jp|hotmail.com|icloud.com|live.jp|me.com|mineo.jp|nifty.com|outlook.com|outlook.jp|yahoo.ne.jp|ybb.ne.jp|ymobile.ne.jp)\z/
                      # 3-30文字
                      # 先頭は半角英小文字or半角数字
                      # ユーザー名で使用できる文字は半角英小文字、半角数字、-（ハイフン）、.（ドット）、_（アンダーバー）
                      # ユーザー名は＠マークを除き、最小3文字、最大30文字
                      # ドメイン名は指定したドメイン名以外では登録できない
  VALID_PHONE_NUMBER_REGEX = /\A[090|080|070]{3}(\-[0-9]{4}){2}\z/
                      # 頭3桁は090、080、070-4桁-4桁
  NOT_HYPHEN_REGEX = /\A[090|080|070]{3}([0-9]{4}){2}\z/

  has_many :recruitments
  has_many :applies
  has_many :agreements
  has_many :entries, dependent: :destroy
  has_many :message_rooms, through: :entries
  has_many :messages, dependent: :destroy
  has_one  :penalty_point
  accepts_nested_attributes_for :penalty_point
  has_one  :evaluation
  accepts_nested_attributes_for :evaluation

  before_validation :complete_hyphen

  with_options presence: true do
    validates :nickname,     length: { maximum: 24 }
    with_options uniqueness: true do
      validates :email,        length: { minimum: 10, maximum: 44 },
                               format: { with: VALID_EMAIL_REGEX }
                               # ユーザー名最小値3字 + @ + ドメイン名最小値6字 = 10
                               # ユーザー名最大値30字 + @ + ドメイン名最大値13字 = 44字
      validates :phone_number, length: { is: 13 },
                               format: { with: VALID_PHONE_NUMBER_REGEX }
    end
  end

  private
  
  def complete_hyphen
    if NOT_HYPHEN_REGEX.match?(self.phone_number)
      self.phone_number = self.phone_number.gsub(/(\d{3})(\d{4})(\d{4})/, '\1-\2-\3')
    end
  end
end
