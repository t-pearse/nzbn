require "nzbn/version"

module NZBN
  require 'rubygems'
  require 'time'
  require 'rest-client'
  require 'base64'

  NZBN_API_VERSION="v4"

  class DataError < StandardError; end
  class AuthError < StandardError; end

  def self.entities(search_term, entity_status, page_size)
    entity_status = "registered" if entity_status.blank?
    page_size = 50 if page_size.blank?
    response = RestClient.get("https://api.business.govt.nz/services/#{NZBN_API_VERSION}/nzbn/entities?search-term=#{search_term}&entity-status=#{entity_status}&page-size=#{page_size}",
                       { authorization: "Bearer #{access_token}", accept: 'application/json' })
    begin
      JSON.parse(response.body).with_indifferent_access
    rescue JSON::ParseError
      raise NZBN::DataError, "NZBN API returned bad data"
    end
  end

  def self.entity(nzbn)
    response = RestClient.get("https://api.business.govt.nz/services/#{NZBN_API_VERSION}/nzbn/entities/#{nzbn}",
                              { authorization: "Bearer #{access_token}", accept: 'application/json' })
    begin
      JSON.parse(response.body).with_indifferent_access
    rescue JSON::ParseError
      raise NZBN::DataError, "NZBN API returned bad data"
    end
  end

  def self.filings(nzbn)
    response = RestClient.get("https://api.business.govt.nz/services/#{NZBN_API_VERSION}/nzbn/entities/#{nzbn}/filings",
                              { authorization: "Bearer #{access_token}", accept: 'application/json' })
    begin
      JSON.parse(response.body).with_indifferent_access
    rescue JSON::ParseError
      raise NZBN::DataError, "NZBN API returned bad data"
    end
  end

  private

  def self.access_token
    response = RestClient.post("https://api.business.govt.nz/services/token", { grant_type: "client_credentials" },
                               { grant_type: "client_credentials", authorization: "Basic #{Base64.strict_encode64(ENV["NZBN_ID"] + ":" + ENV["NZBN_SECRET"])}" })
    begin
      JSON.parse(response.body)["access_token"]
    rescue JSON::ParseError
      raise NZBN::AuthError, "Authentication failed! Are you missing NZBN_ID or NZBN_SECRET?"
    end

  end
end
