(*ocamlc  -o projet str.cma unix.cma classes.ml copie.ml delta.ml extraction.ml neighbours.ml affichage.ml tabu.ml graphics.cma graph.ml main.ml *)


let ()=
  let tabu_size=200 in
  let max_bad_iter=1000 in
  let max_iter=1000 in
  let fact_delta=1 in
  let fact_conflit=50000 in
  let avion_array=Extraction.extract "gap/gap_flights1.txt" in
  let gate_array= Tabu.init_gate !(Extraction._NB_GATE) in
  let t1=Unix.gettimeofday() in
  let (solution_best, objectif_best)=Tabu.main_tabu tabu_size avion_array gate_array max_bad_iter max_iter fact_delta fact_conflit in
  let t2=Unix.gettimeofday() in
  Affichage.afficher_solution solution_best;
  Printf.printf "FONCTION OBJECTIIIIIF =%d\n" objectif_best;
   Printf.printf "TEMPS EXECUTION = %f\n" (t2-.t1);;
(*Graph.trace solution_best avion_array (float_of_int !(Extraction._NB_GATE));
  Printf.printf "FONCTION OBJECTIIIIIF =%d\n" objectif_best;;*)
