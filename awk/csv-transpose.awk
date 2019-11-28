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

    # pre action

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    # 2. file encoding must be utf-8
    # 3. sed regular expression: \s not support
    ##
    line = $0;
    split( line, line_fields, FS );

    # note: the following statement is not supported
    # lines_fields[ line_num ] = line_fields;

    for ( i in line_fields ){
        lines_fields[ line_num, i ] = line_fields[ i ];
        # print i, line_fields[ i ];
    }

    line_num++;
}

END {

    field_count = length( line_fields );
    for ( j=1; j<=field_count; j++ ) {
        new_line = "";
        is_first_field = 1;
        for ( i=1; i<line_num; i++ ) {
            if ( is_first_field ) {
                splitter = "";
            }
            else {
                splitter = ",";
            }
            new_line = sprintf( "%s%s%s", new_line, splitter, lines_fields[ i, j ] );
            is_first_field = 0;
        }
        print new_line;
    }

}

