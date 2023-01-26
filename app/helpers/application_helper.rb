module ApplicationHelper
  def params_plus(additional_params)
    params.to_unsafe_h.merge(additional_params)
  end

  def attribute_model(model, attr)
    model.class.human_attribute_name(attr)
  end

  def full_title(page_title = '')
    base_title = t('site_name')
    page_title ? "#{page_title} | #{base_title}" : base_title.to_s
  end
end
