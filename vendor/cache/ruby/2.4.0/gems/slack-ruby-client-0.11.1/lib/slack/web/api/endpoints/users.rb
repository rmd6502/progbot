# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module Users
          #
          # Delete the user profile photo
          #
          # @see https://api.slack.com/methods/users.deletePhoto
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users/users.deletePhoto.json
          def users_deletePhoto(options = {})
            post('users.deletePhoto', options)
          end

          #
          # Gets user presence information.
          #
          # @option options [user] :user
          #   User to get presence info on. Defaults to the authed user.
          # @see https://api.slack.com/methods/users.getPresence
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users/users.getPresence.json
          def users_getPresence(options = {})
            throw ArgumentError.new('Required arguments :user missing') if options[:user].nil?
            options = options.merge(user: users_id(options)['user']['id']) if options[:user]
            post('users.getPresence', options)
          end

          #
          # Get a user's identity.
          #
          # @see https://api.slack.com/methods/users.identity
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users/users.identity.json
          def users_identity(options = {})
            post('users.identity', options)
          end

          #
          # Gets information about a user.
          #
          # @option options [user] :user
          #   User to get info on.
          # @option options [Object] :include_locale
          #   Set this to true to receive the locale for this user. Defaults to false.
          # @see https://api.slack.com/methods/users.info
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users/users.info.json
          def users_info(options = {})
            throw ArgumentError.new('Required arguments :user missing') if options[:user].nil?
            options = options.merge(user: users_id(options)['user']['id']) if options[:user]
            post('users.info', options)
          end

          #
          # Lists all users in a Slack team.
          #
          # @option options [Object] :cursor
          #   Paginate through collections of data by setting the cursor parameter to a next_cursor attribute returned by a previous request's response_metadata. Default value fetches the first "page" of the collection. See pagination for more detail.
          # @option options [Object] :include_locale
          #   Set this to true to receive the locale for users. Defaults to false.
          # @option options [Object] :limit
          #   The maximum number of items to return. Fewer than the requested number of items may be returned, even if the end of the users list hasn't been reached.
          # @option options [Object] :presence
          #   Whether to include presence data in the output. Defaults to false. Setting this to true reduces performance, especially with large teams.
          # @see https://api.slack.com/methods/users.list
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users/users.list.json
          def users_list(options = {})
            if block_given?
              Pagination::Cursor.new(self, :users_list, options).each do |page|
                yield page
              end
            else
              post('users.list', options)
            end
          end

          #
          # Find a user with an email address.
          #
          # @option options [Object] :email
          #   An email address belonging to a user in the workspace.
          # @see https://api.slack.com/methods/users.lookupByEmail
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users/users.lookupByEmail.json
          def users_lookupByEmail(options = {})
            throw ArgumentError.new('Required arguments :email missing') if options[:email].nil?
            post('users.lookupByEmail', options)
          end

          #
          # Marks a user as active.
          #
          # @see https://api.slack.com/methods/users.setActive
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users/users.setActive.json
          def users_setActive(options = {})
            post('users.setActive', options)
          end

          #
          # Set the user profile photo
          #
          # @option options [Object] :image
          #   File contents via multipart/form-data.
          # @option options [Object] :crop_w
          #   Width/height of crop box (always square).
          # @option options [Object] :crop_x
          #   X coordinate of top-left corner of crop box.
          # @option options [Object] :crop_y
          #   Y coordinate of top-left corner of crop box.
          # @see https://api.slack.com/methods/users.setPhoto
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users/users.setPhoto.json
          def users_setPhoto(options = {})
            throw ArgumentError.new('Required arguments :image missing') if options[:image].nil?
            post('users.setPhoto', options)
          end

          #
          # Manually sets user presence.
          #
          # @option options [Object] :presence
          #   Either auto or away.
          # @see https://api.slack.com/methods/users.setPresence
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/users/users.setPresence.json
          def users_setPresence(options = {})
            throw ArgumentError.new('Required arguments :presence missing') if options[:presence].nil?
            post('users.setPresence', options)
          end
        end
      end
    end
  end
end
