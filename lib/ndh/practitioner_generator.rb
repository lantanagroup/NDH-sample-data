require_relative './nppes_data_repo'
require_relative './practitioner_factory'
require_relative './practitioner_role_factory'

module NDH
  class PractitionerGenerator
    attr_reader :nppes_data

    def initialize(nppes_data)
      @nppes_data = nppes_data
    end

    def generate
      [practitioner, practitioner_role]
    end

    private

    def practitioner
      NDH::PractitionerFactory.new(nppes_data).build
    end

    def practitioner_role
      NDH::PractitionerRoleFactory.new(nppes_data, organization: organization, networks: networks).build
    end

    def state
      nppes_data.address.state
    end

    def organizations
      NDH::NPPESDataRepo.organizations_by_state(state)
    end

    def organization
      organizations[nppes_data.npi.to_i % organizations.length]
    end

    def organization_ref
      {
        reference: "Organization/ndh-organization-#{organization.npi}",
        display: organization.name
      }
    end

    def networks
      NDH::NPPESDataRepo.organization_networks[organization.npi]
    end
  end
end
