module RailsAdmin
  module Config
    module Actions
      class FlagUser < RailsAdmin::Config::Actions::Base
        # This ensures the action only shows up for Users
        # register_instance_option :visible? do
        #   authorized? && bindings[:object].class == User
        # end
        # We want the action on members, not the Users collection
        register_instance_option :link_icon do
          'icon-flag'
        end
        register_instance_option :member? do
          true
        end
        # You may or may not want pjax for your action
        register_instance_option :pjax? do
          false
        end
        register_instance_option :visible? do
          bindings[:object].class == User
        end
        # register_instance_option :controller do
        #   proc do
        #
        #   end
        # end
        register_instance_option :controller do
          proc do

            @abstract_model = RailsAdmin::AbstractModel.new(UserFlag)
            @model_config = RailsAdmin::Config::Model.new(UserFlag)
            @model_config.include_fields :content
            @objects = @object.user_flags

            render :index
          end
        end
      end
    end
  end
end
