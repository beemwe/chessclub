module SimpleForm
  module Inputs
    class DatePickerInput < Base
      def input
        "<div class=\"input-append date #{css_class}\" id=\"#{input_id}\" data-date=\"#{input_value}\" data-date-format=\"#{input_format}\">
        				<input size=\"8\" type=\"text\" name=\"#{input_name}\" value=\"#{input_value}\">
        				<span class=\"add-on\"><i class=\"icon-calendar\"></i></span>
        </div>".html_safe
        # @builder.text_field(attribute_name,input_html_options).html_safe
      end

      protected

      # include DateUtil::Localize

      def input_html_options
        super.merge(date_picker_options(input_value))
      end

      def date_picker_options(value = nil)
        {:value => I18n.localize(value, input_format), :size => 8, :class => css_class, :readonly => true, 'data-date-format' => input_format}
      end

      def css_class
        "date-picker"
      end

      def input_id
        "#{object_name}_#{attribute_name}"
      end

      def input_name
        "#{object_name}[#{attribute_name}]"
      end

      def input_value
        val = object.send(attribute_name)
        val.present? ? I18n.l(val, :format => input_format) : ""
      end

      def input_format
        '%d.%m.%Y'
      end

    end
  end
end

class DatePickerInput < SimpleForm::Inputs::DatePickerInput
  
end

SimpleForm::FormBuilder.map_type :date, :to => DatePickerInput
