(** Copying elements *)

val copy_gate : Classes.gate -> Classes.gate
(** [copy_gate gate] return a copy of the gate element [gate]*)

val copy_gates : Classes.gate array -> Classes.gate array
(** [copy_gates gates] return a copy of the gate array [gates]*)

val copy_solution : Classes.solution -> Classes.solution
(** [copy_solution solution] return a deep copy of the element [solution]*)
