require "json"

input = ARGF.read

puts "====="
puts ENV["WEBHOOK_SECRET"]
puts ENV["x_rp_webhook_signature"]
puts "====="

if input == ""
else
  payload = JSON.parse(input, symbolize_names: true)

  twitter_message = "#{payload[:software][:name]} #{payload[:version_string]} released: #{payload[:release_notes_url]}"
end
