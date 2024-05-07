class User < ApplicationRecord
	has_secure_password
	has_many :user_roles
	has_many :roles, through: :user_roles

	after_update :send_notification_email


	validates :email, presence: true

	def self.ransackable_attributes(auth_object = nil)
		["created_at", "email", "id", "id_value", "password_digest", "role_id", "status", "updated_at", "username"]
	end

	def self.ransackable_associations(auth_object = nil)
		["roles", "user_roles"]
	end

	private

	def send_notification_email
   	 UserMailer.approve_email(self).deliver_now
	end

end
