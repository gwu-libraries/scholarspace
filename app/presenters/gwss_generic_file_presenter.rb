class GwssGenericFilePresenter < Sufia::GenericFilePresenter
  # ordered list of properties to display
  # self.terms = [:property1, :property2,
  #               :property3]
  self.terms = [:title, :resource_type, :creator, :gw_affiliation, :rights,
                :tag, :description, 
                :contributor, :publisher, :date_created, :language,
                :identifier, :based_near, :related_url, 
                :bibliographic_citation]
end
