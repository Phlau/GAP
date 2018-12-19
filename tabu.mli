val init_gate : int -> Classes.gate array
val init_solution :
  Classes.avion array -> Classes.gate array -> Classes.solution
val update_tabu : 'a * 'b -> 'b list ref -> int -> 'b list
val eliminer_tabu :
  ('a * 'b array) array -> 'b array list ref -> ('a * 'b array) array
val main_tabu :
  int -> Classes.avion array -> Classes.gate array -> Classes.solution * int
