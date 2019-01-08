#Y aura des rename a faire
#Penser à ajouter le reste
#Et le MLI !!!!

# ocamlc  -o projet str.cma classes.ml copie.ml delta.ml extraction.ml neighbours.ml
	# affichage.ml tabu.ml graphics.cma graph.ml main.ml

COMPILE = ocamlc
COMPILEOPT = ocamlopt -unsafe
CSLDEP = ocamldep
CAMLDOC = ocamldoc

TARGET = projet.x
TARGETOPT = projetopt.x
NORM_FILES = classes.ml copie.ml delta.ml extraction.ml neighbours.ml affichage.ml tabu.ml graph.ml main.ml
NORM_OBJS = $(NORM_FILES:.ml=.cmo)
OPT_OBJS = $(NORM_FILES:.ml=.cmx)
LIBS = graphics.cma str.cma unix.cma

all: .depend $(TARGET)

doc:
	mkdir doc;$(CAMLDOC) -html -t "GAP" -d doc -intro Intro -hide Pervasives *.mli

opt: $(TARGETOPT)

$(TARGET): $(NORM_OBJS)
	$(COMPILE) -o $@ $(LIBS) $(NORM_OBJS)

$(TARGETOPT) : $(OPT_OBJS)
	$(COMPILEOPT) -o $@ $(LIBS:.cma=.cmxa) $(OPT_OBJS)

.SUFFIXES: .ml .mli .cmo .cmi .cmx

.mli.cmi :
	$(COMPILE) -c $<

.ml.cmo :
	$(COMPILE) -c $<

.ml.cmx :
	$(COMPILEOPT) -c $<



.PHONY : clean

clean :
	rm -f *.cmo *.cmi *.cmx *.o

.depend:
	$(CSLDEP) *.mli *.ml >.depend

include .depend
