### String concatenation ###
"Hello " <> "world"

### Boolean operatiors ###
# or, and, not
true and true
false or is_atom(:atom)
1 and true # ERROR, cause not boolean
# or, and are shourt-circuit operators
# they only execute the right side if the left side is not enough to determine the result

# ||, &&, !
# excepts all types
# all values except of false and nil will evaluate to true
1 || true
false || 11

# RULE: 
#	  Use and, or, not if you are expecting booleans
#   Use &&, || and ! if any of your arguments is non-boolean

### Comparison operators
# ==, !=, ===, !==, <=, >=, <, >
# works as expected
# But we can also do stuff like
1 < :atom
# camparison of datatypes has this order:
# number < atom < reference < function < port < pid < tuple < map < list < bitstring