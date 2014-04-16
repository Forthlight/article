module Article
  module PublicationsHelper
    def is_checked?(checked, value)
      if checked.present?
        if checked.include?(value)
          true
        else
          false
        end
      else
        true
      end
    end
  end
end
