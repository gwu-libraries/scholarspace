class GwssFileEditForm < GwssGenericFilePresenter
  include HydraEditor::Form
  include HydraEditor::Form::Permissions

  self.required_fields = [:title, :resource_type, :creator, :rights, :gw_affiliation]
end
