(** Print elements of the solution in the terminal*)

val afficher_plane : int array -> unit
(** [afficher_plane planes] print the planes' id with the corresponding gate in the solution plane_to_gate [planes]*)

val afficher_gates : Classes.gate array -> unit
(** [afficher_gates gates] print the [gates] with it's planes attributed, the number of conflict and the sum of delta*)

val afficher_element_voisinage : Classes.solution * int array -> unit
(** [afficher_element_voisinage solution]*)
    (* TODO Pas fini *)

val afficher_solution : Classes.solution -> unit
(** [afficher_solution solution] print the solution [solution]*)
