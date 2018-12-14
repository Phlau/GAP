
(*Pour renvoyer tous les voisins ayant juste la gate d'un avion qui change*)
let deplacement_gate = fun solution_actuelle avion_array->
  let voisin=ref [] in
  let length_avion=Array.length avion_array  in
  for id_avion=0 to (length_avion-1) do
    let id_gate_actuel=solution_actuelle.Classes.plane_to_gate.(id_avion) in
    let gate_possible=avion_array.(id_avion).Classes.gate_candidate in
    let length_gate=Array.length gate_possible in
    for i=0 to (length_gate-1) do
      let id_gate_possible=gate_possible.(i).Classes.id_gate in
      if id_gate_actuel!=id_gate_possible then
        let fresh = Copie.copy_solution solution_actuelle in
        let planes_next=fresh.Classes.plane_to_gate in
        let gates_next=fresh.Classes.gates in
        planes_next.(id_avion)<-id_gate_possible;
        gates_next.(id_gate_possible).Classes.avion_attribue <- List.append gates_next.(id_gate_possible).Classes.avion_attribue [avion_array.(id_avion)];
        gates_next.(id_gate_actuel).Classes.avion_attribue<- List.filter (fun x -> x!=avion_array.(id_avion) ) gates_next.(id_gate_actuel).Classes.avion_attribue;
        voisin := List.append !voisin [(fresh,[|id_gate_possible;id_gate_actuel;id_avion|])];
    done;
  done;
  Array.of_list !voisin;;

let ordonner_avion_liste = fun avion_liste ->
  let avion_liste_triee = List.sort (fun avion1 avion2 -> if avion1.Classes.h_arrivee>avion2.Classes.h_arrivee then 1 else -1) avion_liste in
  avion_liste_triee;;

let maj_delta_gate=fun gate ->
  gate.Classes.avion_attribue<-ordonner_avion_liste gate.Classes.avion_attribue; (*si ya un probleme  c'est ptet la*)
  let (conflits,delta)= Delta.f_delta gate.Classes.avion_attribue in
  gate.Classes.delta <-delta;
  gate.Classes.conflits <-conflits;;

    

let maj_delta_voisinage = fun voisinage -> (*voisinage est un tableau de tuple (solution, changement)*)
  let length= Array.length voisinage in
  for i=0 to (length-1) do
    let (solution,changement) = voisinage.(i) in
    for j=0 to 1 do (*changement est un tableau d'id_portes modifiées*)
      let id_gate_modifiee=changement.(j) in
      maj_delta_gate solution.Classes.gates.(id_gate_modifiee);
    done;
  done;
  voisinage;;



let best_candidate = fun voisinage ->
  let id_best_candidate = ref 0 in
  let val_best_candidate = ref (Delta.fonction_objectif (fst (voisinage.(0)))) in
  let length=Array.length voisinage in
  for id_candidate=1 to (length-1) do
    let val_candidate = ref (Delta.fonction_objectif (fst (voisinage.(id_candidate)))) in
    if val_best_candidate > val_candidate
    then
      begin
        id_best_candidate:=id_candidate;
        val_best_candidate :=!val_candidate;
      end
  done;
  (voisinage.(!id_best_candidate),!val_best_candidate);;




