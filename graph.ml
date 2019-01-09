(* Penser a la marge entre 2 traits *)
(* graphics.cma et classes.ml pour la compilation *)
let a_color = [|Graphics.green; Graphics.blue; Graphics.yellow; Graphics.cyan; Graphics.magenta |];;
let x_size_tot = 1440.;;
let y_size_tot = 700.;;

(* Heure en taille pour integrer direct,
   avec la taille global et heure debut/fin  pour savoir (le ratio) et la position *)
let time_to_size = fun h_arr h_dep x_ratio ->
  let x_size_avion = x_ratio *. (h_dep -. h_arr) in
  x_size_avion;;

let time_to_start = fun h_arr x_ratio ->
  let x_start_avion = x_ratio *. (h_arr) in
  x_start_avion;;

(* ATM h_init = 0 et h_final = 24h00 *)
(* Calculer le rapport minutes -> pixels pour longueur du trait *)
let x_ratio_from_size = fun h_init h_final x_size_tot ->
  let x_ratio = x_size_tot/.(h_final-.h_init) in
  x_ratio;;

(* Calcul le rapport nb_gates -> pixels pour largeur des traits *)
let y_ratio_from_size = fun nb_gates y_size_tot ->
  let y_ratio = y_size_tot/.nb_gates in
  y_ratio;;

(* OK : Penser a partir du haut (de base en bas) *)
let gates_to_start = fun i_gate nb_gates y_ratio ->
  let y_start_gate = (nb_gates-1 - i_gate) * y_ratio in
  y_start_gate;;

(* Gestion des conflits : if cursor =! blanc -> rect rouge !!!! *)
let trace_avion = fun x_ratio y_ratio id_gate nb_gates avion ->
  let x_size_avion = time_to_size (float_of_int avion.Classes.h_arrivee) (float_of_int avion.Classes.h_depart) x_ratio in
  let x_start_avion = int_of_float (time_to_start (float_of_int avion.Classes.h_arrivee) x_ratio) in
  let y_start_avion = gates_to_start id_gate nb_gates y_ratio in
  if not (Graphics.point_color x_start_avion y_start_avion = Graphics.white) then Graphics.set_color Graphics.red;
  Graphics.fill_rect x_start_avion y_start_avion (int_of_float x_size_avion) (y_ratio-2); (* Creation d'une marge verticale *)
  Graphics.set_color Graphics.black;
  Graphics.draw_rect x_start_avion y_start_avion (int_of_float x_size_avion) (y_ratio-2);
  let x_id = (x_start_avion * 2 + int_of_float x_size_avion)/2 in
  let y_id = (y_start_avion + gates_to_start (id_gate-1) nb_gates y_ratio)/2 in
  Graphics.moveto (x_id-3) (y_id-5);
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 12;
  Graphics.draw_string (string_of_int avion.Classes.id_avion);;


let trace_axe_gate = fun y_ratio id_gate nb_gates ->
  Graphics.moveto 5 (((gates_to_start id_gate nb_gates y_ratio)+(gates_to_start (id_gate-1) nb_gates y_ratio))/2);
  Graphics.set_text_size 12;
  Graphics.draw_string (string_of_int id_gate);;

let trace_axe_temps = fun x_ratio y_ratio nb_gates ->
  let y = gates_to_start (-1) nb_gates y_ratio in
  let dx = int_of_float (time_to_start (float_of_int 60) x_ratio) in
  for h = 0 to 23 do
    Graphics.moveto (h*dx) y;
    Graphics.set_text_size 12;
    Graphics.draw_string (string_of_int h);
  done

let rec interactive () =
  let event = Graphics.wait_next_event [Graphics.Key_pressed] in
  if event.Graphics.key == 'q' then exit 0
  else print_char event.Graphics.key; print_newline (); interactive ()

let trace = fun solution avions nb_gates ->
  let y_ratio = y_ratio_from_size nb_gates y_size_tot in
  let x_ratio = x_ratio_from_size 0. 1440. x_size_tot in
  let n = Array.length avions in
  Graphics.open_graph " 1440x700";
  Graphics.set_color Graphics.black;
  trace_axe_temps x_ratio (int_of_float y_ratio) (int_of_float nb_gates);
  for j = 0 to (int_of_float nb_gates - 1) do
    trace_axe_gate (int_of_float y_ratio) j (int_of_float nb_gates);
  done;
  for i = 0 to n-1 do  (* On boucle sur les plane_to_gate *)
    let id_gate = solution.Classes.plane_to_gate.(i) in
    Graphics.set_color Graphics.green;
    trace_avion x_ratio (int_of_float y_ratio) id_gate (int_of_float nb_gates) avions.(i);
  done;
  interactive();;



