BEGIN {

    # for csv file
    FS = " *, *";

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    ##
    printf "\"%s\": {\
\"name\": \"%s\"\
, \"p1809\": \"%s\"\
, \"p1810\": \"%s\"\
, \"link-relative-ratio\": \"%s\"\
}\n", $2, $2, $3, $4, $5;

}
