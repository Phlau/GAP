(* AJOUTER LE str.cma DANS LA COMPIL *)
(* Et surement classes.ml *)
let ouverture = fun file ->
  try
    open_in file
  with exc ->
    Printf.printf "%s ne s'ouvre pas en lecture\n" file;
    raise exc;;

let read_line = fun ligne -> (* Gerer id_avion qui est au format "#01:" *)
  match Str.split (Str.regexp " ") ligne with (* or bounded_split ? *)
    |id :: t_i :: t_f :: gates  -> let gates_list = List.map Classes.init_gate (List.map int_of_string gates) in
            let n = String.length id in
            let id_av = int_of_string (String.sub id 1 (n-2)) in
            let avion = Classes.init_avion id_av (int_of_string t_i) (int_of_string t_f) gates_list in
            avion               (* Ajouter la structure *)
    | _ -> failwith "read_line: unexpected format";;


let extract = fun file ->
  let canal_entree = ouverture file in (*TODO Lire les 3 lignes inutiles du debut*)
  (*let rec extract_rec = fun canal -> (* Essayer de boucler rec jusqu'à la fin du fichier, penser a virer les lignes du debut *)*)
  let lines = ref [] in
  try
    while true; do
      lines := read_line (input_line canal_entree) :: !lines
    done; !lines
  with End_of_file ->
    close_in canal_entree;
    List.rev !lines ;;
