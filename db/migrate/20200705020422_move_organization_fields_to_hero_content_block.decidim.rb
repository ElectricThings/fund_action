# frozen_string_literal: true
# This migration comes from decidim (originally 20180810092428)

class MoveOrganizationFieldsToHeroContentBlock < ActiveRecord::Migration[5.2]

  class ContentBlock < ApplicationRecord
    self.table_name = :decidim_content_blocks

    include Decidim::Publicable

    attr_accessor :in_preview

    belongs_to :organization, foreign_key: :decidim_organization_id, class_name: "Decidim::Organization"

    delegate :public_name_key, :has_settings?, :settings_form_cell, :cell, to: :manifest

    before_save :save_images
    after_save :reload_images

    def self.for_scope(scope, organization:)
      where(organization: organization, scope: scope)
        .order(weight: :asc)
    end

    def manifest
      @manifest ||= Decidim.content_blocks.for(scope).find { |manifest| manifest.name.to_s == manifest_name }
    end

    def settings
      manifest.settings.schema.new(self[:settings])
    end

    def reload(*)
      @images_container = nil
      super
    end

    def images_container
      return @images_container if @images_container

      manifest = self.manifest

      @images_container = Class.new do
        extend ::CarrierWave::Mount
        include ActiveModel::Validations

        cattr_accessor :manifest, :manifest_scope
        attr_reader :content_block

        # Needed to calculate uploads URLs
        delegate :id, to: :content_block

        # Needed to customize the upload URL
        def self.name
          to_s.camelize
        end

        # Needed to customize the upload URL
        def self.to_s
          "decidim/#{manifest.name.to_s.underscore}_#{manifest_scope.to_s.underscore}_content_block"
        end

        def initialize(content_block)
          @content_block = content_block
        end

        def manifest
          self.class.manifest
        end

        manifest.images.each do |image_config|
          mount_uploader image_config[:name], image_config[:uploader].constantize
        end

        # This is used to access the upload file name from the container, given
        # an image name.
        def read_uploader(column)
          content_block.images[column.to_s]
        end

        # This is used to set the upload file name from the container, given
        # an image name.
        def write_uploader(column, value)
          content_block.images[column.to_s] = value
        end

        # When we save the content block, we force the container to save itself
        # too, so images can be processed, uploaded and stored in the DB.
        def save
          manifest.images.each do |image_config|
            send(:"write_#{image_config[:name]}_identifier")
            send(:"store_#{image_config[:name]}!")
          end
        end
      end

      @images_container.manifest = manifest
      @images_container.manifest_scope = scope
      @images_container = @images_container.new(self)
    end

    private

    # Internal: Since we're using the `images_container` hack to hold the
    # uploaders, we need to manually trigger it to save the attached images.
    def save_images
      images_container.save
    end

    # On instance reloading we need to remove the `images_cointainer` cached
    # class so it gets regenerated with the new values.
    def reload_images
      @images_container = nil
    end
  end

  class Organization < ApplicationRecord
    self.table_name = :decidim_organizations

    mount_uploader :homepage_image, ::Decidim::HomepageImageUploader
  end

  def change
    Decidim::ContentBlock.reset_column_information
    Organization.find_each do |organization|
      content_block = ContentBlock.find_by(organization: organization, scope: :homepage, manifest_name: :hero)
      settings = {}
      welcome_text = organization.welcome_text || {}
      settings = welcome_text.inject(settings) { |acc, (k, v)| acc.update("welcome_text_#{k}" => v) }

      content_block.settings = settings
      content_block.images_container.background_image = organization.homepage_image.file
      content_block.settings_will_change!
      content_block.images_will_change!
      content_block.save!
    end

    remove_column :decidim_organizations, :welcome_text
    remove_column :decidim_organizations, :homepage_image
  end
end
