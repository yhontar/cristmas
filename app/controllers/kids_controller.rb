class KidsController < ApplicationController
  respond_to :html, :js

  layout 'personal_page', only: :personal_page

  def add_to_pending
    unscoped_resource.add_to_pending(current_user.id)
  end

  def accept_sending
    resource.accept_sending
  end

  def remove_from_list
    resource.remove_from_list
  end

  def personal_page
    @kids = collection.by_status(params[:f]).page(params[:page]).per(6)
  end

  def show
    @kid = unscoped_resource
    @url =
  end

  protected

  def resource
    @kid = current_user.kids.find(params[:id])
  end

  def unscoped_resource
    @kid = Kid.find(params[:id])
  end

  def collection
    @kids = current_user.kids.order('created_at DESC')
  end

  def permitted_params
    params.permit(user_kid: [:id])
  end
end
