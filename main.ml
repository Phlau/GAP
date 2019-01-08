let ()=
  let tabu_size=200 in   (* taille de la liste tabu *)
  let max_bad_iter=1000 in (* nombre maximum d'itérations sans découverte de nouvelle solution *)
  let max_iter=10000 in    (* nombre maximum d'itérations *)
  let fact_delta=1 in     (* importance donnée à la somme des delta au carré *)
  let fact_conflit=50000 in  (*importance donnée au nombre de conflits *)
  let avion_array=Extraction.extract "/gap/gap_flights5.txt" in
  let gate_array= Tabu.init_gate !(Extraction._NB_GATE) in
  let t1=Unix.gettimeofday() in
  let (solution_best, objectif_best)=Tabu.main_tabu tabu_size avion_array gate_array max_bad_iter max_iter fact_delta fact_conflit in
  let t2=Unix.gettimeofday() in
  Affichage.afficher_solution solution_best;
  Printf.printf "FONCTION OBJECTIF =%d\n" objectif_best;
  Printf.printf "TEMPS EXECUTION = %f\n" (t2-.t1);
  Graph.trace solution_best avion_array (float_of_int !(Extraction._NB_GATE));
  Printf.printf "\nTERMINE\n";;
