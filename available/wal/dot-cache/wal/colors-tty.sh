#!/bin/sh
[ "${TERM:-none}" = "linux" ] && \
    printf '%b' '\e]P0010101
                 \e]P177C0DE
                 \e]P26DCFF6
                 \e]P3999998
                 \e]P4FDC689
                 \e]P5D4C9AB
                 \e]P6AACFD4
                 \e]P7ebecea
                 \e]P8a4a5a3
                 \e]P977C0DE
                 \e]PA6DCFF6
                 \e]PB999998
                 \e]PCFDC689
                 \e]PDD4C9AB
                 \e]PEAACFD4
                 \e]PFebecea
                 \ec'
