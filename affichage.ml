
let afficher_plane = fun plane ->
  let length = Array.length plane in
  for i=0 to (length-1) do
    Printf.printf "Avion %d : porte %d\n" i plane.(i);
  done;
  Printf.printf "\n";
;;
let afficher_gates = fun gates ->
  let length = Array.length gates in
  for i=0 to (length-1) do
    Printf.printf "gate %d : " i;
    let length_avion=List.length gates.(i).Classes.avion_attribue in
    for j=0 to (length_avion-1) do
      let avion = ref (List.nth gates.(i).Classes.avion_attribue j) in
      Printf.printf "Avion %d " !avion.Classes.id_avion ;
    done;
    Printf.printf "\nConflits= %d Delta =%d\n\n" gates.(i).Classes.conflits gates.(i).Classes.delta
  done;
;;
let afficher_element_voisinage = fun solution ->
  let (sol,chang) = solution in
  let plane=sol.Classes.plane_to_gate in
  let gates=sol.Classes.gates in
  Printf.printf "Gates impactées : %d %d\n" chang.(0) chang.(1);
  Printf.printf "Avion concerné  : %d \n\n" chang.(2);
  afficher_plane plane;
  afficher_gates gates;;

let afficher_solution = fun solution ->
  let plane=solution.Classes.plane_to_gate in
  let gates=solution.Classes.gates in
  afficher_plane plane;
  afficher_gates gates;;
