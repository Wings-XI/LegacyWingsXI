import sys

ADD_OFFSET = 16

def fix_row(row):
	prefix = "INSERT INTO `abilities` VALUES("
	prefix_len = len(prefix)
	prefix_pos = row.find(prefix)
	if prefix_pos == -1:
		return row
	comma_pos = row.find(",", prefix_pos + prefix_len)
	if comma_pos == -1:
		return row
	ability_no = int(row[prefix_pos + prefix_len : comma_pos])
	ability_no += ADD_OFFSET
	return row[:prefix_pos + prefix_len] + str(ability_no) + row[comma_pos:]

def fix_abilities(infile, outfile):
	if type(infile) == str:
		h_in = open(infile)
	else:
		h_in = infile
	if type(outfile) == str:
		h_out = open(outfile, "w")
	else:
		h_out = outfile
	for row in h_in:
		h_out.write(fix_row(row))
	if h_out != outfile:
		h_out.close()
	if h_in != infile:
		h_in.close()

def main(argv):
	argc = len(argv)
	if argc >= 3:
		outfile = argv[2]
	else:
		outfile = sys.stdout
	if argc >= 2:
		infile = argv[1]
	else:
		infile = sys.stdin
	fix_abilities(infile, outfile)

if __name__ == "__main__":
	main(sys.argv)
