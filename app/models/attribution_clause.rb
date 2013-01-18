class AttributionClause < ActiveRecord::Base
  belongs_to :licence
  attr_accessible :licence_id, :attribution_details, :attribution_type
  ATTRIBUTION_TYPES = %w(flexible specific)

  validates :attribution_type, presence: true, inclusion: ATTRIBUTION_TYPES

  def as_json(options = {})
    super( except: [ :id, :licence_id, :created_at, :updated_at ] )
  end

end