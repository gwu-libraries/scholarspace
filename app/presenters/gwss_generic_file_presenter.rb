class GwssGenericFilePresenter < Sufia::GenericFilePresenter
  # ordered list of properties to display
  # self.terms = [:property1, :property2,
  #               :property3]
  self.terms = [:title, :creator, :gw_affiliation, :date_created,
                :resource_type, :rights, :description, :tag,
                :identifier, :contributor, :publisher, :language,
                :based_near, :related_url, :bibliographic_citation]
end
