# LUA

### Les types natifs

```LUA
print("Hello world !")

-- Commentaires
local my_value = nil
local my_string = "Ma chaîne de caractère"
local my_bool = true | | false

local my_table = {}
my_table.position_x = 10
my_table.position_y = 20

my_table[1] = "My value"
my_table[2] = "My value"

```

### Opérateurs arithmétiques

```LUA
a < b | | a <= b | | a >= b | | a > b

a == b | | a ~= b 
```

### Opérateurs logiques

```LUA
a and b
a or b 
```

### Concaténation

```LUA
print("Hello " .. "World") -- "Hello World"
```

###          

```LUA
-- Conditions 
if a < b then
    print("a < b")
elseif a > b then
    print("a > b")
else
    print("a == b")
end

-- Boucle while
while a < b do
    a = a + 1
end

-- Boucle for
for i = 1, 5 do -- 1, 2, 3, ...
    print(i)
end

for i = 1, 10, 2 do -- 1, 3, 5, ...
    print(i)
end

for k, v in pairs(t) do
    print(k, v)
end

```

### Fonctions

```LUA

function my_function()

end

local my_function = function ()

end

function my_function(my_parameter)

end

function my_function()  
    return "Mon retour de fonction"
end

function my_function()
    return "Premier retour", "Deuxième retour"
end

function my_function (...)
    for key,value in ipairs(arg) do
        printResult = printResult .. tostring(value) .. " "
    end
end

function my_function (my_parameter, ...)

end

```