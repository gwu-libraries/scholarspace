class GenericFilesController < ApplicationController
  include Sufia::Controller
  include Sufia::FilesControllerBehavior

  self.presenter_class = GwssGenericFilePresenter
  self.edit_form_class = GwssFileEditForm
end
