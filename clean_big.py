import sys

f = open("eo1_1_big.dat", 'w')

def str_num(num):
    indices = ''
    for i in range(num):
        indices += str(i) + ' '
    return indices

def write_2d(str_f):
    fin = open(str_f)
    lines = [line.rstrip('\n').replace('\t', ' ') for line in fin]
    j = 0
    for l in lines:
        f.write("\t" + str(j) + " " + l + "\n")
        j += 1

def write_3d(str_f):
    lines = [line.rstrip('\n').replace('    ', ' ').replace('   ', ' ').replace('  ', ' ').strip() for line in open(str_f)]
    print lines[0]
    b = 0
    col = 0
    for l in lines:
        if l == '':
            b += 1
            col = 0
            f.write("\n")
            continue;
        s = '[' + str(col) + ',*,' + str(b) + ']  0 '
        row = 1
        for c in l:
            if c == ' ':
                s += ' ' + str(row) + ' '
                row += 1
            else:
                s += c
        col += 1
        f.write(s + '\n')

f.write("data;\n")
f.write("\n")

f.write("set R := " + str_num(60) + ";\n")
f.write("set C := " + str_num(80) + ";\n")
f.write("set B := " + str_num(126) + ";\n")
f.write("\n")

f.write("param d_c := 2;\n")
f.write("param d_t := 10;\n")
f.write("param p := 60;\n")
f.write("\n")

f.write("param t: " + str_num(80) + " :=\n")
write_2d("eo1files/actualexample/critical_raw.txt")
f.write(";\n")

f.write("param c: " + str_num(80) + " :=\n")
write_2d("eo1files/actualexample/tumor_raw.txt")
f.write(";\n")

f.write("param b :=\n")

write_3d("eo1files/actualexample/beam_raw.txt")
f.write(";\n")
