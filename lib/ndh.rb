require 'active_support'
require 'active_support/core_ext/object'

require_relative 'ndh/nppes_data_loader'
require_relative 'ndh/nppes_data_repo'
require_relative 'ndh/fhir_generator'
require_relative 'ndh/organization_generator'
require_relative 'ndh/practitioner_generator'
require_relative 'ndh/nppes_network'
require_relative 'ndh/nppes_organization'
require_relative 'ndh/nppes_managing_org'
require_relative 'ndh/nppes_practitioner'
require_relative 'ndh/pharmacy_data'
require_relative 'ndh/pharmacy_org_data'
require_relative 'ndh/endpoint_factory'
require_relative 'ndh/healthcare_service_factory'
require_relative 'ndh/insurance_plan_factory'
require_relative 'ndh/location_factory'
require_relative 'ndh/network_factory'
require_relative 'ndh/organization_affiliation_factory'
require_relative 'ndh/organization_factory'
require_relative 'ndh/practitioner_factory'
require_relative 'ndh/practitioner_role_factory'
require_relative 'ndh/utils/nucc_codes'

module NDH
  ENDPOINT_PROFILE_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/ndh-Endpoint'
  HEALTHCARE_SERVICE_PROFILE_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/ndh-HealthcareService'
  INSURANCE_PLAN_PROFILE_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/ndh-InsurancePlan'
  NETWORK_PROFILE_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/ndh-Network'
  PRACTITIONER_PROFILE_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/ndh-Practitioner'
  PRACTITIONER_ROLE_PROFILE_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/ndh-PractitionerRole'
  ORGANIZATION_PROFILE_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/ndh-Organization'
  ORGANIZATION_AFFILIATION_PROFILE_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/ndh-OrganizationAffiliation'
  LOCATION_PROFILE_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/ndh-Location'

  ACCESSIBILITY_EXTENSION_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/base-ext-accessibility'
  COMMUNICATION_PROFICIENCY_EXTENSION_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/base-ext-communication-proficiency'
  CONTACT_POINT_AVAILABLE_TIME_EXTENSION_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/base-ext-contactpoint-availabletime'
  ENDPOINT_USE_CASE_EXTENSION_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/base-ext-endpoint-usecase'
  FROM_NETWORK_EXTENSION_URL = 'fromNetwork'
  NETWORK_REFERENCE_EXTENSION_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/base-ext-network-reference'
  NEW_PATIENTS_EXTENSION_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/base-ext-newpatients'
  ACCEPTING_NEW_PATIENTS_EXTENSION_URL='acceptingPatients'
  PRACTITIONER_QUALIFICATION_EXTENSION_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/base-ext-practitioner-qualification'
  DELIVERY_METHOD_EXTENSION_URL = 'http://hl7.org/fhir/us/ndh/StructureDefinition/base-ext-delivery-method'
  DELIVERY_METHOD_TYPE_EXTENSION_URL = 'type'

  ACCESSIBILITY_CODE_SYSTEM_URL = 'http://hl7.org/fhir/us/ndh/CodeSystem/AccessibilityCS'
  COMMUNICATION_PROFICIENCY_SYSTEM_URL = 'http://hl7.org/fhir/us/ndh/CodeSystem/LanguageProficiencyCS'
  ENDPOINT_USE_CASE_SYSTEM_URL = 'http://terminology.hl7.org/CodeSystem/v3-ActReason'
  ENDPOINT_PAYLOAD_TYPE_SYSTEM_URL = 'http://hl7.org/fhir/us/ndh/CodeSystem/EndpointPayloadTypeCS'
  INSURANCE_PLAN_TYPE_CODE_SYSTEM_URL = 'http://hl7.org/fhir/us/ndh/CodeSystem/InsuranceProductTypeCS'
  ACCEPTING_PATIENTS_CODE_SYSTEM_URL = 'http://hl7.org/fhir/us/ndh/CodeSystem/AcceptingPatientsCS'
  HEALTHCARE_SERVICE_CATEGORY_CODE_SYSTEM_URL = 'http://hl7.org/fhir/us/ndh/CodeSystem/HealthcareServiceCategoryCS'
  DELIVERY_METHOD_CODE_SYSTEM_URL = 'http://hl7.org/fhir/us/ndh/CodeSystem/DeliveryMethodCS'
  PRACTITIONER_ROLE_VALUE_SET_URL = 'http://hl7.org/fhir/us/ndh/CodeSystem/ProviderRoleCS'
  ORGANIZATION_TYPE_SYSTEM_URL = 'http://hl7.org/fhir/us/ndh/CodeSystem/OrgTypeCS'

  HEALTHCARE_SERVICE_CATEGORY_TYPES = {
    pharmacy: "pharm",
    group: "group",
    outpatient: "outpat",
    provider: "prov",
    hospital: "hosp"
  }
  
end
