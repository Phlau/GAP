
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




