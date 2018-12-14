(*ocamlc  -o projet str.cma classes.ml copie.ml delta.ml extraction.ml neighbours.ml affichage.ml tabu.ml graphics.cma graph.ml main.ml *)


let ()=
  let tabu_size=10 in
  let avion_array=Extraction.extract "gap/gap_flights_difficult2.txt" in
  let gate_array= Tabu.init_gate !(Extraction._NB_GATE) in
  let (solution_best, objectif_best)=Tabu.main_tabu tabu_size avion_array gate_array in
  Affichage.afficher_solution solution_best;
  Printf.printf "FONCTION OBJECTIIIIIF =%d\n" objectif_best;
  Graph.trace solution_best avion_array (float_of_int !(Extraction._NB_GATE));
  Printf.printf "FONCTION OBJECTIIIIIF =%d\n" objectif_best;;
