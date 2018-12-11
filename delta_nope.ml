 (*calcule le delta sur une liste avion triée sr l'heure d'arrivée correspondant à une meme porte
  *)
let calc_objectif = fun liste_avion ->
  let conflit = ref 0 in
  let delta= ref 0 in
  let length=List.length liste_avion in
  for i=0 to (length-2) do
    let avioni=List.nth liste_avion i in
    let h_arr_i=avioni.Classes.h_arrivee in
    let h_dep_i=avioni.Classes.h_depart in 
    let avionj=List.nth liste_avion (i+1) in
    let h_arr_j=avionj.Classes.h_arrivee in
    let h_dep_j=avionj.Classes.h_depart in
    let b= min h_dep_i h_dep_j in
    if h_arr_j<b then conflit := !conflit+1
    else delta := !delta + (h_arr_j-b)*(h_arr_j-b)
  done;
  (conflit,delta);;

let gate1 = {Classes.id_gate=1;delta=0;conflits=0};;
let gate2 = {Classes.id_gate=2;delta=0;conflits=0};;
let gate3 = {Classes.id_gate=3;delta=0;conflits=0};;
let gate4 = {Classes.id_gate=4;delta=0;conflits=0};;

let avion1 = {Classes.id_avion = 1; h_arrivee=0; h_depart = 15; gate_candidate = [gate1];gate_attribuee = gate1 };;
let avion2 = {Classes.id_avion = 2; h_arrivee=10; h_depart = 20; gate_candidate = [gate1];gate_attribuee = gate2 };;
let avion3 = { Classes.id_avion = 3; h_arrivee=30; h_depart = 40; gate_candidate = [gate1];gate_attribuee = gate3 };;
let avion4 = { Classes.id_avion = 4; h_arrivee=60; h_depart = 80; gate_candidate = [gate1];gate_attribuee = gate4 };;


let avions = [avion1;avion2;avion3;avion4] in
let (conflit,delt)= calc_objectif avions in
Printf.printf "Nbr conflit : %d  \n" !conflit;
Printf.printf "Delta : %d \n " !delt;;
