# -*- encoding : utf-8 -*-
module Top4R
  # ItemCat model
  class ItemCat
    include ModelMixin
    @@ATTRIBUTES = [:cid, :parent_cid, :name, :is_parent, :status, :sort_order]
    attr_accessor *@@ATTRIBUTES
    
    class << self
      def attributes; @@ATTRIBUTES; end

      def default_public_fields
        ["cid", "name", "parent_cid", "is_parent"]
      end
    end
    
    def unmarshal_other_attrs
      self
    end
  end
end
