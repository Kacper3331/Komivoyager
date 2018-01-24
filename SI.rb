$routes = Hash.new
$cities = []
$number_of_cities = 50
$number_of_mutations = 1000

#Stworzenie miast oraz nadanie odległości między nimi
def create_cities
  for i in 1..$number_of_cities do
    $cities.push("c#{i}")
  end

  i = 1

  for i in 1..$number_of_cities do
    for j  in i..$number_of_cities do
      if (i != j)
        random_distance = ((Random.new.rand(123) + Random.new.rand(122)) * Random.new.rand(20))
        $routes["cities#{i}-#{j}"] = ["c#{i}", "c#{j}", random_distance]
        $routes["cities#{j}-#{i}"] = ["c#{j}", "c#{i}", random_distance]
      end
    end
  end
end

#Losowe rozmieszczenie miast
def randomize_cities(cities)
  cities.shuffle!
end

#Obliczenie długości trasy
def calculate_distance(cities)
  distance = 0

  $routes.each do |item|
    for i in 0..(cities.length-1) do
      if item[1][0] == cities[i] && item[1][1] == cities[i+1]
        distance += item[1][2]
      end
    end
  end

  distance
end

#Wybranie dwóch losowych miast
def random_cities
  city_a = Random.new.rand(0..$number_of_cities-1)
  city_b = Random.new.rand(0..$number_of_cities-1)

  if city_a == city_b
    city_b = Random.new.rand(0..$number_of_cities-1)
  end

  [city_a, city_b]
end

#Zamiana miejsc dwóch losowo wybranych wcześniej miast
def change_places(cities, city_ids)
  city = cities[city_ids[0]]
  cities[city_ids[0]] = cities[city_ids[1]]
  cities[city_ids[1]] = city

  cities
end

#Główna metoda
def main
  create_cities()

  first_route = randomize_cities($cities)
  first_distance = calculate_distance(first_route)

  puts "First route: \n #{first_route}"
  puts "Distance: #{first_distance}"

  next_route = first_route
  next_distance = 0

  for i in 0..$number_of_mutations do
    cities = random_cities()

    first_distance = calculate_distance(first_route)
    next_distance = calculate_distance(change_places(next_route, cities))

    if (next_distance < first_distance)
      first_route = next_route
      next_route = first_route
    else
      change_places(next_route, cities)
    end
  end

  puts "Last route: \n #{next_route}"
  puts "Distance: #{next_distance}"
end

main()

#Przykładowe wyniki:

# Dla liczby mutacji 100:
# Liczba miast: 50

# First route:
#  ["c31", "c47", "c32", "c7", "c18", "c44", "c26", "c8", "c48", "c33", "c9", "c37", "c36", "c25", "c19", "c10", "c5",
#   "c39", "c35", "c22", "c27", "c42", "c24", "c49", "c38", "c45", "c1", "c16", "c30", "c46", "c15", "c41", "c40", "c3",
#   "c17", "c12", "c6", "c21", "c20", "c11", "c50", "c4", "c2", "c13", "c23", "c29", "c43", "c14", "c28", "c34"]
# Distance: 60310

# Last route:
#  ["c31", "c39", "c16", "c46", "c35", "c44", "c1", "c8", "c48", "c33", "c25", "c37", "c22", "c40", "c4", "c11", "c5", "c26",
#   "c45", "c36", "c20", "c50", "c18", "c30", "c28", "c24", "c47", "c32", "c13", "c7", "c15", "c41", "c14", "c3", "c17", "c42",
#   "c6", "c21", "c38", "c10", "c12", "c19", "c2", "c49", "c23", "c29", "c43", "c9", "c27", "c34"]
# Distance: 28142

# Dla liczby mutacji 1000:
# Liczba miast: 50

# First route:
#  ["c29", "c4", "c18", "c15", "c37", "c27", "c45", "c38", "c34", "c2", "c11", "c7", "c47", "c24", "c41", "c39", "c6",
#   "c23", "c13", "c22", "c28", "c17", "c5", "c16", "c44", "c32", "c9", "c14", "c30", "c46", "c40", "c48", "c33", "c21",
#   "c3", "c42", "c12", "c31", "c26", "c1", "c10", "c49", "c36", "c20", "c25", "c50", "c35", "c8", "c43", "c19"]
# Distance: 52067

# Last route:
#  ["c25", "c43", "c2", "c4", "c9", "c27", "c37", "c38", "c8", "c28", "c21", "c47", "c41", "c42", "c16", "c5", "c6", "c14",
#   "c22", "c39", "c45", "c1", "c48", "c24", "c11", "c7", "c34", "c35", "c36", "c23", "c40", "c20", "c33", "c3", "c13", "c26",
#   "c12", "c31", "c18", "c17", "c46", "c49", "c10", "c50", "c29", "c15", "c19", "c30", "c44", "c32"]
# Distance: 12244

# Dla liczby mutacji 10000:
# Liczba miast: 50

# First route:
#  ["c2", "c36", "c14", "c15", "c22", "c11", "c9", "c49", "c21", "c30", "c40", "c23", "c7", "c38", "c6", "c48", "c26",
#   "c5", "c31", "c29", "c32", "c44", "c45", "c13", "c50", "c34", "c37", "c43", "c20", "c4", "c41", "c17", "c19", "c42",
#   "c25", "c39", "c12", "c18", "c8", "c33", "c28", "c16", "c47", "c35", "c46", "c3", "c27", "c24", "c10", "c1"]
# Distance: 54488

# Last route:
#  ["c2", "c44", "c14", "c28", "c22", "c34", "c50", "c37", "c15", "c48", "c7", "c23", "c38", "c40", "c3", "c12", "c20",
#   "c5", "c8", "c27", "c4", "c21", "c43", "c6", "c29", "c11", "c42", "c10", "c31", "c33", "c41", "c19", "c1", "c36",
#   "c18", "c49", "c9", "c13", "c25", "c17", "c16", "c26", "c46", "c35", "c47", "c39", "c30", "c24", "c32", "c45"]
# Distance: 8829
