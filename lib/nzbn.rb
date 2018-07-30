require "nzbn/version"

module NZBN
  require 'rubygems'
  require 'time'
  require 'curb'
  require 'base64'


    def self.entities(search_term, entity_status, page_size)
      entity_status = "registered" if entity_status.blank?
      page_size = 50 if page_size.blank?
      r = Curl::Easy.new("https://api.business.govt.nz/services/v3/nzbn/entities?search-term=#{search_term}&entity-status=#{entity_status}&page-size=#{page_size}") do |curl|
        curl.headers['Authorization'] = 'Bearer ' + access_token
        curl.http_auth_types = :basic
        curl.verbose = true
      end
      r.perform
      return JSON.parse(r.body_str)
    end

    def self.entity(nzbn)
      r = Curl::Easy.new("https://api.business.govt.nz/services/v3/nzbn/entities/#{nzbn}") do |curl|
        curl.headers['Authorization'] = 'Bearer ' + access_token
        curl.http_auth_types = :basic
        curl.verbose = true
      end
      r.perform
      return JSON.parse(r.body_str)
    end

    def self.filings(nzbn)
      r = Curl::Easy.new("https://api.business.govt.nz/services/v3/nzbn/entities/#{nzbn}/filings") do |curl|
        curl.headers['Authorization'] = 'Bearer ' + access_token
        curl.http_auth_types = :basic
        curl.verbose = true
      end
      r.perform
      return JSON.parse(r.body_str)
    end



  private


    def self.access_token
        c = Curl::Easy.http_post("https://api.business.govt.nz/services/token", "grant_type=client_credentials") do |curl|
          curl.headers['grant_type'] = 'client_credentials'
          curl.headers['Authorization'] = 'Basic ' + Base64.strict_encode64(ENV["NZBN_ID"] + ":" + ENV["NZBN_SECRET"])
          curl.http_auth_types = :basic
          curl.verbose = true
        end
        c.perform
        return JSON.parse(c.body_str)["access_token"]
    end


end
