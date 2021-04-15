#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import os
import sys

parser = argparse.ArgumentParser()

parser.add_argument("prefix", help="Input file prefix to search for <prefix>.diff and <prefix>.msg files")
parser.add_argument("-q", "--quiet", action="store_true", help="Suppress output")

args = parser.parse_args()

filename_prefix = args.prefix
quiet = args.quiet

input_diff = f"{filename_prefix}.diff"
input_msg = f"{filename_prefix}.msg"

if not os.path.isfile(input_msg):
    print(f"{input_msg} doesn't exist")
    sys.exit(1)

if not os.path.isfile(input_diff):
    print(f"{input_diff} doesn't exist")
    sys.exit(1)

with open(f"{filename_prefix}.diff","r+") as fp_diff_in:
    with open(f"{filename_prefix}.msg","r+") as fp_msg_in:
        with open(f"{filename_prefix}.filtered.diff","a+") as fp_diff_out:
            with open(f"{filename_prefix}.filtered.msg","a+") as fp_msg_out:
                while True:

                    diff_line = fp_diff_in.readline()
                    msg_line = fp_msg_in.readline()

                    if len(diff_line)==0:
                        break

                    if "Binary files" not in diff_line[:len("Binary files")]:
                       fp_msg_out.write(msg_line)
                       fp_diff_out.write(diff_line)
                    else:
                        if not quiet:
                           print(f"skipping {diff_line} / {msg_line}")
