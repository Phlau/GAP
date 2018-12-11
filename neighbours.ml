let copy = fun liste_avion ->
  let copie = ref [] in
  for i = 0 to (List.length liste_avion ) -1 do
    let avion_init= List.nth liste_avion i in
    copie := List.append !copie [{Classes.id_avion = avion_init.Classes.id_avion;
                                  h_arrivee= avion_init.Classes.h_arrivee;
                                  h_depart = avion_init.Classes.h_depart;
                                  gate_candidate = avion_init.Classes.gate_candidate;
                                  gate_attribuee = avion_init.Classes.gate_attribuee }];
  done;
  copie;;


let neighbours = fun liste_avions ->
  let voisinage= ref [] in
  let voisinage_changements= ref [] in
  let length=List.length liste_avions in
  for i=0 to (length-1) do
    for j=(i+1) to (length-1) do
      let candidat = copy liste_avions in
      let avioni= List.nth !candidat i in
      let avionj= List.nth !candidat j in
      Classes.switch_gate_2 avioni avionj;
      voisinage := List.append !voisinage [!candidat];
      voisinage_changements := List.append !voisinage_changements [(i,j)];
    done;
  done;   
  (voisinage,voisinage_changements);;



(* TEST *)

(*
let gate1 = {Classes.id_gate=1;delta=0;conflits=0};;
let gate2 = {Classes.id_gate=2;delta=0;conflits=0};;
let gate3 = {Classes.id_gate=3;delta=0;conflits=0};;
let gate4 = {Classes.id_gate=4;delta=0;conflits=0};;

let avion1 = {Classes.id_avion = 1; h_arrivee=10; h_depart = 20; gate_candidate = [gate1];gate_attribuee = gate1 };;
let avion2 = {Classes.id_avion = 2; h_arrivee=10; h_depart = 20; gate_candidate = [gate1];gate_attribuee = gate2 };;
let avion3 = { Classes.id_avion = 3; h_arrivee=10; h_depart = 20; gate_candidate = [gate1];gate_attribuee = gate3 };;
let avion4 = { Classes.id_avion = 4; h_arrivee=10; h_depart = 20; gate_candidate = [gate1];gate_attribuee = gate4 };;


let avions = [avion1;avion2;avion3;avion4];;
let test= voisins avions;;

let (testa,testb)= test;;


for i=0 to (List.length !testa -1) do
  let (chang1,chang2) = List.nth !testb i in 
  Printf.printf "candidat %d changement %d %d\n" (i+1) (chang1+1) (chang2+1) ;
  for j=0 to (List.length avions -1) do
    let a = ref (List.nth (List.nth !testa i) j) in
    Printf.printf "avion %d  :" !a.Classes.id_avion;
    Printf.printf "%d\n" !a.Classes.gate_attribuee.Classes.id_gate;
  done;
done;
*)
