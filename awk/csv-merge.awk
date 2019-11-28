BEGIN {

    # for csv file
    FS = " *, *";

    # switches

    # config

    # state variables
    is_first_line = 1;
    line_num = 1;
    field_count = 0;
    is_first_field = 1;
    file_count = 0;

    # pre action

}

/部门,合计/{
    file_count++; 
}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    # 2. file encoding must be utf-8
    # 3. sed regular expression: \s not support
    ##
    line = $0;
    main_field = $1;
    if ( values[ main_field ] != "" ) {
        values[ main_field ] = sprintf( "%s,%s", values[ main_field ], $2 );
    }
    else {
        values[ main_field ] = $2;
    }

    line_num++;
    is_first_line = 0;
}

END {

    for ( i in values ) {
        columns = values[ i ];
        gsub( "[^,]", "", columns );
        columns = length( columns ) + 1;
        prefix_str = "";
        # print values[ i ], file_count - columns;
        for ( j=0; j<file_count - columns; j++ ) {
            prefix_str = sprintf( "%s,", prefix_str );
        }
        print sprintf( "%s,%s%s", i, prefix_str, values[ i ] );
    }

    # print file_count;
}

