BEGIN {

    OFS = ", ";

    state = 0;
    func_name = "";
    func_id = 0;
    id = 1;

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    # 2. lines must be prefixed with 4 spaces at minimum
    ##

    line = $0;

    # func start
    if ( !state && match( line, "^    @\\[data-script=\"javascript" ) ) {
        # remove prefix and spaces if any
        sub( "^[^\\]]+\\] *", "", line );

        # remove tailing spaces if any
        sub( " *$", "", line );

        func_name = line;
        func_id++;
        func_names[ func_id ] = func_name;
        id = 1;
        state = 1;
        data[ func_id, id++ ] = line;
    }
    else if ( state == 1 ) {
        # func end
        if ( match ( line, "^ {0,4}[^ (]" ) ) {
            if ( match( line, "^ {4}" ) ) {
                data[ func_id, id++ ] = line;
            }
            state = 0;
            func_line_count_arr[ func_id ] = id - 1;
            id = 1;
            func_name = "";
        }
        else {
            data[ func_id, id++ ] = line;
        }
    }
    else {
    }

}

END {

    for ( i = 1; i <= length( func_names ); i++ ) {
        func_name = func_names[ i ];
        line_count = func_line_count_arr[ i ];

        if ( !match( func_name, "^sigma\\.|^function " ) ) {
            continue;
        }

        print func_name;
        for( j = 1; j <= line_count; j++ ) {
            print data[ i, j ];
        }
    }

}




