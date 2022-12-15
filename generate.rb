require 'csv'
require 'pry'
require_relative 'lib/ndh'

NDH::NPPESDataLoader.load

NDH::FHIRGenerator.generate
