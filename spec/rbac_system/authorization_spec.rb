# frozen_string_literal: true

require "spec_helper"

RSpec.describe RbacSystem::Authorization do
  let(:admin) { double("Admin", roles: [role]) }
  let(:role) { double("Role", permissions: { "resource_name" => { "read" => true, "edit" => true } }) }
  let(:resource) { "resource_name" }
  let(:action) { "read" }

  subject { described_class.new(admin, resource, action) }

  describe "#authorized?" do
    context "when the role has the required permission" do
      it "returns true" do
        expect(subject.authorized?).to be true
      end
    end

    context "when the role does not have the required permission" do
      let(:action) { "delete" }  # Testing for a different action that isn't authorized

      it "returns false" do
        expect(subject.authorized?).to be false
      end
    end

    context "when the admin has multiple roles" do
      let(:role2) { double("Role2", permissions: { "resource_name" => { "delete" => true } }) }
      let(:admin) { double("Admin", roles: [role, role2]) }

      context "when one of the roles has the required permission" do
        it "returns true" do
          expect(subject.authorized?).to be true
        end
      end
    end
  end
end
