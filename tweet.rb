require "json"

input = ARGF.read

puts "====="
puts ENV.inspect
puts "====="

if input == ""
  $stderr.puts "Empty input"
else
  payload = JSON.parse(input, symbolize_names: true)

  twitter_message = "#{payload[:software][:name]} #{payload[:version_string]} released: #{payload[:release_notes_url]}"
  puts "This is what I tweet: #{twitter_message}"
end
