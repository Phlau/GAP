(** Extract the data from files like [gap_flights1.txt]*)

val _NB_GATE : int ref
(** [_NB_GATE] is the number of the last gate (The number of gate + the one unused)*)

val _NB_AVION : int ref
(** [_NB_AVION] is the number of planes*)

val heure_to_min_int : string -> int
(** [heure_to_min_int heure_string] convert the hour [heure_string] (string format) in minutes (int format) *)

val read_line : string -> Classes.avion
(** [read_line line] take a line [line] from a data file and return an [avion] corresponding to that line *)

val extract : string -> Classes.avion array
(** [extract file] return the [avion] array from the data [file] (like [gap_flights1.txt])*)
