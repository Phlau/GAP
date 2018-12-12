(* Attendre le clic pour enlever la fenetre *)

let x_size_tot = 1200;;
let y_size_tot = 700;;

Graphics.open_graph " 1200x700";;
Graphics.set_color Graphics.blue;;
Graphics.fill_rect 0 0 100 300;;

Unix.sleep 5;;

Graphics.close_graph;;
(* Heure en taille pour integrer direct,
   avec la taille global et heure debut/fin  pour savoir (le ratio) et la position *)
let time_to_size = fun h_dep h_fin x_size y_size ->
