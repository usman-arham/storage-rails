# frozen_string_literal: true

module StorageServices
  class Database < StorageService
    def valid?
      true
    end

    def save(id, data)
      attachment = Attachment.find_or_initialize_by(id:)
      attachment.update!(data:)
    end

    def read(id)
      attachment = Attachment.find(id)
      attachment[:data]
    end

    private

    def config_keys
      %i[]
    end
  end
end
