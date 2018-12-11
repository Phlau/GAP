(* AJOUTER LE str.cma DANS LA COMPIL *)
(* Et surement classes.ml *)

let NB_GATE = ref 0;;
let NB_AVION = ref 0;;

let ouverture = fun file ->
  try
    open_in file
  with exc ->
    Printf.printf "%s ne s'ouvre pas en lecture\n" file;
    raise exc;;

let heure_to_min_int = fun t ->
  let t_split = String.split_on_char ':' t in
  let t_fin = int_of_string (List.hd t_split)*60 + int_of_string (List.nth t_split 1) in
  t_fin;;

let read_line = fun ligne -> (* Gerer id_avion qui est au format "#01:" *)
  match Str.split (Str.regexp " ") ligne with (* String.split_on_char pas possible car ocaml 4.02.1 *)
    |id :: t_i :: t_f :: gates  -> let gates_list = List.map Classes.init_gate (List.map int_of_string gates) in
            let last_gate = List.nth gates_list ((List.length gates_list)-1) in
            if !nb_gate < last_gate.id_gate then nb_gate := last_gate.id_gate;
            NB_AVION := !NB_AVION + 1;
            let n = String.length id in
            let id_av = int_of_string (String.sub id 1 (n-2)) in
            let avion = Classes.init_avion id_av (heure_to_min_int t_i) (heure_to_min_int t_f) gates_list in
            avion
    | _ -> failwith "read_line: unexpected format";;


let extract = fun file ->
  let canal_entree = ouverture file in
  let lines = ref [] in
  let buf = ref (input_line canal_entree) in
  buf := input_line canal_entree;
  buf := input_line canal_entree;
  try
    while true; do
      lines := read_line (input_line canal_entree) :: !lines
    done; !lines
  with End_of_file ->
    close_in canal_entree;
    let avions = List.rev !lines in
    avions;;
