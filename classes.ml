
type avion = {
    id_avion : int;
  h_arrivee : int; (*Temps en minutes pour le moment*)
  h_depart : int;
  gate_candidate : gate array
  }
and gate = {
    id_gate : int;
  mutable avion_attribue : avion list;
  mutable delta : int;
    mutable conflits : int};; (*Nombre de conflits par Gate*)

type changement =
    Deplacement of int array
  |Switch_2 of changement array;;
        (*switch=deux deplacements*)

type solution = {
    plane_to_gate : int array; (*ieme élément correspond à l'avion i associé à la gate*)
    gates : gate array};;


let init_gate = fun id_gate1 ->
  let gate = { id_gate = id_gate1;avion_attribue=[]; delta=0; conflits=0 } in
  gate;; (*on connait pas delta et conflits au départ*)


let init_avion = fun id_avion1 h_arrivee1 h_depart1 gate_candidate1 ->
  let avion = { id_avion = id_avion1; h_arrivee=h_arrivee1; h_depart = h_depart1; gate_candidate = gate_candidate1 } in
  avion;;(*on a pas accès à gate_attribuee*)





(*

let gate0 = init_gate 0;;
let gate1 = init_gate 1;;
let gate2 = init_gate 2;;
let gate3 = init_gate 3;;
let avion0 = init_avion 0 100 20 [|gate0;gate1;gate2;gate3|];;
let avion1 = init_avion 1 9 20 [|gate0;gate1;gate2;gate3|];;
let avion2 = init_avion 2 5 20 [|gate0;gate1;gate2;gate3|];;
let avion3 = init_avion 3 20 20 [|gate0;gate1;gate2;gate3|];;

gate0.avion_attribue<-List.append gate0.avion_attribue [avion0];;
gate1.avion_attribue<-List.append gate1.avion_attribue [avion1];;
gate2.avion_attribue<-List.append gate2.avion_attribue [avion2];;
gate3.avion_attribue<-List.append gate3.avion_attribue [avion3];;
*)
(*let liste_av = [avion0;avion1;avion2;avion3];;
Printf.printf "%d\n" (List.nth (ordonner_avion_liste liste_av) 0).id_avion;;
Printf.printf "%d\n" (List.nth (ordonner_avion_liste liste_av) 1).id_avion;;
Printf.printf "%d\n" (List.nth (ordonner_avion_liste liste_av) 2).id_avion;;
Printf.printf "%d\n" (List.nth (ordonner_avion_liste liste_av) 3).id_avion;;*)

        

(*let avion1 = { id_avion = 1; h_arrivee=10; h_depart = 20; gate_candidate = [|gate1|]};;
let avion2 = { id_avion = 2; h_arrivee=10; h_depart = 20; gate_candidate = [|gate1|]};;
avion1.id_avion<-2;;

let gate1 = {id_gate=1;avion_attribue=avion1;delta=0;conflits=0};;
let gate2 = {id_gate=2;avion_attribue=avion2;delta=0;conflits=0};;

         
  
let changement_gate = fun change ->
  match change with
    Deplacement (avion1,gate1) -> deplacement_gate avion1 gate1
  |Switch_2 (avion1,avion2) -> switch_gate_2 avion1 avion2
  |Switch_3 (avion1,avion2,avion3) -> switch_gate_3 avion1 avion2 avion3;;*)

(*let ordonner_sol = fun sol ->    
  let plane_by_gate = Array.make nb_gate [] in (*10 deviendra nb_gate de florian*)
  for i=0 to List.length sol do
    let avion_i = List.nth sol i in
    plane_by_gate.(avion_i.gate_attribuee.id_gate)<-List.append (plane_by_gate.(avion_i.gate_attribuee.id_gate)) [avion_i];
  done;
  for j=0 to nb_gate do
    plane_by_gate.(j) = List.sort (fun avion1 avion2 -> if avion1.h_arrivee<avion2.h_arrivee then 1 else -1) plane_by_gate.(j);
    done;
  plane_by_gate;;*)
