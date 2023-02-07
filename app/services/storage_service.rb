class StorageService
  attr_accessor :config

  def initialize
    @config = config_keys.to_h { |key| [key, service_config[key]] }
  end

  def valid?
    raise NotImplementedError
  end

  def save(id, data)
    raise NotImplementedError
  end

  def read(id)
    raise NotImplementedError
  end

  private

  def service_name
    self.class.name.demodulize.underscore.to_sym
  end

  def service_config
    Rails.application.config.customstorage[service_name]
  end

  def config_keys
    raise NotImplementedError
  end
end
