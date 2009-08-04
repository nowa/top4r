# client.rb contains the classes, methods and extends <tt>TOP4R</tt>
# features to define client calls to the TOP REST API.
#
# See:
# * <tt>TOP4R::Client</tt>

# Used to query or post to the TOP REST API to simplify code.
class TOP4R::Client
  include TOP4R::ClassUtilMixin
end

require 'top4r/client/base'