# Routes API

API to calculate the shortest path and the cost to a given route (origin point and destination point), based on fuel price and truck's autonomy.

# Installation
###### **Considering you already have a ruby development environment setup.**

```bash
git clone https://bitbucket.org/mdsrosa/routes_api.git
cd routes_api
bundle install
```

### Running local server
```bash
rackup -p 4567 -s puma
```

# Endpoints

#### GET /routes

This is endpoint lists all routes in the database.

#### cURL Example

```bash
$ curl http://localhost:4567/routes
```
#### Response Example
```bash
[{"id":1,"origin_point":"A","destination_point":"B","distance":10},
 {"id":2,"origin_point":"A","destination_point":"C","distance":20},
 {"id":3,"origin_point":"B","destination_point":"D","distance":15},
 {"id":4,"origin_point":"C","destination_point":"D","distance":30},
 {"id":5,"origin_point":"B","destination_point":"E","distance":50},
 {"id":6,"origin_point":"D","destination_point":"E","distance":30},
 {"id":7,"origin_point":"A","destination_point":"B","distance":10},
 {"id":8,"origin_point":"A","destination_point":"C","distance":20},
 {"id":9,"origin_point":"B","destination_point":"D","distance":15},
 {"id":10,"origin_point":"C","destination_point":"D","distance":30},
 {"id":11,"origin_point":"B","destination_point":"E","distance":50},
 {"id":12,"origin_point":"D","destination_point":"E","distance":30}]
```

#### POST /routes
TODO

#### POST /routes/calculate-cost

This is endpoint calculates the cost.

#### Attributes

Name            | Type | Description | Example
----------------|------|------------ |--------
**origin_point**|string| The point of origin| `"A"`
**destination_point**|string| The point of destination| `"D"`
**autonomy**| integer|The vehicle's autonomy| `10`
**fuel_price**| float|The fuel price|`2.5`

##### cURL Example
```bash
$ curl -X POST http://localhost:4567/routes/calculate-cost \
-H "Content-Type: application/json" \
-d '{"origin_point": "A", "destination_point": "D", 
	  "autonomy": 10, "fuel_price": 2.5}'
```
#### Response Example
```json
{"cost":6.25,"route":"A B D"}
```


# Testing
```bash
rake test
```