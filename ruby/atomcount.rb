

# intitial
formula = 'mg3h2oh5'
atoms = formula.split(/[0-9]/)
numbers = formula.split(/[A-z]/).reject{|num| num == ''}
hash = {}
atoms.each_with_index do |atom, index|
  hash[atom] = numbers[index]
end
hash