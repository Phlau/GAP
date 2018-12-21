(* Pour copier un objet gate *)
let copy_gate=fun gate ->
  let copy={Classes.id_gate=gate.Classes.id_gate;
            Classes.avion_attribue=gate.Classes.avion_attribue;
            Classes.delta=gate.Classes.delta;
            Classes.conflits=gate.Classes.conflits} in
  copy;;


(*Pour copier un array de gate*)
let copy_gates= fun gates->
(*  let copy= ref [] in
  let length=Array.length gates in
  for i=0 to (length-1) do
    copy:= (copy_gate gates.(i)) :: !copy ;
  done;
  Array.of_list (List.rev !copy);;*)
  Array.map copy_gate gates;;


(*Pour deep copy une solution*)
let copy_solution= fun solution ->
  let a = {Classes.plane_to_gate= Array.copy solution.Classes.plane_to_gate;
           Classes.gates=  copy_gates solution.Classes.gates} in
  a;;








