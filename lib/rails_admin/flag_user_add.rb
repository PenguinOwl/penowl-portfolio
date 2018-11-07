module RailsAdmin
  module Config
    module Actions
      class FlagUserAdd < RailsAdmin::Config::Actions::Base
        # This ensures the action only shows up for Users
        # register_instance_option :visible? do
        #   authorized? && bindings[:object].class == User
        # end
        # We want the action on members, not the Users collection
        register_instance_option :link_icon do
          'icon-plus-sign'
        end
        register_instance_option :member? do
          true
        end
        # You may or may not want pjax for your action
        register_instance_option :pjax? do
          false
        end
        register_instance_option :visible? do
          bindings[:object].class == UserFlag
        end
        # register_instance_option :controller do
        #   proc do
        #
        #   end
        # end
        register_instance_option :controller do
          proc do

            redirect_to "/admin/user_flag/new"

          end
        end
      end
    end
  end
end
