layout := "4x5"

# colors
reset := '\033[0m'
red   := '\033[1;31m'
green := '\033[1;32m'
blue  := '\033[1;34m'

generate: build
    #!/usr/bin/env bash
    result_dir="result/{{layout}}"
    scad_dir="$result_dir/scad"
    stl_dir="$result_dir/stl"

    mkdir -p "$stl_dir"
    for f in $scad_dir/*.scad; do
        out="$(basename $f .scad).stl"
        printf "Converting: {{blue}}$f{{reset}}... "
        openscad -o "$stl_dir/$out" $f 2> /dev/null
        printf "{{green}}Complete {{blue}}$stl_dir/$out{{reset}} \n"
    done

    printf "Generation {{green}}finished{{reset}}\n"
    echo "$(git rev-parse HEAD)" > $result_dir/commit

build:
    #!/usr/bin/env bash
    result_dir="result/{{layout}}"
    scad_dir="$result_dir/scad"

    lein generate

    mkdir -p "$scad_dir"

    mv things/left.scad $scad_dir/left-{{layout}}.scad
    mv things/right.scad $scad_dir/right-{{layout}}.scad
    mv things/right-plate.scad $scad_dir/right-plate-{{layout}}.scad
    mv things/right-plate-laser.scad $scad_dir/right-plate-laser-{{layout}}.scad

@watch:
    lein auto generate

