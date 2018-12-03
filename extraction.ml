(* AJOUTER LE str.cma DANS LA COMPIL *)

let ouverture = fun file ->
  try
    open_in file
  with exc ->
    Printf.printf "%s ne s'ouvre pas en lecture\n" file;
    raise exc;;

let read_line = fun ligne ->
  match Str.split (Str.regexp " ") ligne with (* or bounded_split ? *)
    id :: t_i :: t_f :: gates  -> (* Ajouter la structure *)
    |_ -> failwith "read_line: unexpected format";;


let extract = fun file ->
  let canal_entree = ouverture file in
  let rec extract_rec = fun canal -> (* Essayer de boucler rec jusqu'à la fin du fichier, penser a virer les lignes du debut *)
