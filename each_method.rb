def each(arr)
  count = 0
  while count < arr.size
    yield arr[count]
    count += 1
  end
  arr
end

p each([1,2,3]) {|e| "do nothing"}.select(&:odd?)