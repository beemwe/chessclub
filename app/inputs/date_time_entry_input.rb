module SimpleForm
  module Inputs
    class DateTimeEntryInput < StringInput
      def input
        @builder.text_field(attribute_name, input_html_options).html_safe
      end

      private

      def input_html_options
        super.merge(date_picker_options(input_value))
      end

      def date_picker_options(value = nil)
        begin
          t = Time.parse(value)
        rescue
          t = Time.now
        end
        { :value => I18n.localize(t, :format => input_format), :class => css_class }
      end

      def css_class
        "date-time-entry"
      end

      def input_value
        val = object.send(attribute_name)
        val.present? ? I18n.l(val, :format => input_format) : ""
      end

      def input_format
        '%d.%m.%Y - %H:%M'
      end

    end
  end
end

class DateTimeEntryInput < SimpleForm::Inputs::DateTimeEntryInput

end

SimpleForm::FormBuilder.map_type :datetimeentry, :to => DateTimeEntryInput