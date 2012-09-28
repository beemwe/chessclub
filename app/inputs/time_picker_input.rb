module SimpleForm
  module Inputs
    class TimePickerInput < Base
      def input
        "<div class=\"input-append time\" id=\"#{input_id}\" data-time=\"#{input_value}\">
                <select name=\"#{input_name}\">
                        <option value=\"05:00\" #{input_value == "05:00" ? "selected=\"selected\"" : ""}>05:00 Uhr</option>
                        <option value=\"05:15\" #{input_value == "05:15" ? "selected=\"selected\"" : ""}>05:15 Uhr</option>
                        <option value=\"05:30\" #{input_value == "05:30" ? "selected=\"selected\"" : ""}>05:30 Uhr</option>
                        <option value=\"05:45\" #{input_value == "05:45" ? "selected=\"selected\"" : ""}>05:45 Uhr</option>
                        <option value=\"06:00\" #{input_value == "06:00" ? "selected=\"selected\"" : ""}>06:00 Uhr</option>
                        <option value=\"06:15\" #{input_value == "06:15" ? "selected=\"selected\"" : ""}>06:15 Uhr</option>
                        <option value=\"06:30\" #{input_value == "06:30" ? "selected=\"selected\"" : ""}>06:30 Uhr</option>
                        <option value=\"06:45\" #{input_value == "06:45" ? "selected=\"selected\"" : ""}>06:45 Uhr</option>
                        <option value=\"07:00\" #{input_value == "07:00" ? "selected=\"selected\"" : ""}>07:00 Uhr</option>
                        <option value=\"07:15\" #{input_value == "07:15" ? "selected=\"selected\"" : ""}>07:15 Uhr</option>
                        <option value=\"07:30\" #{input_value == "07:30" ? "selected=\"selected\"" : ""}>07:30 Uhr</option>
                        <option value=\"07:45\" #{input_value == "07:45" ? "selected=\"selected\"" : ""}>07:45 Uhr</option>
                        <option value=\"08:00\" #{input_value == "08:00" ? "selected=\"selected\"" : ""}>08:00 Uhr</option>
                        <option value=\"08:15\" #{input_value == "08:15" ? "selected=\"selected\"" : ""}>08:15 Uhr</option>
                        <option value=\"08:30\" #{input_value == "08:30" ? "selected=\"selected\"" : ""}>08:30 Uhr</option>
                        <option value=\"08:45\" #{input_value == "08:45" ? "selected=\"selected\"" : ""}>08:45 Uhr</option>
                        <option value=\"09:00\" #{input_value == "09:00" ? "selected=\"selected\"" : ""}>09:00 Uhr</option>
                        <option value=\"09:15\" #{input_value == "09:15" ? "selected=\"selected\"" : ""}>09:15 Uhr</option>
                        <option value=\"09:30\" #{input_value == "09:30" ? "selected=\"selected\"" : ""}>09:30 Uhr</option>
                        <option value=\"09:45\" #{input_value == "09:45" ? "selected=\"selected\"" : ""}>09:45 Uhr</option>
                        <option value=\"10:00\" #{input_value == "10:00" ? "selected=\"selected\"" : ""}>10:00 Uhr</option>
                        <option value=\"10:15\" #{input_value == "10:15" ? "selected=\"selected\"" : ""}>10:15 Uhr</option>
                        <option value=\"10:30\" #{input_value == "10:30" ? "selected=\"selected\"" : ""}>10:30 Uhr</option>
                        <option value=\"10:45\" #{input_value == "10:45" ? "selected=\"selected\"" : ""}>10:45 Uhr</option>
                        <option value=\"11:00\" #{input_value == "11:00" ? "selected=\"selected\"" : ""}>11:00 Uhr</option>
                        <option value=\"11:15\" #{input_value == "11:15" ? "selected=\"selected\"" : ""}>11:15 Uhr</option>
                        <option value=\"11:30\" #{input_value == "11:30" ? "selected=\"selected\"" : ""}>11:30 Uhr</option>
                        <option value=\"11:45\" #{input_value == "11:45" ? "selected=\"selected\"" : ""}>11:45 Uhr</option>
                        <option value=\"12:00\" #{input_value == "12:00" ? "selected=\"selected\"" : ""}>12:00 Uhr</option>
                        <option value=\"12:15\" #{input_value == "12:15" ? "selected=\"selected\"" : ""}>12:15 Uhr</option>
                        <option value=\"12:30\" #{input_value == "12:30" ? "selected=\"selected\"" : ""}>12:30 Uhr</option>
                        <option value=\"12:45\" #{input_value == "12:45" ? "selected=\"selected\"" : ""}>12:45 Uhr</option>
                        <option value=\"13:00\" #{input_value == "13:00" ? "selected=\"selected\"" : ""}>13:00 Uhr</option>
                        <option value=\"13:15\" #{input_value == "13:15" ? "selected=\"selected\"" : ""}>13:15 Uhr</option>
                        <option value=\"13:30\" #{input_value == "13:30" ? "selected=\"selected\"" : ""}>13:30 Uhr</option>
                        <option value=\"13:45\" #{input_value == "13:45" ? "selected=\"selected\"" : ""}>13:45 Uhr</option>
                        <option value=\"14:00\" #{input_value == "14:00" ? "selected=\"selected\"" : ""}>14:00 Uhr</option>
                        <option value=\"14:15\" #{input_value == "14:15" ? "selected=\"selected\"" : ""}>14:15 Uhr</option>
                        <option value=\"14:30\" #{input_value == "14:30" ? "selected=\"selected\"" : ""}>14:30 Uhr</option>
                        <option value=\"14:45\" #{input_value == "14:45" ? "selected=\"selected\"" : ""}>14:45 Uhr</option>
                        <option value=\"15:00\" #{input_value == "15:00" ? "selected=\"selected\"" : ""}>15:00 Uhr</option>
                        <option value=\"15:15\" #{input_value == "15:15" ? "selected=\"selected\"" : ""}>15:15 Uhr</option>
                        <option value=\"15:30\" #{input_value == "15:30" ? "selected=\"selected\"" : ""}>15:30 Uhr</option>
                        <option value=\"15:45\" #{input_value == "15:45" ? "selected=\"selected\"" : ""}>15:45 Uhr</option>
                        <option value=\"16:00\" #{input_value == "16:00" ? "selected=\"selected\"" : ""}>16:00 Uhr</option>
                        <option value=\"16:15\" #{input_value == "16:15" ? "selected=\"selected\"" : ""}>16:15 Uhr</option>
                        <option value=\"16:30\" #{input_value == "16:30" ? "selected=\"selected\"" : ""}>16:30 Uhr</option>
                        <option value=\"16:45\" #{input_value == "16:45" ? "selected=\"selected\"" : ""}>16:45 Uhr</option>
                        <option value=\"17:00\" #{input_value == "17:00" ? "selected=\"selected\"" : ""}>17:00 Uhr</option>
                        <option value=\"17:15\" #{input_value == "17:15" ? "selected=\"selected\"" : ""}>17:15 Uhr</option>
                        <option value=\"17:30\" #{input_value == "17:30" ? "selected=\"selected\"" : ""}>17:30 Uhr</option>
                        <option value=\"17:45\" #{input_value == "17:45" ? "selected=\"selected\"" : ""}>17:45 Uhr</option>
                        <option value=\"18:00\" #{input_value == "18:00" ? "selected=\"selected\"" : ""}>18:00 Uhr</option>
                        <option value=\"18:15\" #{input_value == "18:15" ? "selected=\"selected\"" : ""}>18:15 Uhr</option>
                        <option value=\"18:30\" #{input_value == "18:30" ? "selected=\"selected\"" : ""}>18:30 Uhr</option>
                        <option value=\"18:45\" #{input_value == "18:45" ? "selected=\"selected\"" : ""}>18:45 Uhr</option>
                </select>
        </div>".html_safe
        # @builder.text_field(attribute_name,input_html_options).html_safe
      end

      protected

      # include DateUtil::Localize

      def input_html_options
        super.merge(time_picker_options(input_value))
      end

      def time_picker_options(value = nil)
        {:value => I18n.localize(value), :size => 5, :class => css_class, :readonly => true, 'data-time-format' => 'HH:MM'}
      end

      def css_class
        "time-picker"
      end

      def input_id
        "#{object_name}_#{attribute_name}"
      end

      def input_name
        "#{object_name}[#{attribute_name}]"
      end

      def input_value
        val = object.send(attribute_name).to_datetime.to_formatted_s :time
        atime = val.split(':')
        mins = atime[1].to_i
        if mins >= 0 && mins < 15 then atime[1] = '00'
          elsif mins >= 15 && mins < 30 then atime[1] = '15'
          elsif mins >= 30 && mins < 45 then atime[1] = '30'
          else atime[1] = '45'
          end
        "#{atime[0]}:#{atime[1]}"
      end

    end
  end
end

class TimePickerInput < SimpleForm::Inputs::TimePickerInput

end

SimpleForm::FormBuilder.map_type :time, :to => TimePickerInput
