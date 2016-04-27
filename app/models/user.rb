class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable #, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :projects, dependent: :destroy
  has_many :time_entries
  has_many :clients, dependent: :destroy
  has_one :company, dependent: :destroy
  has_one :payment_address, through: :company
  has_many :invoices, through: :clients

  after_create :create_initial_company

  private
    def create_initial_company
      company = self.build_company
      company.build_payment_address(type: "iban")
      company.save(validate: false)
    end
end