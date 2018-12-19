#Y aura des rename a faire
#Penser à ajouter le reste
#Et le MLI !!!!

# ocamlc  -o projet str.cma classes.ml copie.ml delta.ml extraction.ml neighbours.ml
	# affichage.ml tabu.ml graphics.cma graph.ml main.ml

COMPILE = ocamlc
COMPILEOPT = ocamlopt -unsafe
CSLDEP=ocamldep
TARGET = projet.x
TARGETOPT = projetopt.x
NORM_FILES= classes.ml copie.ml delta.ml extraction.ml neighbours.ml affichage.ml tabu.ml graph.ml main.ml
NORM_OBJS =  $(NORM_FILES:.ml=.cmo)
OPT_OBJS=  $(NORM_FILES:.ml=.cmx)
LIBS= graphics.cma str.cma unix.cma

all: .depend bytes

bytes: $(TARGET)

opt: $(TARGETOPT)

$(TARGET): $(NORM_OBJS)
	$(COMPILE) -o $@ $(LIBS) $(NORM_OBJS)

$(TARGETOPT) : $(OPT_OBJS)
	$(COMPILEOPT) -o $@ $(LIBS:.cma=.cmxa) $(OPT_OBJS)

.SUFFIXES: .ml .cmo .cmx .mli .cmi

.ml.cmo :
	$(COMPILE) -c $<

.ml.cmx :
	$(COMPILEOPT) -c $<

.mli.cmi :
	$(COMPILE) -c $<


.PHONY : clean

clean :
	rm -f *.cmo *.cmi *.cmx *.o

.depend:
	$(CSLDEP) *.mli *.ml >.depend

include .depend

# all: projet.x clean
#
# projet.x : classes.cmo extraction.cmo
# 	ocamlc -o projet.x Str.cma classes.cmo extraction.cmo
#
# classes.cmo : classes.ml
# 	ocamlc -c classes.ml
#
# extraction.cmo : extraction.ml
# 	ocamlc -c extraction.ml
