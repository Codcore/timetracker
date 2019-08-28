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
    return if type.nil?
    content_tag(:span, type.to_s, class: "badge badge-pill #{BADGE_TYPES[type.to_sym]} mr-1 float-right")
  end

  def active_link(hash_params={})
    controller = hash_params.fetch(:controller, nil)
    action = hash_params.fetch(:action, nil)
    verify = []

    if controller
      controller_name == controller.to_s ? verify.push(true) : verify.push(false)
    end

    if action
      action_name == action.to_s ? verify.push(true) : verify.push(false)
    end

    "active" if verify.all? { |item| item }
  end
end
