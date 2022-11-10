# seems that you can reassign a method name to a variable name without a problem

def will_return_five
  5
end

p "=========================="
p "will_return_five"
p will_return_five # will output 5

will_return_five = 6

p "=========================="
p "will_return_five after reassigning to a value"
p will_return_five # will output 6