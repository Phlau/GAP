(* Pour copier un objet gate *)
let copy_gate=fun gate ->
  let copy={Classes.id_gate=gate.Classes.id_gate;
            Classes.avion_attribue=gate.Classes.avion_attribue;
            Classes.delta=gate.Classes.delta;
            Classes.conflits=gate.Classes.conflits} in
  copy;;


(*Pour copier un array de gate*)
let copy_gates= fun gates->
  let copy= ref [] in
  let length=Array.length gates in
  for i=0 to (length-1) do
    copy:= List.append !copy [copy_gate gates.(i)];
  done;
  Array.of_list !copy;;


(*Pour copier un array d'entier*)
let copy_planes = fun planes->
  let copy= ref [] in
  let length=Array.length planes in
  for i=0 to (length-1) do
    copy:= List.append !copy [planes.(i)];
  done;
  Array.of_list !copy;;


(*Pour deep copy une solution*)
let copy_solution= fun solution ->
  let a = {Classes.plane_to_gate= copy_planes solution.Classes.plane_to_gate;
           Classes.gates=copy_gates solution.Classes.gates} in
  a;;
