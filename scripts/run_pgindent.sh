#!/bin/bash

objdump -W pg_toolkit_brazil.so | \
    egrep -A3 DW_TAG_typedef | \
    perl -e ' while (<>) { chomp; @flds = split;next unless (1 < @flds);\
        next if $flds[0]  ne "DW_AT_name" && $flds[1] ne "DW_AT_name";\
        next if $flds[-1] =~ /^DW_FORM_str/;\
        print $flds[-1],"\n"; }'  | \
    sort | uniq > /tmp/pg_toolkit_brazil.typedefs

find -type f -name "*.c" -exec pgindent --typedefs=/tmp/pg_toolkit_brazil.typedefs {} \;
find -type f -name "*.h" -exec pgindent --typedefs=/tmp/pg_toolkit_brazil.typedefs {} \;