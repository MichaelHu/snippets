BEGIN {

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    ##

    line = $0;
    if ( match( line, "^file:" ) ) {
        split( line, parts, "/" );
        name = parts[ 4 ];
        data[ name ] = "";
    }
    else {
        lnglats = line;
        data[ name ] = lnglats;
    }
}

END {

    id = 0;

    print "{\
    \"type\": \"FeatureCollection\",\
    \"features\": [";

    for ( name in data ) {
        # 1. get lnglat_list
        lnglats = data[ name ];
        split( lnglats, lnglat_parts, ";" );
        subid = 0;
        lnglat_list = "";
        len = length( lnglat_parts );
        for( i = 1; i <= len; i++ ) {
            subid++;
            if ( subid == 1 ) {
                item_prefix = "";
            }
            else {
                item_prefix = ", ";
            }
            lnglat_list = sprintf( "%s%s[ %s ]", lnglat_list, item_prefix, lnglat_parts[ i ] );
        }

        # 2. print feature
        id++;
        if ( id == 1 ) {
            item_prefix = "";
        }
        else {
            item_prefix = ", ";
        }

        printf "    %s{\
        \"type\": \"Feature\"\
        , \"properties\": { \"QH_NAME\": \"%s\" }\
        , \"geometry\": {\
            \"type\": \"MultiPolygon\"\
            , \"coordinates\": [[[\
        %s\
            ]]]\
        }\
    }\n", item_prefix, name, lnglat_list;

    }

    print "]}";

}


