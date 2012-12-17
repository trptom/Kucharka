# role
ROLE = Hash.new

# instance pole pro jednotlice screeny
ROLE['users'] = Hash.new
ROLE['recipes'] = Hash.new
ROLE['articles'] = Hash.new
ROLE['comments'] = Hash.new
ROLE['marks'] = Hash.new
ROLE['ingrediences'] = Hash.new
ROLE['recipeCategories'] = Hash.new
ROLE['ingredienceCategories'] = Hash.new

# pravidla pro funkce jednotlivych screenu
ROLE['users']['index'] =  1 << 0
ROLE['users']['show'] =   1 << 1
ROLE['users']['edit'] =   1 << 2
ROLE['users']['delete'] = 1 << 3
ROLE['users']['edit_rights'] = 1 << 4
ROLE['users']['block'] = 1 << 5
ROLE['users']['unblock'] = 1 << 6

ROLE['recipes']['create'] =  1 << 7
ROLE['recipes']['show'] =   1 << 8
ROLE['recipes']['edit'] =   1 << 9
ROLE['recipes']['delete'] = 1 << 10

ROLE['articles']['create'] =  1 << 11
ROLE['articles']['show'] =   1 << 12
ROLE['articles']['edit'] =   1 << 13
ROLE['articles']['delete'] = 1 << 14

ROLE['comments']['create'] =  1 << 15
ROLE['comments']['edit'] =   1 << 16
ROLE['comments']['delete'] = 1 << 17

ROLE['marks']['index'] =  1 << 18
ROLE['marks']['create'] =  1 << 19
ROLE['marks']['show'] =   1 << 20
ROLE['marks']['edit'] =   1 << 21
ROLE['marks']['delete'] = 1 << 22

ROLE['ingrediences']['create_delete'] =  1 << 23
ROLE['ingrediences']['edit'] =   1 << 24

ROLE['recipeCategories']['create_delete'] =  1 << 25
ROLE['recipeCategories']['edit'] =   1 << 26

ROLE['ingredienceCategories']['create_delete'] = 27
ROLE['ingredienceCategories']['edit'] = 28