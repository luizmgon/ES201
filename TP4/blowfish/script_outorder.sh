#!/bin/bash

SIM_PROFILE=/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-profile
SIM_OUT_ORDER=/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-outorder
SIM_CACHE=/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-cache

PRG_SS="bf.ss e input_small.asc output_small.enc 1234567890abcdeffedcba0987654321"

mkdir -p simu_out

A7_IL2="-cache:il2 dl2"
A7_DL2="-cache:dl2 ul2:2048:32:8:l"
A15_IL2="-cache:il2 dl2"
A15_DL2="-cache:dl2 ul2:512:64:16:l"

for SIZE in 16 32 64 128 256
do
	OPTIONS="-bpred bimod -fetch:mplat 8 -fetch:ifqsize 4 -decode:width 2 -issue:width 4 -commit:width 2 -ruu:size 2 -lsq:size 8 -res:ialu 1 -res:fpalu 1 -res:fpmult 1 -res:imult 1"
	A7_IL1="-cache:il1 il1:$SIZE:32:2:l"
	A7_DL1="-cache:dl1 dl1:$SIZE:32:2:l"
	REDIR_OUT_SIMU1="-redir:sim simu_out/simu_cache_A7_${SIZE}.out"
	$SIM_OUT_ORDER $OPTIONS $A7_IL1 $A7_DL1 $A7_IL2 $A7_DL2 $REDIR_OUT_SIMU1 $PRG_SS
done

for SIZE in 16 32 64 128 256
do
	OPTIONS="-bpred 2lev -fetch:mplat 15 -fetch:ifqsize 8 -decode:width 4 -issue:width 8 -commit:width 4 -ruu:size 16 -lsq:size 16 -res:ialu 5 -res:fpalu 1 -res:imult 1 -res:fpmult 1"
	A15_IL1="-cache:il1 il1:$SIZE:64:2:l"
	A15_DL1="-cache:dl1 dl1:$SIZE:64:2:l"
	REDIR_OUT_SIMU="-redir:sim simu_out/simu_cache_A15_${SIZE}.out"
	$SIM_OUT_ORDER $OPTIONS $A15_IL1 $A15_DL1 $A15_IL2 $A15_DL2 $REDIR_OUT_SIMU $PRG_SS
done
	

