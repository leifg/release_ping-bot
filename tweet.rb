require "json"
require "openssl"

data = ARGF.read.strip

if data == ""
  $stderr.puts "Empty Payload"
  return 1
end

type, signature = ENV["x_rp_webhook_signature"].split("=")
secret = ENV["WEBHOOK_SECRET"]
digest = OpenSSL::Digest.new(type)

local_signature = OpenSSL::HMAC.hexdigest(digest, secret, data)

if local_signature != signature
  $stderr.puts "Signature mismatch"
  return 1
end

payload = JSON.parse(data, symbolize_names: true)
version_info = payload[:version_info]
base_version = "#{version_info[:major]}.#{version_info[:minor]}.#{version_info[:patch]}"
twitter_message = "#{payload[:software][:name]} #{payload[:display_version]} released: #{payload[:release_notes_url]}"

$stdout.puts "I tweet: #{twitter_message}"
