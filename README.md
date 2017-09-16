# NZBN Gem

Simple and fast authenticating API wrapper for the New Zealand Companies Office. Search by company and retrieve company details. Further functionality can easily be exposed.


## About the Companies Office

The New Zealand Companies Office has an API which can be accessed through registration at: [https://api.business.govt.nz/api/](https://api.business.govt.nz/api/)

Registration is required in order to obtain unique access keys to use the API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nzbn'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nzbn

You will also need to set the following ENV variables, in order to access the API. These can be gound on the business.govt.nz website under your login.

$ NZBN_ID=

$ NZBN_SECRET=


## Usage

Two functions have been exposed, as per below.

### Company details by NZBN

	$ NZBN.entity(nzbn)
  * where nzbn is the entity nzbn

Full company details based on a unique 'Company Number' will be returned.

### Search for a Company

	$ NZBZN.entites(search_term, entity_status, page_length)
  * entity_status = "registered" to filter the search for registered entities only (defaults to registered)*
  * page_length = 50 to return the top 50 results only (max of 200, defaults to 50)*

All output is returned as parsed JSON. Within a rails view it can be quickly navigated with [Nokogiri](https://github.com/sparklemotion/nokogiri) or similar.


## TODO

Pull requests welcome to build out further functionality including:
- Entity filings
- Subscriptions
- Users
- Authorities
- Organisations
- Documents


## Queries

> NB: This Gem is not developed or maintained by the New Zealand Companies Office in anyway.

Please don't hesitate to get in touch if you have any queries and I'll try and point you in the right direction!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tpearse/nzbn.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
