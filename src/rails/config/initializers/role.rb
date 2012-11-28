# role
ROLE = Hash.new

# instance pole pro jednotlice screeny
ROLE['users'] = Hash.new
ROLE['recipes'] = Hash.new
ROLE['articles'] = Hash.new
ROLE['comments'] = Hash.new
ROLE['markings'] = Hash.new
ROLE['ingrediences'] = Hash.new
ROLE['recipeCategories'] = Hash.new
ROLE['ingredienceCategories'] = Hash.new

# pravidla pro funkce jednotlivych screenu
ROLE['users']['index'] =  0
ROLE['users']['show'] =   1
ROLE['users']['edit'] =   2
ROLE['users']['delete'] = 3

ROLE['recipes']['index'] =  4
ROLE['recipes']['show'] =   5
ROLE['recipes']['edit'] =   6
ROLE['recipes']['delete'] = 7

ROLE['articles']['index'] =  8
ROLE['articles']['show'] =   9
ROLE['articles']['edit'] =   10
ROLE['articles']['delete'] = 11

ROLE['comments']['index'] =  12
ROLE['comments']['show'] =   13
ROLE['comments']['edit'] =   14
ROLE['comments']['delete'] = 15

ROLE['markings']['index'] =  12
ROLE['markings']['show'] =   13
ROLE['markings']['edit'] =   14
ROLE['markings']['delete'] = 15

ROLE['ingrediences']['index'] =  16
ROLE['ingrediences']['edit'] =   18
ROLE['ingrediences']['delete'] = 19

ROLE['recipeCategories']['index'] =  20
ROLE['recipeCategories']['edit'] =   22
ROLE['recipeCategories']['delete'] = 23

#ROLE['ingredienceCategories']['index'] =  24
#ROLE['ingredienceCategories']['edit'] =   26
#ROLE['ingredienceCategories']['delete'] = 27