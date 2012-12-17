# De este pull request: https://github.com/rails/rails/pull/7824
# al2o3cr:
#   This is a draft of a fix for #7809 - there's still one failing test, but
#   I'm not certain how to fix it.
#
#   The failing test verifies that only a single query is executed when
#   updating a record with autosave on its assocations. Adding :inverse_of
#   causes the related objects (Birds, in this case) to pick up the
#   still-saving parent object (Pirate in this case) and save it again.
#
#   The net result is that duplicate UPDATE queries are sent. While this is
#   certainly an improvement over the existing behavior (which recurses
#   infinitely in changed_for_autosave?) it's still wrong.
#
#   Thoughts on how to fix this? The parent record clearly should be savable
#   again, to accommodate code that updates the parent in, say, an after_save
#   on child records. define_non_cyclic_method already avoids the cycle in that
#   case, so the saves don't recurse indefinitely.
module ActiveRecord
  module AutosaveAssociation
    # Returns whether or not this record has been changed in any way (including
    # whether
    # any of its nested autosave associations are likewise changed)
    def changed_for_autosave?
      @_changed_for_autosave_called ||= false
      if @_changed_for_autosave_called
        # traversing a cyclic graph of objects; stop it
        result = false
      else
        begin
          @_changed_for_autosave_called = true
          result = new_record? || changed? || marked_for_destruction? || nested_records_changed_for_autosave?
        ensure
          @_changed_for_autosave_called = false
        end
      end
      result
    end
  end
end
