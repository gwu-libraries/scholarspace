class GenericFile < ActiveFedora::Base
  include Sufia::GenericFile

=begin
  property :alternative, predicate: ::RDF::DC.alternative do |index|
    index.as :stored_searchable, :facetable
  end
=end
  property :gw_affiliation, predicate: ::RDF::URI.new('http://scholarspace.library.gwu.edu/ns#gwaffiliation') do |index|
    index.as :stored_searchable, :facetable
  end
end
