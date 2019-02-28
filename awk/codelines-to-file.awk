BEGIN {

    state = 0;

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    # 2. lines must be prefixed with 4 spaces at minimum
    ##

    line = $0;
    if ( !state && match( line, "^    @\\[data-script=\"javascript" ) ) {
        if ( index( line, func_name ) >= 1 ) {
            # remove prefix and spaces if any
            sub( "^[^\\]]+\\] *", "", line );

            # remove tailing spaces if any
            sub( " *$", "", line );

            ##
            # 1. must match exactly
            # 2. for example: sigma.prototype.layoutHierarchy and sigma.prototype.layoutHierarchy2
            #
            if ( line == func_name ) {
                state = 1;
                print line;
            }
        } 
    }
    else if ( state == 1 ) {
        if ( match ( line, "^ {0,4}[^ (]" ) ) {
            state = 0;
            if ( match( line, "^ {4}" ) ) {
                print line;
            }
        }
        else {
            print line;
        }
    }
    else {
    }
}

END {

}




