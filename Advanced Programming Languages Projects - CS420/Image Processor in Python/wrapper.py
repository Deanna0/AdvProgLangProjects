import subprocess
# *MUY IMPORTANTE*
# -to get wrapper.py to work make sure you have the code in c, haskel, prolog, & matlab to be in the same 
#  folder/directory (in my case all of my files are on /Users/deannao/Desktop/wrap.py)
# -make sure mickey photo is also in the same folder/directory
#  (or any photo for that matter change the matlab code if you wanna change the photo being 
#  manipulated)

## set up for other programs to work ##
#path to find where matlab is *on my computer* to run the code
matlab_executable = '/Applications/MATLAB_R2023b.app/bin/matlab'

#runs matlabcode.m to generate initial input.txt for other program languages to use
matlab_process = subprocess.run([matlab_executable, "-batch", "run('matlabcode.m'); pause(1);"]
 , capture_output=True)

#open input.txt and turn it into the input for all the other code
with open('input.txt', 'r') as file:
    line = file.readline()
    input_array = [int(value) for value in line.split()]
########################################

###### c code part ##########

#runs c portion of the code to make the image strictly black & white
subprocess.run(["gcc", "cprog.c", "-o","cprog"])
process = subprocess.run(["./cprog"] +[str(x) for x in input_array],capture_output=True, text=True)
output_variable = process.stdout.strip()

print("working") #test print to show that this is indeed working

with open('c_output.txt', 'w') as f: #creates an output file for matlabcode2 to display
   f.write(output_variable)

#runs matlabcode2 to create the image made by cprog.c
matlab_process = subprocess.run([matlab_executable, "-batch", "run('matlabcode2.m'); pause(10);"], capture_output=True)

###### haskel code part ########

#runs haskel portion of the code to invert the colors 
subprocess.run(['ghc','haskellcode.hs'])
process = subprocess.run(['./haskellcode'] + [str(x) for x in input_array], text=True, capture_output=True)
result_hs = process.stdout.strip()

print("working") #test print to show that this is indeed working

#opens output for haskel code
with open('haskel_output.txt', 'w') as f: #creates an output file for matlabcode2 to display
  f.write(result_hs)

#runs matlabcode2 to create the image made by haskellcode.hs
matlab_process = subprocess.run([matlab_executable, "-batch", "run('matlabcode2.m'); pause(10);"], capture_output=True)


####### prolog code part #######
prolog_input = "["+" , ".join(map(str, input_array)) + " ]."
result = subprocess.run(['swipl', '-q','-g','main','-t','halt','prologcode.pl'], input=prolog_input,
                        capture_output=True, text=True)
output_result_prolog = result.stdout.strip()

# Remove leading and trailing whitespace and remove brackets
numbers_str = output_result_prolog.strip("[]")

# Replace commas with spaces
numbers_str = numbers_str.replace(",", " ")

print("working") #test print to show that this is indeed working

with open('prolog_output.txt', 'w') as f: #creates an output file for matlabcode2 to display
  f.write(numbers_str)

#runs matlabcode2 to create the image made by prologcode.pl
matlab_process = subprocess.run([matlab_executable, "-batch", "run('matlabcode2.m'); pause(10);"], capture_output=True)
