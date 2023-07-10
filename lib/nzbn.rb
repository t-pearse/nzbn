require "nzbn/version"

module NZBN
  require 'rubygems'
  require 'time'
  require 'rest-client'
  require 'base64'

  NZBN_API_VERSION="v5"

  class DataError < StandardError; end
  class AuthError < StandardError; end

  def self.entities(search_term, entity_status, page_size)
    entity_status = "registered" if entity_status.blank?
    page_size = 50 if page_size.blank?
    response = RestClient.get("https://api.business.govt.nz/gateway/nzbn/#{NZBN_API_VERSION}/entities?search-term=#{search_term}&entity-status=#{entity_status}&page-size=#{page_size}",
      { "Ocp-Apim-Subscription-Key": ENV["NZBN_KEY"], accept: 'application/json' })
    begin
      JSON.parse(response.body).with_indifferent_access
    rescue JSON::ParserError
      raise NZBN::DataError, "NZBN API returned bad data"
    end
  end

  def self.entity(nzbn)
    response = RestClient.get("https://api.business.govt.nz/gateway/nzbn/#{NZBN_API_VERSION}/entities/#{nzbn}",
                              { "Ocp-Apim-Subscription-Key": ENV["NZBN_KEY"], accept: 'application/json' })
    begin
      JSON.parse(response.body).with_indifferent_access
    rescue JSON::ParserError
      raise NZBN::DataError, "NZBN API returned bad data"
    end
  end

  def self.filings(nzbn)
    response = RestClient.get("https://api.business.govt.nz/gateway/nzbn/#{NZBN_API_VERSION}/entities/#{nzbn}/filings",
                              { "Ocp-Apim-Subscription-Key": ENV["NZBN_KEY"], accept: 'application/json' })
    begin
      JSON.parse(response.body).with_indifferent_access
    rescue JSON::ParserError
      raise NZBN::DataError, "NZBN API returned bad data"
    end
  end

end
