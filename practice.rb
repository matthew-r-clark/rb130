system 'clear'

# class CustomArray
#   def initialize(arr)
#     @arr = arr
#   end

#   def each
#     index = 0
#     while index < @arr.size
#       yield @arr[index]
#       index += 1
#     end
#   end
# end

# custom_array = CustomArray.new([1,2,3])

# custom_array.each { |n| puts n }

# def explicit_block(&block)
#   block.call('Explicit block executed.')
# end

# def implicit_block
#   yield('Implicit block executed.', 'extra')
# end

# def explicit_lambda(lam)
#   lam.call('Lambda is here for it.', 'extra')
# end

# explicit_block {|message, other| puts message}
# implicit_block {|message| puts message}

# lam = lambda {|message| puts message}
# explicit_lambda lam

double = Proc.new {|x| x * 2}
stringify = :to_s.to_proc
arr = [1, 2, 3, 4, 5]

p arr.map(&double)
p arr.map(&stringify)
