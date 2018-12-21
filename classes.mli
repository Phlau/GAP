(** This module is made to group important types that is used in our program *)

type avion = {
  id_avion : int;
  h_arrivee : int;
  h_depart : int;
  gate_candidate : gate array;
}
and gate = {
  id_gate : int;
  mutable avion_attribue : avion list;
  mutable delta : int;
  mutable conflits : int;
}

type changement =
    Deplacement of gate * gate
  | Switch_2 of gate * gate
  | Switch_3 of gate * gate * gate

type solution = { plane_to_gate : int array; gates : gate array; }

val init_gate : int -> gate
(** [init_gate id] return a [gate] initialized with it's id at [id] ([delta] and [conflits] = 0,[avion_attribue] = empty list) *)

val init_avion : int -> int -> int -> gate array -> avion
(** [init_gate id t_arrival t_departure gates_candidate] return an [avion] initialized with id at [id], h_arrivee at [t_arrival], h_depart at [t_departure] and gate_candidate at [gates_candidate] *)

val is_tabu : 'a -> 'a list -> bool
(** [is_tabu change tabu_list] return the boolean [true] if [change] is in [tabu_list] *)
