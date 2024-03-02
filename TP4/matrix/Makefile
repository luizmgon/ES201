COMPDIR=/data/niar/Desktop/Recherche/SimpleScalar/bin
SIMDIR=/data/niar/Desktop/Recherche/simplesim-3.0
RESDIR=/home/niar/Desktop/Enseignement/ENSTA/TP/TP_Cache/Version_Individuel/Results
MATSIZE=100

compile:
	$(foreach mulType, normale  tempo unrol pointer, \
	$(COMPDIR)/sslittle-na-sstrix-gcc   -o $(mulType).ss  $(mulType).c ;)

execute1:
	$(foreach mulType, normale tempo pointer, \
	$(foreach size, 128 256 512 , \
	$(SIMDIR)/sim-cache -cache:dl1 dl1:$(size):16:2:l -redir:sim $(RESDIR)/mul_$(mulType)_$(size).res $(mulType).ss ; ))

execute2:
	$(foreach mulType, unrol, \
	$(foreach size, 128 256 512, \
	$(foreach n, 4 8 16, \
	$(SIMDIR)/sim-cache -cache:dl1 dl1:$(size):16:2:l -redir:sim $(RESDIR)/mul_$(mulType)_cache$(size)_n$n.res  $(mulType).ss $n; \
	)))
results:
	grep  "sim_num_insn" $(RESDIR)/mul* > $(RESDIR)/sim_num_insn.txt
	grep  "sim_num_refs" $(RESDIR)/mul* > $(RESDIR)/sim_num_refs.txt
	grep "sim_elapsed_time" $(RESDIR)/mul* > $(RESDIR)/sim_elapsed_time.txt
	grep "dl1.miss_rate" $(RESDIR)/mul* > $(RESDIR)/dl1_miss_rate.txt
	grep "ul2.miss_rate" $(RESDIR)/mul* > $(RESDIR)/ul2.miss_rate.txt
