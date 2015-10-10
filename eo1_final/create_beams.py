import sys

f = open('imprecise_beam.txt', 'w')
def create_imprecise(str_f, ratio):
    lines = [line.rstrip('\n').replace('    ', ' ').replace('   ', ' ').replace('  ', ' ').strip() for line in open(str_f)]
    for line in lines:
        if line == '':
            continue;
        for elt in line.strip().split(' '):
            if elt == '0' or elt == '1':
                x = int(elt)
            else:
                print elt
                x = float(elt)

        int_arr = [int(i) if i == '0' or i == '1' else float(i) for i in line.split(' ')]
        new_arr = [0 for i in range(len(int_arr))]
        for i in range(1, len(int_arr) - 1):
            # right side
            if int_arr[i] != 0 and int_arr[i+1] == 0:
                new_arr[i+1] = int_arr[i] * ratio
            # left side
            elif int_arr[i] != 0 and int_arr[i-1] == 0:
                new_arr[i-1] = int_arr[i] * ratio
            else:
                continue
        print ' '.join(map(str, new_arr))
        f.write(' '.join(map(str, new_arr)) + '\n')
    #print new_arr
    #print int_arr

create_imprecise("beam.txt", 0.1)
