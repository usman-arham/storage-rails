require "net/http"
class StorageServices::Amazon < StorageService
  def valid?
    @config.values.none?(&:blank?)
  end

  def url(id)
    URI("http://"+@config[:bucket].to_s+".s3."+@config[:region].to_s+".amazonaws.com/"+id+".txt")
  end
  def signer
    Aws::Sigv4::Signer.new(
      service: 's3',
      region: @config[:region],
      access_key_id: @config[:access_key_id],
      secret_access_key: @config[:secret_access_key]
    )
  end

  def save(id, data)
    url = url(id)
    signature = signer.sign_request(
      http_method: 'PUT',
      url: url,
      headers: {
        'Content-Type' => 'text/plain',
      },
      body: data
    )
    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Put.new(url)
    request["X-Amz-Content-Sha256"] = signature.headers['x-amz-content-sha256']
    request["X-Amz-Date"] = signature.headers['x-amz-date']
    request["Authorization"] = signature.headers['authorization']
    request["Content-Type"] = "text/plain"
    request.body = data
    response = http.request(request)
  end

  def read(id)
    url = url(id)
    signature = signer.sign_request(
      http_method: 'GET',
      url: url,
      headers: {
        'Content-Type' => 'text/plain',
      },
    )
    http = Net::HTTP.new(url.host, url.port);
    request = Net::HTTP::Get.new(url)
    request["X-Amz-Content-Sha256"] = signature.headers['x-amz-content-sha256']
    request["X-Amz-Date"] = signature.headers['x-amz-date']
    request["Authorization"] = signature.headers['authorization']
    request["Content-Type"] = "text/plain"
    response = http.request(request)
    response.read_body
  end

  private

  def config_keys
    %i[access_key_id secret_access_key region bucket]
  end
end

