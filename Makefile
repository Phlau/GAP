#Y aura des rename a faire

projet.x : extraction.cmo classe.cmo
	ocamlc -o projet.x classe.cmo extraction.cmo

classe.cmo : classe.ml
	ocamlc -c classe.ml

#pe pas besoin de classe.cmo
extraction.cmo : classe.cmo extraction.ml
	ocamlc -c classe.cmo extraction.ml

clean :
 \rm -f *.cmo
