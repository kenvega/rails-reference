# does ruby fails if it does not recieve parameters in a hash?
#   response: not if they have a default value - which makes them optional parameters

def test(my_param: nil)
  p "=========================="
  p my_param
end

test(my_param: "something") # prints 'something'
test() # nil
test # nil
test('a') # this does throws an error. expected a hash