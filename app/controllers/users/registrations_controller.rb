# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    def create; end

    def update; end

    # GET /resource/sign_up

    # POST /resource

    # GET /resource/edit

    # PUT /resource

    # DELETE /resource

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    end

    # The path used after sign up.

    # The path used after sign up for inactive accounts.

    def build_resource(hash = {})
      hash[:uid] = User.create_unique_string
      super
    end

    def update_resource(resource, params)
      return super if params['password'].present?

      resource.update_without_password(params.except('current_password'))
    end
  end
end
