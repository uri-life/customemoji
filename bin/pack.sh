#!/bin/dash

# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

NAME=
while true
do
    case "$1" in
        -name)
            shift
            NAME="$1"
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            break
            ;;
    esac
done

for ARG in "$@"
do
    DIR="$(realpath "$ARG")"
    if test -z "$NAME"
    then
        NAME="$(basename "$DIR")"
    fi
    PACK_DIR="$(mktemp -d)"
    find "$ARG"/ \
         -name '*.png' \
         -depth 1 \
         -exec mv {} "$PACK_DIR" \; \
        2>/dev/null
    find "$ARG"/*/ \
         -name '*.gif' \
         -depth 1 \
         -exec mv {} "$PACK_DIR" \; \
        2>/dev/null
    STORED_PWD="$(pwd)"
    cd "$PACK_DIR"
    tar -czf "$STORED_PWD/$NAME.tar.gz" *
    cd "$STORED_PWD"
    rm -r "$PACK_DIR"
done
