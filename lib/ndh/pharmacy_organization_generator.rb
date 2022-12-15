require_relative './healthcare_service_factory'
require_relative './nppes_data_repo'
require_relative './organization_factory'
require_relative './pharmacy_organization_affiliation_factory'
require_relative './utils/nucc_constants'

module NDH

  class PharmacyOrganizationGenerator < OrganizationGenerator
    include ShortName

    def generate
      [organization, organization_affiliation].concat(organization_services)
    end

    private

    # call with pharmacy flag, or call pharmacy_org_data with appropriate arguments
    def organization
      NDH::OrganizationFactory.new(nppes_data, pharmacy:true).build
    end

    def organization_affiliation
      NDH::PharmacyOrganizationAffiliationFactory.new(
        nppes_data,
        networks: networks,
        services: organization_services,
        managing_org: nil,
        locations: locations 
      ).build
    end

    def pharmacies_by_organization(organization)
      @pharmacy_by_organization ||= NDH::NPPESDataRepo.pharmacies.group_by { |pharm| short_name(pharm.name) }
      @pharmacy_by_organization[organization.name] 
    end

    def locations
      pharmacies_by_organization(organization)
    end

    def provided_by
      {
        reference: "Organization/ndh-organization-#{nppes_data.npi}",
        display: nppes_data.name
      }
    end

   # Add a single service -- pharmacy...
    def organization_services
      @organization_services ||= [ NDH::HealthcareServiceFactory.new(
        nppes_data, 
        locations: locations, 
        provided_by: provided_by, 
        category_type: HEALTHCARE_SERVICE_CATEGORY_TYPES[:pharmacy]
      ).build ]
    end
  end
end
