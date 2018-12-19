val deplacement_gate :
  Classes.solution ->
  Classes.avion array -> (Classes.solution * int array) array
val ordonner_avion_liste : Classes.avion list -> Classes.avion list
val maj_delta_gate : Classes.gate -> unit
val maj_delta_voisinage :
  (Classes.solution * int array) array ->
  (Classes.solution * int array) array
val best_candidate :
  (Classes.solution * 'a) array -> (Classes.solution * 'a) * int
