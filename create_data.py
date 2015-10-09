import sys
#f = open(arg[1], 'r')

lines = [line.rstrip('\n').replace('   ', ' ') for line in open(sys.argv[1])]
b = 0
col = 0
for l in lines:
    if l == '':
        b += 1
        col = 0
        print
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
    print s
