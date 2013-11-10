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

  def ibutton_new(url)
    ibutton_to 'pencil', t('.new', :default => t('helpers.links.new')), url, :class => 'btn-primary'
  end

  def ibutton_edit(url)
    ibutton_to 'edit', t('.edit', :default => t('helpers.links.edit')), url, :class => 'btn-mini'
  end

  def ibutton_delete(url  )
    ibutton_to 'trash', t('.destroy', :default => t('helpers.links.destroy')), url, :method => :delete, :confirm => t('.confirm', :default => t('helpers.links.confirm', :default => 'Are you sure?')), :class => 'btn-mini btn-danger'
  end

end
