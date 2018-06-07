class Asset < ApplicationRecord

####################################################################
####################################################################

# Source - http://rails-bestpractices.com/posts/2010/08/18/use-sti-and-polymorphic-model-for-multiple-uploads/
# Need to find a way to remove the model name from the mix (IE "current_user.avatar.attachment.url" should be "current_user.avatar.url")
##########################################
##########################################

  # => Associations
  ##################
  belongs_to :user, optional: true # => Who Uploaded
  belongs_to :assetable, polymorphic: true, optional: true # => Where Uploaded

  # => CkEditor
  ##################
  if defined? Ckeditor
    include Ckeditor::Orm::ActiveRecord::AssetBase
    include Ckeditor::Backend::Paperclip
  end

  # => Table
  # => Required for CKEditor
  ##################
  self.table_name = "assets"

  # => Paperclip
  ##################
	has_attached_file    FL::FILE
	validates_attachment FL::FILE, presence: true, content_type: { content_type: /\Aimage\/.*\z/, message: "%{value}" }, size: { in: 0..3.megabytes }

  # => Alias
  ##################
  alias_attribute :ref, :id

##########################################
##########################################

  ###################
  #     Methods     #
  ###################

  # => Before Create
  # => https://github.com/thoughtbot/paperclip/wiki/Extracting-image-dimensions
  # => https://github.com/galetahub/ckeditor/blob/master/lib/ckeditor/backend/paperclip.rb#L38 (implemented in CKEditor)
  before_create -> { %i(width height).each {|style| self[style] = geometry.send(style)} }, if: Proc.new { |i| i.image? and i.has_dimensions? }

  # => Errors Fix
  # => https://github.com/thoughtbot/paperclip/pull/1554#issuecomment-200666161
  after_validation {|a| a.errors.delete(FL::FILE)}

##########################################
##########################################

    # => URL
    ##################
    def url *args
      data.url *args
    end

    # => CKEditor
    ##################
    def url_content
      url(:medium)
    end

    # => Image?
    ##################
    def image?
      %r(\Aimage\/.*\Z) =~ data_content_type
    end

    # => Dimensions
    ##################
    def has_dimensions?
      respond_to?(:width) && respond_to?(:height)
    end

##########################################
##########################################

  private

    # => Geometry
    # => https://github.com/galetahub/ckeditor/blob/master/lib/ckeditor/backend/paperclip.rb#L23
    def geometry
      @geometry ||= begin
        file = data.respond_to?(:queued_for_write) ? data.queued_for_write[:original] : data.to_file
        ::Paperclip::Geometry.from_file(file)
      end
    end

####################################################################

end
