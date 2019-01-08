(** Used for all the neighbours processing *)

val deplacement_gate :
  Classes.solution ->
  Classes.avion array -> (Classes.solution * int array array) array
(** [deplacement_gate solution_actuelle avion_array] use the solution [solution_actuelle] and the avion array [avion_array] to return all the neighbours where only a plane change of gate*)

val switch :
  Classes.solution ->
  Classes.avion array -> (Classes.solution * int array array) array
(** [switch solution_actuelle avion_array] use the solution [solution_actuelle] and the avion array [avion_array] to return all the neighbours where only two planes switch gates*)

val voisinage :
  Classes.solution ->
  Classes.avion array -> int -> (Classes.solution * int array array) array
(** [voisinage solution_actuelle avion_array iter] use the solution [solution_actuelle] and the avion array [avion_array] to explore the neighbours randomly or using [iter] to select either a switch or a deplacement*)

val ordonner_avion_liste : Classes.avion list -> Classes.avion list
(** [ordonner_avion_liste avion_liste] sort the plane list [avion_liste] by the arrival order*)

val maj_delta_gate : Classes.gate -> unit
(** [maj_delta_gate gate] update the delta between planes and the conflict of the gate [gate]*)

val maj_delta_voisinage :
  (Classes.solution * int array array) array ->
  (Classes.solution * int array array) array
(** [maj_delta_voisinage voisinage] update the delta between planes and the conflict of all the gates of the neighbours [voisinage]*)

val best_candidate :
  (Classes.solution * int array array) array ->
  int -> int -> (Classes.solution * int array array) * int
(** [best_candidate voisinage fact_delta fact_conflit] use the voisinage [voisinage], the [fact_delta] and the [fact_conflit] to return the best neighbours*)
