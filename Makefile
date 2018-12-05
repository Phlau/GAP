#Y aura des rename a faire

projet.x : extraction.cmo classes.cmo
	ocamlc -o projet.x Str.cma classes.cmo extraction.cmo

classe.cmo : classes.ml
	ocamlc -c classes.ml

#pe pas besoin de classe.cmo
extraction.cmo : classes.cmo extraction.ml
	ocamlc -c classes.cmo extraction.ml

#Marche pas
clean :
 	\rm -f *.cmo
