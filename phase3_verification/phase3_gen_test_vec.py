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
fi = open('input_checkpoint.vec', 'w')

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

fi.write('slope ' + str(slope)) 
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

# 3.
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
	#LUT_SRAM_values = []
	x_value = []
	w_value = []
	for j in range(0, 2):
		#inpMSB = bin(j)[2:].zfill(4)
		#LUT_SRAM_values.append((int(inpLSB[0]) or int(inpLSB[1]) or int(inpLSB[2]) or int(inpLSB[3])) and ((not int(inpMSB[0])) or (not int(inpMSB[1])) or (not int(inpMSB[2])) or (not int(inpMSB[3]))))
		x_value.append(int(inpLSB[3]) and int(inpLSB[2]) and (not int(inpLSB[1])) and int(inpLSB[0]) and j)
		w_value.append((int(inpLSB[3]) or int(inpLSB[2])) and (int(inpLSB[1]) or int(inpLSB[0]) or j))
	for idx, inp in enumerate(inputs):
		if inp == 'en':
			fi.write('1'*inputSize[idx]+' ')
		elif inp == 'write':
			fi.write('1'*inputSize[idx]+' ')
		elif inp == 'ina' or inp == 'inb' or inp == 'inc' or inp == 'ind':
			fi.write('xx' + inpLSB + ' ')
		elif inp == 'a_data':
			fi.write(str(int(x_value[1] ^ w_value[1])))
			fi.write(str(int(x_value[0] ^ w_value[0])))
			fi.write(str(int(x_value[1] and w_value[1])))
			fi.write(str(int(x_value[0] and w_value[0])))
			fi.write(' ')
		elif inp == 'b_data':
			fi.write(str(int(x_value[1] ^ w_value[1])))
			fi.write(str(int(x_value[0] ^ w_value[0])))
			fi.write(str(int(x_value[1] and w_value[1])))
			fi.write(str(int(x_value[0] and w_value[0])))
			fi.write(' ')
		elif inp == 'c_data':
			fi.write(str(int(x_value[1] ^ w_value[1])))
			fi.write(str(int(x_value[0] ^ w_value[0])))
			fi.write(str(int(x_value[1] and w_value[1])))
			fi.write(str(int(x_value[0] and w_value[0])))
			fi.write(' ')
		elif inp == 'd_data':
			fi.write(str(int(x_value[1] ^ w_value[1])))
			fi.write(str(int(x_value[0] ^ w_value[0])))
			fi.write(str(int(x_value[1] and w_value[1])))
			fi.write(str(int(x_value[0] and w_value[0])))
			fi.write(' ')
		elif inp == 'a_data_b':
			fi.write(str(int(not (x_value[1] ^ w_value[1]))))
			fi.write(str(int(not (x_value[0] ^ w_value[0]))))
			fi.write(str(int(not (x_value[1] and w_value[1]))))
			fi.write(str(int(not (x_value[0] and w_value[0]))))
			fi.write(' ')
		elif inp == 'b_data_b':
			fi.write(str(int(not (x_value[1] ^ w_value[1]))))
			fi.write(str(int(not (x_value[0] ^ w_value[0]))))
			fi.write(str(int(not (x_value[1] and w_value[1]))))
			fi.write(str(int(not (x_value[0] and w_value[0]))))
			fi.write(' ')
		elif inp == 'c_data_b':
			fi.write(str(int(not (x_value[1] ^ w_value[1]))))
			fi.write(str(int(not (x_value[0] ^ w_value[0]))))
			fi.write(str(int(not (x_value[1] and w_value[1]))))
			fi.write(str(int(not (x_value[0] and w_value[0]))))
			fi.write(' ')
		elif inp == 'd_data_b':
			fi.write(str(int(not (x_value[1] ^ w_value[1]))))
			fi.write(str(int(not (x_value[0] ^ w_value[0]))))
			fi.write(str(int(not (x_value[1] and w_value[1]))))
			fi.write(str(int(not (x_value[0] and w_value[0]))))
			fi.write(' ')
		else:
			fi.write('x'*inputSize[idx]+' ')
	for idx, outp in enumerate(outputs):
		fi.write('x'*outputSize[idx]+' ')
	fi.write('\n')
	tcurrent = tcurrent + tstep

