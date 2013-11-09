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
  def ilink_to(icon_name = nil, name = nil, options = nil, html_options = nil, &block)
    link_to "<i class=\"icon-#{icon_name}\"></i> #{name}".html_safe, options, html_options, block
  end

  def ibutton_to(icon_name = nil, name = nil, options = nil, html_options = nil, &block)
    html_options[:class] ||= ''
    html_options[:class] += ' btn'

    link_to "<i class=\"icon-#{icon_name}\"></i> #{name}".html_safe, options, html_options, block
  end

end
