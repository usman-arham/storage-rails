# frozen_string_literal: true

module StorageServices
  class Local < StorageService
    def valid?
      @config.values.none?(&:blank?)
    end

    def save(id, data)
      File.write("#{@config[:path]}/#{id}.txt", data)
    end

    def read(id)
      File.read("#{@config[:path]}/#{id}.txt")
    end

    private

    def config_keys
      %i[path]
    end
  end
end
