class Shelter
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  embeds_many :pets

  field :uid, type: String
  field :url_id, type: String

  validates_uniqueness_of :uid
  validates_uniqueness_of :url_id
  index({ uid: 1 }, { unique: true })
  index({ url_id: 1 }, { unique: true })

  before_validation :on_before_validation


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
