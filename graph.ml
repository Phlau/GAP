(* Penser a la marge entre 2 traits *)
(* graphics.cma et classes.ml pour la compilation *)
let a_color = [|Graphics.black; Graphics.red; Graphics.green; Graphics.blue;
                Graphics.yellow; Graphics.cyan; Graphics.magenta |];;
let x_size_tot = 1200;;
let y_size_tot = 700;;

(* Heure en taille pour integrer direct,
   avec la taille global et heure debut/fin  pour savoir (le ratio) et la position *)
let time_to_size = fun h_arr h_dep x_ratio ->
  let x_size_avion = x_ratio * (h_dep - h_arr) in
  x_size_avion;;

let time_to_start = fun h_arr x_ratio ->
  let x_start_avion = x_ratio * h_arr in
  x_start_avion;;

(* ATM h_init = 0 et h_final = 24h00 *)
(* Calculer le rapport minutes -> pixels pour longueur du trait *)
let x_ratio_from_size = fun h_init h_final x_size_tot ->
  let x_ratio = x_size_tot/(h_final-h_init) in
  x_ratio;;

(* Calcul le rapport nb_gates -> pixels pour largeur des traits *)
let y_ratio_from_size = fun nb_gates y_size_tot ->
  let y_ratio = y_size_tot/nb_gates in
  y_ratio;;

(* OK : Penser a partir du haut (de base en bas) *)
let gates_to_start = fun i_gate y_ratio ->
  let y_start_gate = (Extraction._NB_GATE-1 - i_gate) * y_ratio in
  y_start_gate;;

let trace_avion = fun x_ratio y_ratio id_gate avion ->
  let x_size_avion = time_to_size avion.h_arrivee avion.h_depart x_ratio in
  let x_start_avion = time_to_start avion.h_arrivee x_ratio in
  let y_start_gate = gates_to_start id_gate y_ratio in
  Graphics.fill_rect x_start_avion y_start_gate x_size_avion y_ratio;;

let trace = fun solution ->
  let y_ratio = y_ratio_from_size Extraction._NB_GATE y_size_tot in
  let x_ratio = x_ratio_from_size 0 1440 x_size_tot in
  for i = startval to endval do (* Ou pattern matching ? *)(* Boucle sur les gates ou les !!avions_to_gate!! ?*)
  done
  let trace_rec = rec fun ->
    0





(* ---------------------Pour la phase de test---------------------*)
let gate0 = Classes.init_gate 0;;
let gate1 = Classes.init_gate 1;;
let gate2 = Classes.init_gate 2;;
let gate3 = Classes.init_gate 3;;

let avion0 = Classes.init_avion 0 10 20 [|gate0;gate1;gate2;gate3|];;
let avion1 = Classes.init_avion 1 10 20 [|gate0;gate1;gate2;gate3|];;
let avion2 = Classes.init_avion 2 30 40 [|gate0;gate1;gate2;gate3|];;
let avion3 = Classes.init_avion 3 30 40 [|gate0;gate1;gate2;gate3|];;

gate0.Classes.avion_attribue<-List.append gate0.Classes.avion_attribue [avion0;avion2];;
gate1.Classes.avion_attribue<-List.append gate1.Classes.avion_attribue [avion1;avion3];;
gate2.Classes.avion_attribue<-List.append gate2.Classes.avion_attribue [];;
gate3.Classes.avion_attribue<-List.append gate3.Classes.avion_attribue [];;

let avions = [|avion0;avion1;avion2;avion3|];;
let solution_actuelle={Classes.plane_to_gate=[|0;0;1;1|];
                       Classes.gates= [|gate0;gate1;gate2;gate3|]};;
(* --------------------Fin de la phase de test--------------------*)


(* ------------------Ex d'utilisation de Graphics-----------------*)
(*
Graphics.open_graph " 1200x700";;
Graphics.set_color a_color.(1);;
Graphics.fill_rect 0 0 100 300;;
(* Graphics.moveto 50 150 *) (* Pas besoin pour fill *)
Graphics.set_color a_color.(5);;
Graphics.fill_rect 50 150 100 300;;

Unix.sleep 5;; (* En attendant le clic *)

Graphics.close_graph;;
*)
