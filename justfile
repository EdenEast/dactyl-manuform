
dev:
    lein auto generate

gen:
    #!/usr/bin/env bash
    mkdir -p stl
    for f in things/*.scad ; do
        out="$(basename $f .scad).stl"
        echo "Converting $out ..."
        openscad -o "stl/$out" $f 2> /dev/null
    done
    for f in things/*.stl ; do
        cp "$f" stl/
    done

