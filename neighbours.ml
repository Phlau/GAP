
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
        gates_next.(id_gate_possible).Classes.avion_attribue <- avion_array.(id_avion) :: gates_next.(id_gate_possible).Classes.avion_attribue;

        gates_next.(id_gate_actuel).Classes.avion_attribue<- List.filter (fun x -> x!=avion_array.(id_avion) ) gates_next.(id_gate_actuel).Classes.avion_attribue;

        voisin :=  (fresh,[|[|id_gate_possible;id_gate_actuel;id_avion|]|]):: !voisin;

    done;
  done;
  (*Printf.printf "\n\nTEMPS EXECUTION NEIGHBOURS= %f\n\n" (!t);*)
  Array.of_list !voisin;;

let switch = fun solution_actuelle avion_array ->
  let voisin= ref [] in
  let length_avion=Array.length avion_array  in
  for id_avion1=0 to (length_avion-1) do
    let id_gate_avion1=solution_actuelle.Classes.plane_to_gate.(id_avion1) in
    let gate_possible_avion1=avion_array.(id_avion1).Classes.gate_candidate in
    let id_gate_possible_avion1=List.map (fun gate -> gate.Classes.id_gate) (Array.to_list gate_possible_avion1) in

    for id_avion2=(id_avion1+1) to (length_avion-1) do
      let id_gate_avion2=solution_actuelle.Classes.plane_to_gate.(id_avion2) in
      let gate_possible_avion2=avion_array.(id_avion2).Classes.gate_candidate in
      let id_gate_possible_avion2=List.map (fun gate -> gate.Classes.id_gate) (Array.to_list gate_possible_avion2) in
      if id_gate_avion1 != id_gate_avion2 then
        if (List.mem (id_gate_avion1:int) id_gate_possible_avion2 &&
            List.mem (id_gate_avion2:int) id_gate_possible_avion1) then
          let fresh = Copie.copy_solution solution_actuelle in
          let planes_next=fresh.Classes.plane_to_gate in
          let gates_next=fresh.Classes.gates in
          planes_next.(id_avion1)<-id_gate_avion2;
          planes_next.(id_avion2)<-id_gate_avion1;

          gates_next.(id_gate_avion1).Classes.avion_attribue <-avion_array.(id_avion2) :: gates_next.(id_gate_avion1).Classes.avion_attribue ;

          gates_next.(id_gate_avion1).Classes.avion_attribue<- List.filter (fun x -> x!=avion_array.(id_avion1) ) gates_next.(id_gate_avion1).Classes.avion_attribue;

          gates_next.(id_gate_avion2).Classes.avion_attribue <- avion_array.(id_avion1) :: gates_next.(id_gate_avion2).Classes.avion_attribue;

          gates_next.(id_gate_avion2).Classes.avion_attribue<- List.filter (fun x -> x!=avion_array.(id_avion2) ) gates_next.(id_gate_avion2).Classes.avion_attribue;

          voisin :=  (fresh,[|[|id_gate_avion2;id_gate_avion1;id_avion1|];[|id_gate_avion1;id_gate_avion2;id_avion2|]|]):: !voisin;
    done;
  done;
  Array.of_list !voisin;;

let voisinage=fun solution_actuelle avion_array iter ->
(* match iter mod 2 with*)
  match Random.int 2 with
  |0 ->deplacement_gate solution_actuelle avion_array
 |_ -> switch solution_actuelle avion_array;;


let ordonner_avion_liste = fun avion_liste ->
  let avion_liste_triee = List.sort (fun avion1 avion2 -> if avion1.Classes.h_arrivee>avion2.Classes.h_arrivee then 1 else -1) avion_liste in
  avion_liste_triee;;

let maj_delta_gate=fun gate ->
  gate.Classes.avion_attribue<-ordonner_avion_liste gate.Classes.avion_attribue; (*si ya un probleme  c'est ptet la*)
  let (conflits,delta)= Delta.f_delta gate.Classes.avion_attribue in
  gate.Classes.delta <-delta;
  gate.Classes.conflits <-conflits;;



let maj_delta_voisinage = fun voisinage -> (*voisinage est un tableau de tuple (solution, changement)*)
  let length_voisin= Array.length voisinage in
  for i=0 to (length_voisin-1) do
    let (solution,changement) = voisinage.(i) in
    let length_changement=Array.length changement in
    for k=0 to (length_changement-1) do
      for j=0 to 1 do (*changement est un tableau d'id_portes modifiées*)
        let id_gate_modifiee=changement.(k).(j) in
        maj_delta_gate solution.Classes.gates.(id_gate_modifiee);
      done;
    done;
  done;
  voisinage;;



let best_candidate = fun voisinage fact_delta fact_conflit->
  let id_best_candidate = ref 0 in
  let val_best_candidate = ref (Delta.fonction_objectif (fst (voisinage.(0))) fact_delta fact_conflit) in
  let length=Array.length voisinage in
  for id_candidate=1 to (length-1) do
    let val_candidate = ref (Delta.fonction_objectif (fst (voisinage.(id_candidate))) fact_delta fact_conflit) in
    if val_best_candidate > val_candidate
    then
      begin
        id_best_candidate:=id_candidate;
        val_best_candidate :=!val_candidate;
      end
  done;
  (voisinage.(!id_best_candidate),!val_best_candidate);;
