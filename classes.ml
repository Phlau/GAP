
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

let gate1 = {id_gate=1;delta=0;conflits=0};;
let gate2 = {id_gate=2;delta=0;conflits=0};;

(*faire un type changement*)

type solution = avion list;;

let avion1 = { id_avion = 1; h_arrivee=10; h_depart = 20; gate_candidate = [gate1];gate_attribuee = gate1 };;
let avion2 = { id_avion = 2; h_arrivee=10; h_depart = 20; gate_candidate = [gate1];gate_attribuee = gate2 };;
avion1.id_avion<-2;;

let switch_gate = fun avion1 avion2 ->
  let gate = avion1.gate_attribuee in
  avion1.gate_attribuee<-avion2.gate_attribuee;
  avion2.gate_attribuee<-gate;;

(*switch_gate avion1 avion2;;*)


(*Printf.printf "%d\n" avion1.gate_attribuee.id_gate;;
Printf.printf "%d\n" avion2.gate_attribuee.id_gate;;*)

let changement_gate = fun avion gate ->
  avion.gate_attribuee<-gate;;

(*changement_gate avion1 gate2;;
  Printf.printf "%d\n" avion1.gate_attribuee.id_gate;;*)

  let init_gate = fun id_gate1 ->
    let gate = { id_gate = id_gate1; delta=0; conflits=0 } in
    gate;; (*on connait pas delta et conflits au départ*)

    
let init_avion = fun id_avion1 h_arrivee1 h_depart1 gate_candidate1 ->
  let avion = { id_avion = id_avion1; h_arrivee=h_arrivee1; h_depart = h_depart1; gate_candidate = gate_candidate1 ; gate_attribuee = (init_gate 0) } in
  avion;;(*on a pas accès à gate_attribuee*)
