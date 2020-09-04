# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  insert_bottom: '#sidebar-configuration',
  partial: 'spree/admin/shared/sub_menu/cropper',
  name: 'cropper_tab'
)
