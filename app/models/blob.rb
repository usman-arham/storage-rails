class Blob < ApplicationRecord
  attr_writer :data
  attr_accessor :service

  before_save :save_data

  validates :id, presence: true, uniqueness: true, format: { without: /\s/ }
  validates :data, presence: true
  validate :data_must_be_base64_encoded

  
  def service
    ("StorageServices::"+Rails.configuration.customstorage.service.to_s.capitalize).constantize.new
  end

  def data
    return @data unless @data.blank?
    service.read(self.id)
  end

  def as_json(options={})
    options[:except] ||= [:updated_at]
    super(options)
  end

  
  private 
    def calculate_base64_size
      total_characters = @data.size
      padding_characters = @data.count("=")
      size_in_bytes = (3 * (total_characters / 4)) - (padding_characters)
      return size_in_bytes
    end

    def save_data
      self.size = calculate_base64_size
      service.save(self.id, @data)
    end

    def data_must_be_base64_encoded
      value = @data
      result = value.is_a?(String) && Base64.strict_encode64(Base64.decode64(value)) == value
      unless result 
        errors.add(:data, "must be a base64 string")
      end
    end
end
