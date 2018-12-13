(* Attendre le clic pour enlever la fenetre *)
(* Penser a la marge entre 2 traits *)
(* graphics.cma et classes.ml pour la compilation *)
let a_color = [|Graphics.black; Graphics.red; Graphics.green; Graphics.blue;
                Graphics.yellow; Graphics.cyan; Graphics.magenta |]
let x_size_tot = 1200;;
let y_size_tot = 700;;

Graphics.open_graph " 1200x700";;
Graphics.set_color a_color.(1);;
Graphics.fill_rect 0 0 100 300;;
(* Graphics.moveto 50 150 *)
Graphics.set_color a_color.(5);;
Graphics.fill_rect 50 150 100 300;;

Unix.sleep 5;; (* En attendant le clic *)

Graphics.close_graph;;
(* Heure en taille pour integrer direct,
   avec la taille global et heure debut/fin  pour savoir (le ratio) et la position *)
let time_to_size = fun h_dep h_fin x_ratio ->
  let x_size_avion = x_ratio * (h_fin - h_dep) in
  x_size_avion;;


(* Calculer le rapport minutes -> pixels pour longueur du trait *)
let x_ratio_from_size = fun h_init h_final x_size_tot ->
  let x_ratio = x_size_tot/(h_final-h_init) in
  x_ratio;;


(* Calcul le rapport nb_gates -> pixels pour largeur des traits *)
let y_ratio_from_size = fun nb_gates y_size_tot ->
  let y_ratio = y_size_tot/nb_gates in
  y_ratio;;
