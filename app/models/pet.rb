class Pet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  embedded_in :shelter

  field :uid, type: String
  field :url_id, type: String

  validates_uniqueness_of :uid

  protected
  def on_before_validation
    self.uid = create_uid(self.id)
    self.url_id = create_uid(self.name)
  end

  private
  def create_uid(id)
    id.parameterize
  end
  def create_url_id(str)
    str.gsub('.','').parameterize
  end
end
