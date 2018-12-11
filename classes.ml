
type avion = {
    mutable id_avion : int;
  h_arrivee : int; (*Temps en minutes pour le moment*)
  h_depart : int;
  mutable gate_candidate : gate list;
  mutable gate_attribuee : gate}
and gate = {
    id_gate : int;
  (*avion_attribue : avion list;*)
  mutable delta : int;
    mutable conflits : int};; (*Nombre de conflits par Gate*)

type changement =
    Deplacement of avion*gate
  |Switch_2 of avion*avion (*switch=deux deplacements*)
  |Switch_3 of avion*avion*avion;;
  

let gate1 = {id_gate=1;delta=0;conflits=0};;
let gate2 = {id_gate=2;delta=0;conflits=0};;

type solution = avion list;;

let avion1 = { id_avion = 1; h_arrivee=10; h_depart = 20; gate_candidate = [gate1];gate_attribuee = gate1 };;
let avion2 = { id_avion = 2; h_arrivee=10; h_depart = 20; gate_candidate = [gate1];gate_attribuee = gate2 };;
avion1.id_avion<-2;;

let deplacement_gate = fun avion gate ->
  avion.gate_attribuee<-gate;;

let switch_gate_2 = fun avion1 avion2 ->
  let gate = avion1.gate_attribuee in
  avion1.gate_attribuee<-avion2.gate_attribuee;
  avion2.gate_attribuee<-gate;;

let switch_gate_3 = fun avion1 avion2 avion3 ->
  let gate1 = avion1.gate_attribuee in
  let gate2= avion2.gate_attribuee in
  avion1.gate_attribuee<-avion3.gate_attribuee;
  avion2.gate_attribuee<-gate1;
  avion3.gate_attribuee<-gate2;;
         
  
let changement_gate = fun change ->
  match change with
    Deplacement (avion1,gate1) -> deplacement_gate avion1 gate1
  |Switch_2 (avion1,avion2) -> switch_gate_2 avion1 avion2
  |Switch_3 (avion1,avion2,avion3) -> switch_gate_3 avion1 avion2 avion3;;

(*switch_gate avion1 avion2;;*)


(*Printf.printf "%d\n" avion1.gate_attribuee.id_gate;;
Printf.printf "%d\n" avion2.gate_attribuee.id_gate;;*)


(*changement_gate avion1 gate2;;
  Printf.printf "%d\n" avion1.gate_attribuee.id_gate;;*)

let init_gate = fun id_gate1 ->
  let gate = { id_gate = id_gate1; delta=0; conflits=0 } in
  gate;; (*on connait pas delta et conflits au départ*)

let init_avion = fun id_avion1 h_arrivee1 h_depart1 gate_candidate1 ->
  let avion = { id_avion = id_avion1; h_arrivee=h_arrivee1; h_depart = h_depart1; gate_candidate = gate_candidate1 ; gate_attribuee = (init_gate 0) } in
  avion;;(*on a pas accès à gate_attribuee*)


let is_tabu = fun change tabu_list ->
  List.mem change tabu_list;; (*renvoie true si change est dans tabu_list*)
 
  
  
  

