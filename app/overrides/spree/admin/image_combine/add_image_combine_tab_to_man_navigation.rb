# frozen_string_literal: true

Deface::Override.new(
    virtual_path: 'spree/layouts/admin',
    insert_bottom: '#main-sidebar',
    partial: 'spree/admin/shared/menu/image_combine_tab',
    name: 'image_combine_tab'
)
