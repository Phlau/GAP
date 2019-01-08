(** Objective function *)

val f_delta : Classes.avion list -> int * int
(** [f_delta liste_avion] calculate the number of conflict and the time between each plane on the same gate of the element [liste_avion]*)

val fonction_objectif : Classes.solution -> int -> int -> int
(** [fonction_objectif solution fact_delta fact_conflit] return the value of the objective function for the solution element [solution] with the factor [fact_delta] for the delta between planes and [fact_conflit] for the conflict*)
