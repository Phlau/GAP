(* Codage du tabu gÃ©nÃ©rique*)



(* Fonction init provisoire *)

Random.self_init;;
let init = fun p_list ->
  let nbr_avions = List.length p_list in
  let rec init_rec = fun solution ->
    let n =List.length !solution in
    if n=nbr_avions then !solution
    else
      let p = List.nth p_list n in
      let g_c = p.Classes.gate_candidate in
      let g = List.nth g_c (Random.int (List.length g_c)) in
      p.Classes.gate_attribuee <- g ;
      solution := List.append !solution [p];
      init_rec solution; in
  let init=ref [] in
  init_rec init;;


(* Fonction ajoutant et supprimant les changements au tabu *)

let gerer_tabu = fun scourant_changements indice t t_size ->
  let c  = List.nth scourant_changements indice in
  t := List.append !t [c]; 
  while (List.length !t) > t_size do
    let t = List.tl !t in
    ();
  done;;
  
  
(* Fonction donnant le meilleur candidat pour l'itération d'après *)
  
  let rec best_candidate = fun c_list ->
    let (best_c, indice) = List.hd c_list in
    match c_list with
      [] -> (best_c,indice)
    | (s,i)::queue -> if f s < f best_c then
        let best_c = s in
        let indice = i in
        ();
      best_candidate queue ;;
    


  let main_tabu = fun t_size p_list g_list  ->   (* argument = taille de la liste tabu*)

  let s_courant  = init p_list in     
  let s_best = s_courant in
  let t = ref [] in                 
  let nbr_bad_iter = 0 in        

  while nbr_bad_iter <= 10 do     (* critère d'arrêt à régler = nbr d'itératins qui font augmenter la fonction objectif *)

    let candidate_list = [] in
    let (scourant_neighbours, scourant_changements) = Neighbours.neighbours s_courant in      
    let i = ref 0 in
    List.iter2 (fun s c -> incr i ; if not (List.mem c !t)           
    then let candidate_list = (s,i) :: candidate_list in
               ();)
      !scourant_neighbours !scourant_changements;
    let (s_suivant,indice) = best_candidate candidate_list in  
    gerer_tabu scourant_changements indice !t t_size;                 
    let f_suivant = f s_suivant in
    if f_suivant > f s_courant then incr nbr_bad_iter else
      begin
        nbr_bad_iter = 0;
        if f_suivant < (f s_best) then s_best = s_suivant ;
      end;
    s_courant = s_suivant;

    done;

  s_best;;



(*Fonctions à écrire :     
	f (thibaud)
*)



    
    
    
    
      
