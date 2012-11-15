import os
import math

# Define constants to be used in the script
tunit = 'ns' # Unit of measure for time
tstep = 3 # Time step
slope = 0.01 # Rising fall time
vih = 1.2 # High voltage level
vil = 0.0 # Low voltage level
vth = (vih+vil)/2. # Threshold voltage

# Initialize time
tcurrent = 0

# Create the file
fi = open('func_check.vec', 'w')

# Lists of inputs and outputs and corresponding bit length
inputs = ['data', 'data_b', 'en', 'write', 'InA', 'InB', 'InC', 'InD', 'ax', 'bx', 'cx', 'cin', 'asout', 'bsout', 'csout', 'dsout']
inputSize = [16, 16, 1, 1, 6, 6, 6, 6, 1, 1, 1, 1, 2, 2, 2, 2]
outputs = ['out', 'out_exp', 'cout', 'cout_exp']
outputSize = [8, 8, 1, 1]


# Write file header
# 1. radix
# 2. Signal names
# 3. io
# 4. tdelay
# 5. tunit
# 6. slope
# 7. vih
# 8. vil
# 9. vth

fi.write('radix ')
for idx, inp in enumerate(inputs):
	fi.write('1'*inputSize[idx]+' ')
for idx, outp in enumerate(outputs):
	fi.write('1'*outputSize[idx]+' ')
fi.write('\n')

fi.write('vname ')
for idx, inp in enumerate(inputs):
	if inputSize[idx] > 1:
		fi.write(inp+'<['+str(inputSize[idx]-1)+':0]> ')
	else:
		fi.write(inp+' ')
for idx, outp in enumerate(outputs):
	if outputSize[idx] > 1:
		fi.write(outp+'<['+str(outputSize[idx]-1)+':0]> ')
	else:
		fi.write(outp+' ')
fi.write('\n')

###################################
# Write here the rest of the header
###################################

# ----------------------------------

####################################
# Now write the actual input vectors
####################################

	
# First, write in the LUT the truth table of the assigned function
# F = (A+B+C+D)(~E+~F+~G+~H)

# Divide the input vector in 
# MSB, used as bit select in the mux chain, and
# LSB, used to adress the SRAM cells
MSB_bits = 4 # This number can change if you re-arrange the SRAM cell
LSB_bits = 4 # This number can change if you re-arrange the SRAM cell
# Question: How many SRAM cells can you write per cycle?
# Answer: More than one (the more cells you write in one cycle, the shorter your total simulation time....)
for i in range(0, 2**LSB_bits):
	# First, precharge both bitlines
	# Create string for time
   	t_string = str(tcurrent).zfill(4)
   	t_string = '%s.0'%(t_string)
	fi.write(t_string+' ')
	# Assign 0 to the en signal (pre-charge) and don't care to all other signals
	for idx, inp in enumerate(inputs):
		if inp == 'en':
			fi.write('0'*inputSize[idx]+' ')
		else:
			fi.write('x'*inputSize[idx]+' ')
	for idx, outp in enumerate(outputs):
		fi.write('x'*outputSize[idx]+' ')
	fi.write('\n')
	tcurrent = tcurrent + tstep

	# Convert SRAM address into a binary string to be printed in the file
	inpLSB = bin(i)[2:].zfill(4)
	
	#############################
	# Now you need to create strings to set data and data_b, compute F and activate the correct cell in the LUT to write into
	#############################

#################################################
# Now you need to create vectors to test also the
# other conditions listed in the project write-up
#################################################

# 1. Read the output corresponding to F 
for i in range(0, 2**(LSB_bits+MSB_bits)):
	pass
# 2. Read the eight outputs corresponding to the eight 5-ipunt functions

# 3. Re-program the LUT to sum vectors X and W

# 4. Read the results of the addition for all combinations of X and W

fi.close()
