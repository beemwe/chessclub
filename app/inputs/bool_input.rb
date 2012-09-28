module SimpleForm
  module Inputs
    class BoolInput < Base
      def input
        "<input name=\"#{input_name}\" type=\"hidden\" value=\"#{input_value ? "1" : "0"}\">
         <label>
           <input class=\"boolean optional\" id=\"#{input_id}\" name=\"#{input_name}\" type=\"checkbox\" value=\"1\" checked=\"#{input_value ? "checked" : ""}\">
           #{I18n.t("activerecord.attributes.#{object_name}.#{attribute_name}")}
         </label>".html_safe
      end

      protected

      def input_html_options
        super.merge(checkbox_options(input_value))
      end

      def checkbox_options(value = nil)
        {:value => I18n.localize(value), :size => 8, :class => css_class, :readonly => true, 'data-date-format' => 'dd.mm.yyyy'}
      end

      def css_class
        "boolean"
      end

      def input_id
        "#{object_name}_#{attribute_name}"
      end

      def input_name
        "#{object_name}[#{attribute_name}]"
      end

      def input_value
        object.send(attribute_name)
      end

    end
  end
end

class BoolInput < SimpleForm::Inputs::BoolInput

end

SimpleForm::FormBuilder.map_type :bool, :to => BoolInput
