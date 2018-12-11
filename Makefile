#Y aura des rename a faire

all: projet.x clean

projet.x : classes.cmo extraction.cmo
	ocamlc -o projet.x Str.cma classes.cmo extraction.cmo

classes.cmo : classes.ml
	ocamlc -c classes.ml

extraction.cmo : extraction.ml
	ocamlc -c extraction.ml

.PHONY : clean

clean :
	rm -f *.cmo *.cmi
