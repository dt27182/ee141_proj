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
inputs = ['a_data', 'a_data_b', 'b_data', 'b_data_b','c_data', 'c_data_b','d_data', 'd_data_b','en', 'write', 'ina', 'inb', 'inc', 'ind', 'ax', 'bx', 'cx', 'cin', 'asout', 'bsout', 'csout', 'dsout', 'out_exp', 'cout_exp']
inputSize = [4, 4, 4, 4, 4, 4, 4, 4, 1, 1, 6, 6, 6, 6, 1, 1, 1, 1, 2, 2, 2, 2, 8, 1]
outputs = ['out', 'cout']
outputSize = [8, 1]


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
MSB_bits = 4 # This number can change if you re-arrange the SRAM cell
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
	
	#Do Write
	t_string = str(tcurrent).zfill(4)
	t_string = '%s.0'%(t_string)
	fi.write(t_string+' ')
	# Convert SRAM address into a binary string to be printed in the file
	inpLSB = bin(i)[2:].zfill(4)
	# Compute LUT SRAM write values
	LUT_SRAM_values = []
	for j in range(0, 2**MSB_bits):
		inpMSB = bin(j)[2:].zfill(4)
		LUT_SRAM_values.append((int(inpLSB[0]) or int(inpLSB[1]) or int(inpLSB[2]) or int(inpLSB[3])) and ((not int(inpMSB[0])) or (not int(inpMSB[1])) or (not int(inpMSB[2])) or (not int(inpMSB[3]))))
	for idx, inp in enumerate(inputs):
		if inp == 'en':
			fi.write('1'*inputSize[idx]+' ')
		elif inp == 'write':
			fi.write('1'*inputSize[idx]+' ')
		elif inp == 'ina' or inp == 'inb' or inp == 'inc' or inp == 'ind':
			fi.write('xx' + inpLSB + ' ')
		elif inp == 'a_data':
			fi.write(str(int(LUT_SRAM_values[3])))
			fi.write(str(int(LUT_SRAM_values[2])))
			fi.write(str(int(LUT_SRAM_values[1])))
			fi.write(str(int(LUT_SRAM_values[0])))
			fi.write(' ')
		elif inp == 'b_data':
			fi.write(str(int(LUT_SRAM_values[7])))
			fi.write(str(int(LUT_SRAM_values[6])))
			fi.write(str(int(LUT_SRAM_values[5])))
			fi.write(str(int(LUT_SRAM_values[4])))
			fi.write(' ')
		elif inp == 'c_data':
			fi.write(str(int(LUT_SRAM_values[11])))
			fi.write(str(int(LUT_SRAM_values[10])))
			fi.write(str(int(LUT_SRAM_values[9])))
			fi.write(str(int(LUT_SRAM_values[8])))
			fi.write(' ')
		elif inp == 'd_data':
			fi.write(str(int(LUT_SRAM_values[15])))
			fi.write(str(int(LUT_SRAM_values[14])))
			fi.write(str(int(LUT_SRAM_values[13])))
			fi.write(str(int(LUT_SRAM_values[12])))
			fi.write(' ')
		elif inp == 'a_data_b':
			fi.write(str(int(not LUT_SRAM_values[3])))
			fi.write(str(int(not LUT_SRAM_values[2])))
			fi.write(str(int(not LUT_SRAM_values[1])))
			fi.write(str(int(not LUT_SRAM_values[0])))
			fi.write(' ')
		elif inp == 'b_data_b':
			fi.write(str(int(not LUT_SRAM_values[7])))
			fi.write(str(int(not LUT_SRAM_values[6])))
			fi.write(str(int(not LUT_SRAM_values[5])))
			fi.write(str(int(not LUT_SRAM_values[4])))
			fi.write(' ')
		elif inp == 'c_data_b':
			fi.write(str(int(not LUT_SRAM_values[11])))
			fi.write(str(int(not LUT_SRAM_values[10])))
			fi.write(str(int(not LUT_SRAM_values[9])))
			fi.write(str(int(not LUT_SRAM_values[8])))
			fi.write(' ')
		elif inp == 'd_data_b':
			fi.write(str(int(not LUT_SRAM_values[15])))
			fi.write(str(int(not LUT_SRAM_values[14])))
			fi.write(str(int(not LUT_SRAM_values[13])))
			fi.write(str(int(not LUT_SRAM_values[12])))
			fi.write(' ')
		else:
			fi.write('x'*inputSize[idx]+' ')
	for idx, outp in enumerate(outputs):
		fi.write('x'*outputSize[idx]+' ')
	fi.write('\n')
	tcurrent = tcurrent + tstep


