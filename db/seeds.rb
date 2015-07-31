routes = [
    [:A, :B, 10],
    [:A, :C, 20],
    [:B, :D, 15],
    [:C, :D, 30],
    [:B, :E, 50],
    [:D, :E, 30]
]

routes.length.times do |i|
  Route.create(
    origin_point: routes[i][0],
    destination_point: routes[i][1],
    distance: routes[i][2]
  )
end