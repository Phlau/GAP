
type avion = {
    id_avion : int;
  h_arrivee : int; (*Temps en minutes pour le moment*)
  h_depart : int;
  gate_candidate : gate array
  }
and gate = {
    id_gate : int;
  avion_attribue : avion list;
  mutable delta : int;
    mutable conflits : int};; (*Nombre de conflits par Gate*)

type changement =
    Deplacement of avion*gate
  |Switch_2 of avion*avion (*switch=deux deplacements*)
  |Switch_3 of avion*avion*avion;;

type solution = {
    plane_to_gate : int array; (*ieme élément correspond à l'avion i associé à la gate*)
    gates : gate array};;
(*
let avion1 = { id_avion = 1; h_arrivee=10; h_depart = 20; gate_candidate = [|gate1|]}
let avion2 = { id_avion = 2; h_arrivee=10; h_depart = 20; gate_candidate = [|gate1|]};;
avion1.id_avion<-2;;

let gate1 = {id_gate=1;avion_attribue=avion1;delta=0;conflits=0};;
let gate2 = {id_gate=2;avion_attribue=avion2;delta=0;conflits=0};;
*)

(*
let changement_gate = fun change ->
  match change with
    Deplacement (avion1,gate1) -> deplacement_gate avion1 gate1
  |Switch_2 (avion1,avion2) -> switch_gate_2 avion1 avion2
  |Switch_3 (avion1,avion2,avion3) -> switch_gate_3 avion1 avion2 avion3;;*)

(*switch_gate avion1 avion2;;*)


(*Printf.printf "%d\n" avion1.gate_attribuee.id_gate;;
Printf.printf "%d\n" avion2.gate_attribuee.id_gate;;*)


(*changement_gate avion1 gate2;;
  Printf.printf "%d\n" avion1.gate_attribuee.id_gate;;*)

let init_gate = fun id_gate1 ->
  let gate = { id_gate = id_gate1; avion_attribue=[]; delta=0; conflits=0 } in
  gate;; (*on connait pas delta et conflits au départ*)

let init_avion = fun id_avion1 h_arrivee1 h_depart1 gate_candidate1 ->
  let avion = { id_avion = id_avion1; h_arrivee=h_arrivee1; h_depart = h_depart1; gate_candidate = gate_candidate1 } in
  avion;;(*on a pas accès à gate_attribuee*)


let is_tabu = fun change tabu_list ->
  List.mem change tabu_list;; (*renvoie true si change est dans tabu_list*)

let nb_gate = 10;;





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

(*
let fonction_objectif = fun obj_solution -> (*solution est un objet de type solution*)
  let somme_delta=0 in
  let conflits=0 in
  for i=0 to Array.length obj_solution.gates do
    somme_delta = somme_delta + fst (delta obj_solution.gates.(i).avion_attribue);
    conflits = conflits + snd (delta obj_solution.gates.(i).avion_attribue);
    done;
    (somme_delta,conflits);;*)
