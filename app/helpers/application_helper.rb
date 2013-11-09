module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def set_active_menu_item(controller)
    "#{controller == params[:controller] ? 'active' : ''}".html_safe
  end

  #Implemntierung des Helpers ilink_to für das anzeigen von Buttons zur Anwendungsstueuerung
  def ilink_to(icon_name = nil, name = nil, options = nil, html_options = {}, &block)
    html_options[:class] ||= ''
    html_options[:class] += ' btn'

    link_to "<i class=\"icon-#{icon_name}\"></i> #{name}".html_safe, options, html_options, block
  end


=begin

  Wird nicht mehr benötigt, erledigt jetzt das Gem Cocoon!

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, 'remove_fields(this)')
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + '_fields', :f => builder, :locals => {:show_sort_links => :false})
    end
    link_to name, '#', :onclick => h("add_fields(this, '#{association}', '#{escape_javascript(fields)}'); return false;")
  end
=end

end
