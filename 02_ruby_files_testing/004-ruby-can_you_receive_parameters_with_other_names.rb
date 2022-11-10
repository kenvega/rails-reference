# when creating methods you receive parameters with a specific name
# can you receive them with other name when invoking them?: short answer: yes.
# you can test with this example:
# my_param will be taken by another_name_param

def test_method(my_param)
  p "=========================="
  p "my_param"
  p my_param
  p "=========================="
end

another_name_param = 'some parameters with other name'
test_method(another_name_param)

# testing this file in irb and rails console
# results: you can receive parameters with other names