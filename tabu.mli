(** Tabu algorithm implementation *)

val init_gate : int -> Classes.gate array
(**[init_gate nbr_gate] initialize an array of gate of lentgh [nbr_gate]*)

val init_solution :
  Classes.avion array -> Classes.gate array -> Classes.solution
(**[init_solution planes_tab gates_tab] initialize a solution using [planes_tab] and [gates_tab]*)

val update_tabu : Classes.solution * Classes.changement -> Classes.changement list ref -> int -> Classes.changement list
(** [update_tabu suivant t t_size] update the tabu [t] of length [t_size] with the new change of voisinage [suivant] *)

val eliminer_tabu : (Classes.solution * Classes.changement) array -> Classes.changement list ref -> (Classes.solution * Classes.changement) array
(** [eliminer_tabu scourant_voisinage t] erase the solution in [s_courant] forbidden by the tabu list [t]*)

val main_tabu :
  int ->
  Classes.avion array ->
  Classes.gate array -> int -> int -> int -> int -> Classes.solution * int
(** [main_tabu t_size p_tab g_tab max_bad_iter max_iter fact_delta fact_conflit] solve the problem using a tabu algorithm with the parameters :
    [t_size] the size of the tabu list, [p_tab] the array of planes, [g_tab] the array of gates, [max_bad_iter] the maximum number of iteration who doesn't improve the solution,
    [max_iter] the maximum number of iteration, [fact_delta] the factor for delta and [fact_conflit] the factor for the conflict in the objective function.
    It return a [Classes.solution] and the result of the objective function*)