#4.
for i in range(0, 16):
	x= bin(i)[2:].zfill(4) #x = 0000 - 1111
	expected_sum_0 = [];
	expected_cout_0 = [];
	expected_sum_1 = [];
	expected_cout_1 = [];
	expected_sum_2 = [];
	expected_cout_2 = [];
	expected_sum_3 = [];
	expected_cout_3 = [];
	for j in range(0, 16):
		w = bin(j)[2:].zfill(4) #w = 0000 - 1111
		if ((int(x[0]) and (not int(w[0]))) or (int(x[1]) and (not int(w[1]))) or (int(x[2]) and (not int(w[2]))) or (int(x[3]) and (not int(w[3])))):
			expected_sum_0.append(0)
			expected_cout_0.append(0)
			expected_sum_1.append(0)
			expected_cout_1.append(0)
			expected_sum_2.append(0)
			expected_cout_2.append(0)
			expected_sum_3.append(0)
			expected_cout_3.append(0)
		else:
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
			#inpMSB = bin(j)[2:].zfill(4)
			t_string = str(tcurrent).zfill(4)
			t_string = '%s.0'%(t_string)
			fi.write(t_string+' ')
			#expected_output = str(int((int(inpLSB[0]) or int(inpLSB[1]) or int(inpLSB[2]) or int(inpLSB[3])) and ((not int(inpMSB[0])) or (not int(inpMSB[1])) or (not int(inpMSB[2])) or (not int(inpMSB[3])))))
			expected_sum_0.append(int(x[3]) ^ int(w[3]))
			expected_cout_0.append(0 if (int(x[3]) ^ int(w[3])) else (int(x[3]) and int(w[3])))
			expected_sum_1.append((int(x[2]) ^ int(w[2])) ^ expected_cout_0[j])
			expected_cout_1.append(expected_cout_0[j] if (int(x[2]) ^ int(w[2])) else (int(x[2]) and int(w[2])))
			expected_sum_2.append((int(x[1]) ^ int(w[1])) ^ expected_cout_1[j])
			expected_cout_2.append(expected_cout_1[j] if (int(x[1]) ^ int(w[1])) else (int(x[1]) and int(w[1])))
			expected_sum_3.append((int(x[0]) ^ int(w[0])) ^ expected_cout_2[j])
			expected_cout_3.append(expected_cout_2[j] if (int(x[0]) ^ int(w[0])) else (int(x[0]) and int(w[0])))
			for idx, inp in enumerate(inputs):
				if inp == 'en':
					fi.write('1'*inputSize[idx]+' ')
				elif inp == 'write':
					fi.write('0'*inputSize[idx]+' ')
				elif inp == 'ina':
					if (int(x[0]) and int(w[0])): 
						fi.write('1' + '11011')
					elif ((not int(x[0])) and int(w[0])):
						fi.write('1' + '00111')
					elif ((not int(x[0])) and (not int(w[0]))):
						fi.write('1' + '00000')
					else :
						fi.write('xxxxxx')
					fi.write(' ')
				elif inp == 'inb':
					if (int(x[1]) and int(w[1])): 
						fi.write('1' + '11011')
					elif ((not int(x[1])) and int(w[1])):
						fi.write('1' + '00111')
					elif ((not int(x[1])) and (not int(w[1]))):
						fi.write('1' + '00000')
					else :
						fi.write('xxxxxx')
					fi.write(' ')
				elif inp == 'inc': 
					if (int(x[2]) and int(w[2])): 
						fi.write('1' + '11011')
					elif ((not int(x[2])) and int(w[2])):
						fi.write('1' + '00111')
					elif ((not int(x[2])) and (not int(w[2]))):
						fi.write('1' + '00000')
					else :
						fi.write('xxxxxx')
					fi.write(' ')
				elif inp == 'ind':
					if (int(x[3]) and int(w[3])): 
						fi.write('1' + '11011')
					elif ((not int(x[3])) and int(w[3])):
						fi.write('1' + '00111')
					elif ((not int(x[3])) and (not int(w[3]))):
						fi.write('1' + '00000')
					else :
						fi.write('xxxxxx')
					fi.write(' ')
				elif inp == 'asout' or inp == 'bsout' or inp == 'csout' or inp == 'dsout':
					fi.write('10' + ' ')
				elif inp == 'ax' or inp == 'bx':
					fi.write('x' + ' ')
				elif inp == 'cx':
					fi.write('x' + ' ')
				elif inp == 'out_exp':
					fi.write('x' + str(expected_sum_0[j]) + 'x' + str(expected_sum_1[j]) + 'x' + str(expected_sum_2[j]) + 'x' + str(expected_sum_3[j])+ ' ')	
				elif inp == 'cout_exp':
					fi.write(str(expected_cout_3[j]) + ' ')	
				else:
					fi.write('x'*inputSize[idx]+' ')
			for idx, outp in enumerate(outputs):
				if outp == 'out':
					fi.write('x' + str(expected_sum_0[j]) + 'x' + str(expected_sum_1[j]) + 'x' + str(expected_sum_2[j]) + 'x' + str(expected_sum_3[j])+ ' ')
				elif outp == 'cout':
					fi.write(str(expected_cout_3[j]) + ' ')
				else:
					fi.write('x'*outputSize[idx]+' ')
			fi.write('\n')
			tcurrent = tcurrent + tstep
