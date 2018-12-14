#Y aura des rename a faire
#Penser à ajouter le reste

# ocamlc  -o projet str.cma classes.ml copie.ml delta.ml extraction.ml neighbours.ml
	# affichage.ml tabu.ml graphics.cma graph.ml main.ml

COMPILE = ocamlc
CSLDEP=ocamldep
TARGET = projet.x
NORM_FILES= classes.ml copie.ml delta.ml extraction.ml neighbours.ml affichage.ml tabu.ml graph.ml main.ml
NORM_OBJS =  $(NORM_FILES:.ml=.cmo)
LIBS= graphics.cma str.cma

all: .depend bytes

bytes: $(TARGET)

$(TARGET): $(NORM_OBJS)
	$(COMPILE) -o $@ $(LIBS) $(NORM_OBJS)

.SUFFIXES: .ml .cmo


.ml.cmo :
	$(COMPILE) -c $<


.PHONY : clean

clean :
	rm -f *.cmo *.cmi

.depend:
	$(CSLDEP) *.ml >.depend

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
