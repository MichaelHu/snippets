BEGIN {

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    ##
    normalize_word = $0;
    if ( match( normalize_word, "[a-zA-Z]+" ) ) {
        normalize_word = tolower( $0 );
    }

    if ( ! words_count[ normalize_word ] ) {
        words_count[ normalize_word ] = 0;
    }
    words_count[ normalize_word ]++;

}

END {
    for ( word in words_count ) {
        print word, words_count[ word ];
    }
}

