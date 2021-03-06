

module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups
    module Helplinks
      # Name of the component method
      def helplink
        @helplink ||= begin
          if options[:helplink].present?
            if options[:helplink] == true
              key = "#{object_name}_#{attribute_name}"
            else
              key = options[:helplink]
            end

            "<a class=\"btn btn-helplink\" data-helplink=\"#{key}\"><i class=\"icon-info-sign helplink #{key}\"></i></a>".html_safe
          else
            nil
          end
        end
      end
      
      # Used when the number is optional
      def has_helplink?
        helplink.present?
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Helplinks)

