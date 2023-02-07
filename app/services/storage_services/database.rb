class StorageServices::Database < StorageService
  def valid?
    true
  end

  def save(id, data)
    attachment = Attachment.find_or_initialize_by(id: id)
    attachment.update!(data: data)
  end

  def read(id)
    attachment = Attachment.find(id)
    return attachment[:data]
  end
  private

  def config_keys
    %i[]
  end
end

