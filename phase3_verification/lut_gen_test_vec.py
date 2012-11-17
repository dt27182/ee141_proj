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
fi = open('lut_func_check.vec', 'w')

# Lists of inputs and outputs and corresponding bit length
inputs = ['a_data', 'a_data_b', 'en', 'write', 'ina', 'out_exp']
inputSize = [4, 4, 1, 1, 6, 2]
outputs = ['out']
outputSize = [2]


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

fi.write('io ')
for idx, inp in enumerate(inputs):
	fi.write('i'*inputSize[idx]+' ')
for idx, outp in enumerate(outputs):
	fi.write('o'*outputSize[idx]+' ')
fi.write('\n')

fi.write('tunit ns')
fi.write('\n')

fi.write('tdelay 2 ')
for idx, inp in enumerate(inputs):
	fi.write('0'*inputSize[idx]+' ')
for idx, outp in enumerate(outputs):
	fi.write('1'*outputSize[idx]+' ')
fi.write('\n')

fi.write('slope 1.2')
fi.write('\n')
fi.write('vih 1.2')
fi.write('\n')
fi.write('vil 0.0')
fi.write('\n')
fi.write('vth 0.6')
fi.write('\n')
fi.write('vil 0.0')
fi.write('\n')
fi.write('\n')
####################################
# Now write the actual input vectors
####################################

	
# First, write in the LUT the truth table of the assigned function
# F = (A+B+C+D)(~E+~F+~G+~H)

# Divide the input vector in 
# MSB, used as bit select in the mux chain, and
# LSB, used to adress the SRAM cells
MSB_bits = 2 # This number can change if you re-arrange the SRAM cell
LSB_bits = 4 # This number can change if you re-arrange the SRAM cell
# Question: How many SRAM cells can you write per cycle?
# Answer: More than one (the more cells you write in one cycle, the shorter your total simulation time....)
# 1. Read the output corresponding to F 
for i in range(0, 2**LSB_bits):
	# First, precharge both bitlines
	t_string = str(tcurrent).zfill(4)
	t_string = '%s.0'%(t_string)
	fi.write(t_string+' ')
	for idx, inp in enumerate(inputs):
		if inp == 'en':
			fi.write('0'*inputSize[idx]+' ')		
		else:
			fi.write('x'*inputSize[idx]+' ')
	for idx, outp in enumerate(outputs):
		fi.write('x'*outputSize[idx]+' ')
	fi.write('\n')
	tcurrent = tcurrent + tstep
	inpLSB = bin(i)[2:].zfill(4)
	
	#Do Write
	t_string = str(tcurrent).zfill(4)
	t_string = '%s.0'%(t_string)
	fi.write(t_string+' ')
	# Convert SRAM address into a binary string to be printed in the file
	
	for idx, inp in enumerate(inputs):
		if inp == 'en':
			fi.write('1'*inputSize[idx]+' ')
		elif inp == 'write':
			fi.write('1'*inputSize[idx]+' ')
		elif inp == 'ina':
			fi.write('xx' + inpLSB + ' ')
		elif inp == 'a_data':
			fi.write(str(int(inpLSB[0])))
			fi.write(str(int(inpLSB[1])))
			fi.write(str(int(inpLSB[2])))
			fi.write(str(int(inpLSB[3])))
			fi.write(' ')
		elif inp == 'a_data_b':
			fi.write(str(int(not int(inpLSB[0]))))
			fi.write(str(int(not int(inpLSB[1]))))
			fi.write(str(int(not int(inpLSB[2]))))
			fi.write(str(int(not int(inpLSB[3]))))
			fi.write(' ')
		else:
			fi.write('x'*inputSize[idx]+' ')
	for idx, outp in enumerate(outputs):
		fi.write('x'*outputSize[idx]+' ')
	fi.write('\n')
	tcurrent = tcurrent + tstep

# 2. Read the eight outputs corresponding to the eight 5-input functions
for i in range(0, 2**LSB_bits):
	inpLSB = bin(i)[2:].zfill(4)
	#Precharge
	t_string = str(tcurrent).zfill(4)
	t_string = '%s.0'%(t_string)
	fi.write(t_string+' ')
	for idx, inp in enumerate(inputs):
		if inp == 'en':
			fi.write('0'*inputSize[idx]+' ')			
		else:
			fi.write('x'*inputSize[idx]+' ')
	for idx, outp in enumerate(outputs):
		fi.write('x'*outputSize[idx]+' ')
	fi.write('\n')
	tcurrent = tcurrent + tstep

	#Do Read
	for j in range(0, 2**MSB_bits):
		t_string = str(tcurrent).zfill(4)
		t_string = '%s.0'%(t_string)
		fi.write(t_string+' ')
		inpMSB = bin(j)[2:].zfill(2)
		expected_output = inpLSB[2**MSB_bits - (j+1)] + 'x'
		for idx, inp in enumerate(inputs):
			if inp == 'en':
				fi.write('1'*inputSize[idx]+' ')
			elif inp == 'write':
				fi.write('0'*inputSize[idx]+' ')
			elif inp == 'ina':
				fi.write(inpMSB + inpLSB + ' ')
			elif inp == 'out_exp':
				fi.write(expected_output + ' ')		
			else:
				fi.write('x'*inputSize[idx]+' ')
		for idx, outp in enumerate(outputs):
			if outp == 'out':
				fi.write(expected_output + ' ')
			else:
				fi.write('x'*outputSize[idx]+' ')
		fi.write('\n')
		tcurrent = tcurrent + tstep
	#give time for output to settle before next precharge
	t_string = str(tcurrent).zfill(4)
	t_string = '%s.0'%(t_string)
	fi.write(t_string+' ')
	for idx, inp in enumerate(inputs):
		if inp == 'en':
			fi.write('1'*inputSize[idx]+' ')
		elif inp == 'write':
			fi.write('0'*inputSize[idx]+' ')
		elif inp == 'ina':
			fi.write('xx' + inpLSB + ' ')			
		else:
			fi.write('x'*inputSize[idx]+' ')
	for idx, outp in enumerate(outputs):
		fi.write('x'*outputSize[idx]+' ')
	fi.write('\n')
	tcurrent = tcurrent + tstep
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