# 2a. Read 8 LUT output
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
	for j in range(0, 2**MSB_bits):
		#Do Read
		inpMSB = bin(j)[2:].zfill(4)
		t_string = str(tcurrent).zfill(4)
		t_string = '%s.0'%(t_string)
		fi.write(t_string+' ')
		expected_output = str(int((int(inpLSB[0]) or int(inpLSB[1]) or int(inpLSB[2]) or int(inpLSB[3])) and ((not int(inpMSB[0])) or (not int(inpMSB[1])) or (not int(inpMSB[2])) or (not int(inpMSB[3])))))
		for idx, inp in enumerate(inputs):
			if inp == 'en':
				fi.write('1'*inputSize[idx]+' ')
			elif inp == 'write':
				fi.write('0'*inputSize[idx]+' ')
			elif inp == 'ina' or inp == 'inb' or inp == 'inc' or inp == 'ind':
				fi.write(inpMSB[2] + inpMSB[3] + inpLSB + ' ')
			elif inp == 'asout' or inp == 'bsout' or inp == 'csout' or inp == 'dsout':
				fi.write('01' + ' ')
			elif inp == 'ax' or inp == 'bx':
				fi.write(inpMSB[1] + ' ')
			elif inp == 'cx':
				fi.write(inpMSB[0] + ' ')
			elif inp == 'out_exp':
				fi.write('x'*3 + expected_output + 'x'*4 + ' ')		
			else:
				fi.write('x'*inputSize[idx]+' ')
		for idx, outp in enumerate(outputs):
			if outp == 'out':
				fi.write('x'*3 + expected_output + 'x'*4 + ' ')
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
		else:
			fi.write('x'*inputSize[idx]+' ')
	for idx, outp in enumerate(outputs):
		fi.write('x'*outputSize[idx]+' ')
	fi.write('\n')
	tcurrent = tcurrent + tstep
"""
# 2b. Read 5 LUT outputs
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
	for j in range(0, 2**(MSB_bits - 3)):
		#Do Read
		t_string = str(tcurrent).zfill(4)
		t_string = '%s.0'%(t_string)
		fi.write(t_string+' ')
		expected_outputs = ''
		for k in range (0, 2**(MSB_bits - 1)):
			inpMSB = bin(k)[2:].zfill(3) + str(j)
			expected_output = str(int((int(inpLSB[0]) or int(inpLSB[1]) or int(inpLSB[2]) or int(inpLSB[3])) and ((not int(inpMSB[0])) or (not int(inpMSB[1])) or (not int(inpMSB[2])) or (not int(inpMSB[3])))))
			expected_outputs = expected_outputs + expected_output
		expected_outputs = expected_outputs[::-1]
		for idx, inp in enumerate(inputs):
			if inp == 'en':
				fi.write('1'*inputSize[idx]+' ')
			elif inp == 'write':
				fi.write('0'*inputSize[idx]+' ')
			elif inp == 'ina' or inp == 'inb' or inp == 'inc' or inp == 'ind':
				fi.write('1' + str(j) + inpLSB + ' ')
			elif inp == 'asout' or inp == 'bsout' or inp == 'csout' or inp == 'dsout':
				fi.write('00' + ' ')
			elif inp == 'out_exp':
				fi.write(expected_outputs + ' ')		
			else:
				fi.write('x'*inputSize[idx]+' ')
		for idx, outp in enumerate(outputs):
			if outp == 'out':
				fi.write(expected_outputs + ' ')
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
		else:
			fi.write('x'*inputSize[idx]+' ')
	for idx, outp in enumerate(outputs):
		fi.write('x'*outputSize[idx]+' ')
	fi.write('\n')
	tcurrent = tcurrent + tstep
"""
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
