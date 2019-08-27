module ApplicationHelper
  BADGE_TYPES = { feature: "badge-success",
                  bug: "badge-danger",
                  hot: "badge-danger",
                  high: "badge-warning",
                  normal: "badge-primary"
  }

  BOOTSTRAP_CLASSES_FOR_FLASH = { :success => 'alert-success',
                                  :error => 'alert-danger',
                                  :alert => 'alert-warning',
                                  :notice => 'alert-info' }.freeze

  def bootstrap_class_for_flash(flash_type)
    BOOTSTRAP_CLASSES_FOR_FLASH[flash_type]
  end

  def badge_for(type)
    content_tag(:span, type.to_s, class: "badge badge-pill #{BADGE_TYPES[type.to_sym]} mr-3 float-right")
  end
end
