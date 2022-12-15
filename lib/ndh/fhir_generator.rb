require_relative './insurance_plan_factory'
require_relative './organization_factory'
require_relative './network_factory'
require_relative './location_factory'
require_relative './endpoint_factory'
require_relative './organization_generator'
require_relative './pharmacy_organization_generator'
require_relative './practitioner_generator'

module NDH
  class FHIRGenerator
    RESOURCE_TYPES = [
      'InsurancePlan',
      'Organization',
      'OrganizationAffiliation',
      'Location',
      'Endpoint',
      'HealthcareService',
      'Practitioner',
      'PractitionerRole'
    ]

    class << self
      def generate
        create_output_directories
        generate_insurance_plans
        generate_managing_orgs
        generate_payers
        generate_networks
        generate_organizations
        generate_locations
        generate_endpoints
        generate_practitioners
        generate_pharmacies
        generate_pharmacy_orgs
      end

      private

      def create_output_directories
        RESOURCE_TYPES.each do |resource_type|
          FileUtils.mkdir_p("output/#{resource_type}")
        end
      end

      def write_resource(resource)
        File.write("output/#{resource.resourceType}/#{resource.id}.json", resource.to_json)
      end

      def generate_resources(data, &block)
        data.each do |nppes_data|
          write_resource(block.call(nppes_data))
        end
      end

      def generate_insurance_plans
        generate_resources(NDH::NPPESDataRepo.plans) do |nppes_data|
          NDH::InsurancePlanFactory.new(nppes_data).build
        end
      end

      def generate_managing_orgs
        generate_resources(NDH::NPPESDataRepo.managing_orgs) do |nppes_data|
          NDH::OrganizationFactory.new(nppes_data, managing_org: true).build
        end
      end

      def generate_payers
        generate_resources(NDH::NPPESDataRepo.payers) do |nppes_data|
          NDH::OrganizationFactory.new(nppes_data, payer: true).build
        end
      end

      def generate_networks
        generate_resources(NDH::NPPESDataRepo.networks) do |nppes_data|
          NDH::NetworkFactory.new(nppes_data).build
        end
      end

      def generate_locations
        generate_resources(NDH::NPPESDataRepo.organizations) do |nppes_data|
          NDH::LocationFactory.new(nppes_data).build
        end
      end

      def generate_endpoints
        generate_resources(NDH::NPPESDataRepo.organizations) do |nppes_data|
          NDH::EndpointFactory.new(nppes_data, 'Organization').build
        end
      end

      # Generate Organizations, HealthcareServices, and OrganizationAffiliations
      def generate_organizations
        NDH::NPPESDataRepo.organizations.each do |nppes_data|
          NDH::OrganizationGenerator.new(nppes_data).generate.each do |resource|
            write_resource(resource)
          end
        end
      end

      # Generate Practitioners and PractitionerRoles
      def generate_practitioners
        NDH::NPPESDataRepo.practitioners.each do |nppes_data|
          NDH::PractitionerGenerator.new(nppes_data).generate.each do |resource|
            write_resource(resource)
          end
        end
      end

      def generate_pharmacies
         generate_resources(NDH::NPPESDataRepo.pharmacies) do |nppes_data|
           NDH::LocationFactory.new(nppes_data, pharmacy: true).build
        end
      end

      def generate_pharmacy_orgs
        # Pharmacy_orgs is a PharmacyOrgData, not an NPPES data... 
        NDH::NPPESDataRepo.pharmacy_orgs.each do |nppes_data|
          NDH::PharmacyOrganizationGenerator.new(nppes_data).generate.each do |resource|
            write_resource(resource)
          end
        end
      end
    end
  end
end
