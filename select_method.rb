def select(arr)
  result = []
  count = 0

  while count < arr.size
    current = arr[count]
    result << current if yield current
    count += 1
  end
  result
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }
# => [1, 3, 5]

p select(array) { |num| puts num }
# => [], because "puts num" returns nil and evaluates to false

p select(array) { |num| num + 1 }
# => [1, 2, 3, 4, 5], because "num + 1" evaluates to true