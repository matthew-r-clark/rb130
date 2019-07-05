def reduce(arr)
  count = 1
  acc = arr[0]
  while count < arr.size
    acc = yield(acc, arr[count])
    count += 1
  end
  acc
end

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }
# => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value }
# => [1, 2, 'a', 'b']