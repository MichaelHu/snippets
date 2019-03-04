BEGIN {

    state = 0;
    func_id = 0;
    id = 1;

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    # 2. lines must be prefixed with 4 spaces at minimum
    ##

    line = $0;
    # print "++++++", state, line;

    ##
    # func start
    # 1. `    @[data-script="javascript...`
    # 2. `    sigma.classes.graph.addMethod(...`
    if ( match( line, "^ {4}@\\[data-script=\"javascript" ) \
         || state == 1 && match( line, "^ {4}sigma\\.classes\\.graph\\.addMethod" ) \
         || state == 1 && match( line, "^ {4}sigma\\.prototype\\." ) \
         ) {

        # print ">>>>>>" ;

        if ( state == 1 ) {
            # close previous func
            func_line_count_arr[ func_id ] = id - 1;
        }

        # remove prefix `@[data-script=...` pattern from line if any
        sub( "^[^\\]]+\\] *", "", line );

        func_id++;
        func_name = line;

        # remove prefix spaces if any from func_name
        sub( "^ +", "", func_name );

        ##
        # remove tailing spaces or "("s if any
        # 1. `sigma.classes.graph.addMethod(`   => remove tailing "("
        # 2. `sigma.prototype.rotateGraph = function( nodes, options )`   => remove "= function( nodes, options )"
        # 3. `function getRandomGraph( ...`   => remove "function " and tailing "( ..."
        # 4. `( function() {`   => ""
        # 5. `/**`  => "" 
        ##
        sub( "^function +", "", func_name );
        sub( "[ \\(/=].*$", "", func_name );
        if ( match( func_name, "sigma\\..+\\.addMethod" ) \
             || match( func_name, "^$" ) \
             ) {
             # `sigma.classes.graph.addMethod(` will occur multiple times
             # print "@@@@@@", func_name;
             func_name = sprintf( "%s_%d", func_name, func_id );
        }
        func_name = sprintf( "%s--%s", FILENAME, func_name );

        func_names[ func_id ] = func_name;
        id = 1;
        state = 1;
        data[ func_id, id++ ] = line;
    }
    else if ( state == 1 ) {
        ##
        # func end
        # 1. regexp not support: "^ {0,3}[^ ]"
        # 2. empty line will not be treated as func end 
        ##
        if ( \
             match ( line, "^[^ \\t]" ) \
             || match ( line, "^ [^ \\t]" ) \
             || match ( line, "^  [^ \\t]" ) \
             || match ( line, "^   [^ \\t]" ) \
            ) {
            # print "======", line;
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

        # omit empty func_name 
        if ( !match( func_name, "-- *\." ) ) { 
            continue;
        }

        # invalid func_name
        if ( match( func_name, "[\\(\\) ]" ) ) {
            print sprintf( "error: invalid func_name: %s", func_name );
            exit 1;
        }

        code_lines = "";
        for( j = 1; j <= line_count; j++ ) {
            code_lines = sprintf( "%s\n%s", code_lines, data[ i, j ] );
        }

        commands = sprintf( "( cat <<'EOF'\n%s\nEOF\n) > ./tmp/%s.js", code_lines, func_name ); 
        # print commands;
        system( commands );
    }

}




