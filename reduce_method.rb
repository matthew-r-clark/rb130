def reduce(arr, acc=0)
  count = 0
  while count < arr.size
    acc = yield(acc, arr[count])
    count += 1
  end
  acc
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }
# => 15

p reduce(array, 10) { |acc, num| acc + num }
# => 25

p reduce(array) { |acc, num| acc + num if num.odd? }
# => NoMethodError: undefined method `+' for nil:NilClass