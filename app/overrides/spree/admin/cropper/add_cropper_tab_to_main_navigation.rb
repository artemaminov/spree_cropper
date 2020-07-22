# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/menu/cropper_tab',
  name: 'cropper_tab'
)
