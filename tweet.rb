require "json"

input = ARGF.read

ENV.each do |key, value|
  puts "#{key}=#{value}"
end

puts "====="
puts ENV["WEBHOOK_SECRET"]
puts "====="

if input == ""
else
  payload = JSON.parse(input, symbolize_names: true)

  twitter_message = "#{payload[:software][:name]} #{payload[:version_string]} released: #{payload[:release_notes_url]}"
end
