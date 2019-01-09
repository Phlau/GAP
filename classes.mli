(** This module is made to group important types that are used in the program *)

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

type changement = int array array

type solution = { plane_to_gate : int array; gates : gate array; }

val init_gate : int -> gate
(** [init_gate id] return a [gate] initialized with it's id at [id] ([delta] and [conflits] = 0,[avion_attribue] = empty list) *)

val init_avion : int -> int -> int -> gate array -> avion
(** [init_gate id t_arrival t_departure gates_candidate] return an [avion] initialized with id at [id], h_arrivee at [t_arrival], h_depart at [t_departure] and gate_candidate at [gates_candidate] *)
