# does eql? check all keys and values to return true?: it seems it does

hash1 = {a: '0', b: '1'}
hash2 = {a: '0', b: '1'}
hash3 = {a: '0', b: '1', extra: 'dummy'}
hash4 = {a: '0', b:  1 }

p "=========================="
p "hash1.eql?(hash2)"
p hash1.eql?(hash2) # outputs true. same keys and values

p "=========================="
p "hash1.eql?(hash3)"
p hash1.eql?(hash3) # outputs false. extra key added

p "=========================="
p "hash1.eql?(hash4)"
p hash1.eql?(hash4) # outputs false. different value
