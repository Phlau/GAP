val a_color : Graphics.color array
val x_size_tot : float
val y_size_tot : float
val time_to_size : float -> float -> float -> float
val time_to_start : float -> float -> float
val x_ratio_from_size : float -> float -> float -> float
val y_ratio_from_size : float -> float -> float
val gates_to_start : int -> int -> int -> int
val trace_avion : float -> int -> int -> int -> Classes.avion -> unit
val trace_axe_gate : int -> int -> int -> unit
val trace_axe_temps : float -> int -> int -> unit
val trace : Classes.solution -> Classes.avion array -> float -> unit -> unit
