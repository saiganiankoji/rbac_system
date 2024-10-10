# frozen_string_literal: true
# rbac_system_spec.rb
RSpec.describe RbacSystem do
  it "has a version number" do
    expect(RbacSystem::VERSION).not_to be nil
  end
end
