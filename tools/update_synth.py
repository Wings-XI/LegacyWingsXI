"""Change the order of values in a synth_recipies.sql file from an old version of Topaz
to match the new column layout.
Author: Twilight
License: GPLv3 or higher
"""

import sys

def do_change(invals):
	result = [""] * 30
	result[0] = invals[0]
	result[1] = invals[1]
	result[2] = invals[2]
	result[3] = invals[10]
	result[4] = invals[9]
	result[5] = invals[7]
	result[6] = invals[5]
	result[7] = invals[8]
	result[8] = invals[4]
	result[9] = invals[3]
	result[10] = invals[6]
	result[11] = invals[11]
	result[12] = invals[12]
	result[13] = invals[13]
	result[14] = invals[14]
	result[15] = invals[15]
	result[16] = invals[16]
	result[17] = invals[17]
	result[18] = invals[18]
	result[19] = invals[19]
	result[20] = invals[20]
	result[21] = invals[21]
	result[22] = invals[22]
	result[23] = invals[23]
	result[24] = invals[24]
	result[25] = invals[25]
	result[26] = invals[26]
	result[27] = invals[27]
	result[28] = invals[28]
	result[29] = invals[29]
	return result

def update_synth(infile, outfile):
	prefix = "INSERT INTO `synth_recipes` VALUES("
	prefix_len = len(prefix)
	for row in infile:
		#sys.stderr.write(row)
		if row.find(prefix) != 0:
			# Not an insert row, pass as is
			outfile.write(row)
			#sys.stderr.write("Written as is\n")
			continue
		# Get the values being inserted
		end_pos = row.find(")", prefix_len)
		suffix = row[end_pos:]
		#sys.stderr.write(str(row[prefix_len:end_pos].split(",", 30)) + "\n")
		values = map(str.strip, row[prefix_len:end_pos].split(",", 30))
		outfile.write(prefix + ", ".join(do_change(values)) + suffix)
		#sys.stderr.write("Modified and written\n")

def main(argv):
	argc = len(argv)
	if argc < 2:
		infile = sys.stdin
	else:
		infile = open(argv[1])
	if argc < 3:
		outfile = sys.stdout
	else:
		outfile = open(argv[2], "w")
	update_synth(infile, outfile)
	if outfile != sys.stdout:
		outfile.close()
	if infile != sys.stdin:
		infile.close()

if __name__ == "__main__":
	main(sys.argv)
