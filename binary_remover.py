#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import os
import sys

parser = argparse.ArgumentParser()

parser.add_argument("prefix", help="Input file prefix to search for <prefix>.diff and <prefix>.msg files")
parser.add_argument("-q", "--quiet", action="store_true", help="Suppress output")
parser.add_argument("-f", "--full", action="store_true", help="Completely remove any string containing \"Binary files\"")
parser.add_argument("-i", "--in-place", action="store_true", help="Overwrite original file")

args = parser.parse_args()

filename_prefix = args.prefix
quiet = args.quiet
full = args.full
in_place = args.in_place

input_diff = f"{filename_prefix}.diff"
input_msg = f"{filename_prefix}.msg"
output_diff = f"{filename_prefix}.filtered.diff"
output_msg = f"{filename_prefix}.filtered.msg"

if not os.path.isfile(input_msg):
    print(f"{input_msg} doesn't exist")
    sys.exit(1)

if not os.path.isfile(input_diff):
    print(f"{input_diff} doesn't exist")
    sys.exit(1)

with open(input_diff,"r+") as fp_diff_in:
    with open(input_msg,"r+") as fp_msg_in:
        with open(output_diff,"a+") as fp_diff_out:
            with open(output_msg,"a+") as fp_msg_out:
                while True:

                    diff_line = fp_diff_in.readline()
                    msg_line = fp_msg_in.readline()

                    if len(diff_line)==0:
                        break

                    if (not full and "Binary files" not in diff_line[:len("Binary files")]) or (full and "Binary files" not in diff_line) :
                       fp_msg_out.write(msg_line)
                       fp_diff_out.write(diff_line)
                    else:
                        if not quiet:
                           print(f"skipping {diff_line} / {msg_line}")

if in_place:
    os.unlink(input_diff)
    os.unlink(input_msg)
    os.rename(output_diff, input_diff)
    os.rename(output_msg, input_msg)
