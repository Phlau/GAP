

let ouverture = fun file ->
  try
    open_in file
  with exc ->
    Printf.printf "%s ne s'ouvre pas en lecture\n" file;
     raise exc;;
