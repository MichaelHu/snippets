BEGIN {

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    ##

    line = $0;
    if ( match( line, "^{" ) ) {
        content = line;
        data[ name ] = content;
    }
    else {
        name = line;
    }
}

END {

    for ( name in data ) {
        cmd = sprintf( "( cat <<EOF\n%s\nEOF\n ) > \"./txt/%s.txt\"", data[ name ], name );
        print cmd;
        system( cmd );
    }

}



