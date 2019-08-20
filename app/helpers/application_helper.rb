module ApplicationHelper
  BOOTSTRAP_CLASSES_FOR_FLASH = { :success => 'alert-success',
                                  :error => 'alert-danger',
                                  :alert => 'alert-warning',
                                  :notice => 'alert-info' }.freeze

  def bootstrap_class_for_flash(flash_type)
    BOOTSTRAP_CLASSES_FOR_FLASH[flash_type]
  end
end
