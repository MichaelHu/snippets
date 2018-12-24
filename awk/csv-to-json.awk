BEGIN {

    # for csv file
    FS = " *, *";

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    ##

    lastFieldOfLine = $11;
    sub( "\r", "", lastFieldOfLine );

    if ( $1 ) {
    printf "\"%s\": {\
\"district\": \"%s\"\
, \"name\": \"%s\"\
, \"p1810\": \"%s\"\
, \"p1811\": \"%s\"\
, \"link-relative-ratio\": \"%s\"\
}\n", $3, $1, $2, $6, $9, lastFieldOfLine;
    }

}
