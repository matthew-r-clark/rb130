def times(n)
  count = 0
  while count < n
    yield count
    count += 1
  end
  n
end

return_value = times(5) do |num|
  puts num
end

puts "return value is: #{return_value}"