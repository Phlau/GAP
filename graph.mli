(** Display the solution found on a graphic window *)

val a_color : Graphics.color array
(** [a_color] regroup in an array all the non special colors ([red] is for errors, and [black] for standard plotting)*)
(*
val x_size_tot : float
(* The x size of the window*)

val y_size_tot : float
(* The y size of the window*) *)
    (*
val time_to_size : float -> float -> float -> float

val time_to_start : float -> float -> float

val x_ratio_from_size : float -> float -> float -> float

val y_ratio_from_size : float -> float -> float

val gates_to_start : int -> int -> int -> int

val trace_avion : float -> int -> int -> int -> Classes.avion -> unit

val trace_axe_gate : int -> int -> int -> unit

val trace_axe_temps : float -> int -> int -> unit
    *)
val trace : Classes.solution -> Classes.avion array -> float -> unit -> unit
(**[trace solution avions nb_gates] display the current [solution] (which have the data [avions] array and the number of gates [nb_gates]) *)
