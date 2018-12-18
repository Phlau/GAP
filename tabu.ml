(* Codage du tabu générique*)

let init_gate=fun nbr_gate ->
  let gates=ref[] in
  for id_gate=0 to (nbr_gate-1) do
    gates:=List.append !gates [Classes.init_gate id_gate];
  done;
  Array.of_list !gates;;



(*Random.init (int_of_float (Unix.time()));;*)
Random.init 15;;
let init_solution = fun planes_tab gates_tab ->
  let nbr_avions = Array.length planes_tab in
  let plane_to_gate =ref [] in
  for id_avion=0 to (nbr_avions-1) do
    let plane = planes_tab.(id_avion) in
    let plane_gate_candidat = plane.Classes.gate_candidate in
    let index_gate_random= ref (Random.int (Array.length plane_gate_candidat )) in
    let id_gate_random = ref plane_gate_candidat.(!index_gate_random).Classes.id_gate in
    plane_to_gate := List.append !plane_to_gate [!id_gate_random];
    gates_tab.(!id_gate_random).Classes.avion_attribue <- List.append gates_tab.(!id_gate_random).Classes.avion_attribue [planes_tab.(id_avion)];
  done;
  let solution={Classes.plane_to_gate = (Array.of_list !plane_to_gate);
                Classes.gates = gates_tab} in
  let nbr_gates=Array.length gates_tab in
  for id_gate=0 to (nbr_gates-1) do
    Neighbours.maj_delta_gate gates_tab.(id_gate);
  done;
  solution;;





let update_tabu = fun suivant t t_size ->
  let (solution, changement) = suivant in
   t := List.append !t [changement];
  while (List.length !t) > t_size do
    t := List.tl !t ;
  done;
  !t;;
(*
l = ref [];
i = ref 0 ;
matchi with
|t_size -> l
|n -> incr i ;
*)

let eliminer_tabu = fun scourant_voisinage t ->
  let bons_voisins_list = ref [] in
  for i=0 to (Array.length scourant_voisinage)-1 do
    let (solution, changement) = scourant_voisinage.(i) in
    let changement_inverse =[|changement.(1);changement.(0);changement.(2)|] in
    if not (List.mem changement_inverse !t) then
      bons_voisins_list :=  (solution,changement) ::  !bons_voisins_list;
  done;
  let scourant_candidate_voisins = Array.of_list !bons_voisins_list in
  scourant_candidate_voisins;;



let main_tabu = fun t_size p_tab g_tab  ->   (* argument = taille de la liste tabu*)

  let s_courant  = ref (init_solution p_tab g_tab) in
  let f_courant = ref (Delta.fonction_objectif !s_courant) in
  let s_best = ref (Copie.copy_solution !s_courant) in
  let f_best = ref !f_courant in
  let t = ref [] in
  let nbr_bad_iter = ref 0 in
  let iter=ref 0 in
  while !nbr_bad_iter <= 1000 && !iter < 100 do     (* crit�re d'arr�t � r�gler = nbr d'it�ratins qui font augmenter la fonction objectif *)
    iter:=!iter+1;
    let t1=Unix.gettimeofday() in
    let scourant_voisinage = ref (Neighbours.deplacement_gate !s_courant p_tab) in   (* renvoie un voisinga (array de tuples (solution, array(id_gate debut,id_gate fin, avion))*)
    let t2=Unix.gettimeofday() in
    let scourant_voisinage_maj= ref (Neighbours.maj_delta_voisinage !scourant_voisinage) in
    let t3=Unix.gettimeofday() in
    let scourant_candidate_voisins = ref (eliminer_tabu !scourant_voisinage_maj t) in
    let t4=Unix.gettimeofday() in
    let best_candidate=ref (Neighbours.best_candidate !scourant_candidate_voisins) in
    let t5=Unix.gettimeofday() in
    let s_suivant=ref (fst !best_candidate) in
    let f_suivant =ref (snd !best_candidate) in  (*Surement probleme faut mettre ref*)
    t := update_tabu !s_suivant t t_size;
    let t6=Unix.gettimeofday() in
    if !f_suivant > !f_courant then incr nbr_bad_iter
    else
    begin
      if !f_suivant < !f_best then
        begin
          s_best := fst !s_suivant ;
          f_best := !f_suivant ;
          nbr_bad_iter := 0 ;
        end;
    end;
    s_courant := fst  !s_suivant;
    f_courant := !f_suivant;

  (*  Printf.printf "t2-t1 =%f \nt3-t2 =%f \nt4-t3 =%f \nt5-t4 =%f \nt6-t5 =%f" (t2-.t1) (t3-.t2) (t4-.t3) (t5-.t4) (t6-.t5);*)
  done;
  Printf.printf "NOMBRE ITERATION =%d" !iter;
  (!s_best, !f_best);;
