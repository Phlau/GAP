(* Codage du tabu gÃ©nÃ©rique*)

(**)
let init_gate=fun nbr_gate ->
  let gates=ref[] in
  for id_gate=0 to (nbr_gate-1) do
    gates:=List.append !gates [Classes.init_gate id_gate];
  done;
  Array.of_list !gates;;


(*Random.init (int_of_float (Unix.time()));;*)
Random.init 15;;

(*Renvoie une solution aléatoire*)
let init_solution = fun planes_tab gates_tab ->
  let nbr_avions = Array.length planes_tab in
  let plane_to_gate =ref [] in
  for id_avion=0 to (nbr_avions-1) do
    let plane = planes_tab.(id_avion) in
    let plane_gate_candidat = plane.Classes.gate_candidate in
    let index_gate_random= ref (Random.int (Array.length plane_gate_candidat )) in (*choisit un index aleatoire dans le tableau des portes candidates*)
    let id_gate_random = ref plane_gate_candidat.(!index_gate_random).Classes.id_gate in
    plane_to_gate := List.append !plane_to_gate [!id_gate_random];
    gates_tab.(!id_gate_random).Classes.avion_attribue <- List.append gates_tab.(!id_gate_random).Classes.avion_attribue [planes_tab.(id_avion)];
  done;
  let solution={Classes.plane_to_gate = (Array.of_list !plane_to_gate);
                Classes.gates = gates_tab} in
  let nbr_gates=Array.length gates_tab in
  for id_gate=0 to (nbr_gates-1) do
    Neighbours.maj_delta_gate gates_tab.(id_gate);(*calcule les conflits et delta de la solution aleatoire*)
  done;
  solution;;

(*ajoute le changement lié a la solution suivante au tabu et enleve des elements a la liste si sa taille maximale est atteinte*)
let update_tabu = fun suivant t t_size ->
  let changement = (snd  suivant) in
  t := List.append !t [changement];
  while (List.length !t) > t_size do
    t := List.tl !t ;
  done;
  !t;;

(*Supprime les solutions du voisinage interdites par la liste tabu*)
let eliminer_tabu = fun scourant_voisinage t ->
 (* let bons_voisins_list = ref [] in
  for i=0 to (Array.length scourant_voisinage)-1 do
    let (solution, changement) = scourant_voisinage.(i) in
    if not (List.mem (changement : int array array) !t) then
      bons_voisins_list :=  (solution,changement) ::  !bons_voisins_list;
  done;
  let scourant_candidate_voisins = Array.of_list !bons_voisins_list in
  scourant_candidate_voisins;;*)
Array.of_list (List.filter (fun x -> not (List.mem (snd x) !t)  )  (Array.to_list scourant_voisinage) );;



let main_tabu = fun t_size p_tab g_tab max_bad_iter max_iter fact_delta fact_conflit->   (* argument = taille de la liste tabu*)
  let nbr_amelioration= ref 0 in
  let s_courant  = ref (init_solution p_tab g_tab) in
  let f_courant = ref (Delta.fonction_objectif !s_courant fact_delta fact_conflit) in
  let s_best = ref (Copie.copy_solution !s_courant) in
  let f_best = ref !f_courant in
  let t = ref [] in (*initialisation de la liste tabu*)
  let nbr_bad_iter = ref 0 in        
  let iter=ref 0 in
  while !nbr_bad_iter <= max_bad_iter && !iter < max_iter do     (* nbr_bad_iter = nbr d'itératins qui n'augmentent pas la fonction objectif *)
    iter:=!iter+1;
    let scourant_voisinage = ref (Neighbours.voisinage  !s_courant p_tab !iter) in (*calcul du voisinage*)

    (* voisinage = liste de (solution, changement) où changement  = array d'array de int, soit un switch soit un déplacement*)

    let scourant_voisinage_maj= ref (Neighbours.maj_delta_voisinage !scourant_voisinage) in (*met a jour les deltats et conflits des voisins*)
(*a inverser peut etre*)
    let scourant_candidate_voisins = ref (eliminer_tabu !scourant_voisinage_maj t) in (*supprime les voisins interdits*)
    let best_candidate=ref (Neighbours.best_candidate !scourant_candidate_voisins fact_delta fact_conflit) in (*best_candidate = ((solution, changement),val_fonction_obj)*)
    let s_suivant=ref (fst !best_candidate) in (*s_suivant = (solution, changement)*)
    let f_suivant =ref (snd !best_candidate) in  
    t := update_tabu !s_suivant t t_size;
    incr nbr_bad_iter;

    if (!f_suivant:int ) < !f_best then
      begin
        s_best := fst !s_suivant ;
        f_best := !f_suivant ;
        nbr_bad_iter := 0 ;
        incr nbr_amelioration;
      end;
    s_courant := fst !s_suivant;
    f_courant := !f_suivant;
    Printf.printf " NOMBRE ITERATION =%07d NOMBRE AMELIORATION = %07d  BEST Solution =%07d\r" !iter !nbr_amelioration !f_best;
    flush stdout;(*force l'ecriture sur le terminal*)
  done;
  (!s_best, !f_best);;





    
 
    
    
      
