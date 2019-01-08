 (*calcule le delta sur une liste avion triée sur l'heure d'arrivée correspondant à une meme porte
  *)

let f_delta = fun liste_avion ->
  let conflit = ref 0 in
  let delta= ref 0 in
  let rec calc = fun liste conflit delta ->
    match liste with
    []|[_]->  (conflit,delta)
    |x1::x2::xf ->  let h_dep_1=x1.Classes.h_depart in 
      let h_arr_2=x2.Classes.h_arrivee in
      let h_dep_2=x2.Classes.h_depart in
      let b= min h_dep_1 h_dep_2 in
      if h_arr_2<b then calc (x2::xf) (conflit+1) delta
      else calc (x2::xf) conflit (delta + (h_arr_2-b)*(h_arr_2-b))
  in
  calc liste_avion !conflit !delta;;

(*calcule la valeur de la fonction objectif sur une solution dont les deltas et conflits sont a jour*)
let fonction_objectif = fun obj_solution fact_delta fact_conflit -> (*solution est un objet de type solution*)
  let somme_delta= ref 0 in
  let conflits=ref 0 in
  for i=0 to (Array.length obj_solution.Classes.gates-1) do 
    somme_delta := !somme_delta + obj_solution.Classes.gates.(i).Classes.delta;
    conflits := !conflits + obj_solution.Classes.gates.(i).Classes.conflits;
    done;
  fact_delta * !somme_delta + fact_conflit * !conflits;;



