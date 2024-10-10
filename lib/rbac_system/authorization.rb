# frozen_string_literal: true
module RbacSystem
    class Authorization
      def initialize(admin, resource, action)
        @admin = admin
        @resource = resource
        @action = action
      end
  
      def authorized?
        roles.each do |role|
          return true if role_authorized?(role)
        end
        false
      end
  
      private
  
      def roles
        @admin.roles
      end
  
      def role_authorized?(role)
        role.permissions[@resource]&.key?(@action)
      end
    end
end
  