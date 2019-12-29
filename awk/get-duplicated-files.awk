# Usage: 
# find . -type f -exec md5 {} \; | awk -f ~/snippets/awk/get-duplicated-files.awk | sed -e 's/^/rm -rf /g' | sh -x
BEGIN {
    if( !is_linux ) {
        FS = " *= *"
    }
}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    #   md5 = system( sprintf( "TMP_VAR=`md5 \"%s\"`", $0) );
    #   print ENVIRON["TMPDIR"];
    ##
    # MD5 (./thinking.md.html) = 378cf89f5ce6cd89416fb8d671d2947f
    if( !is_linux ) {
        md5 = $2;
        # file name may contains white-spaces
        file_name = $1;
        sub("^MD5 \\(", "", file_name);
        sub("\\)$", "", file_name);
    }
    else {
        md5 = $1;
        # file name may contains white-spaces
        file_name = $0;
        sub("^[^\t ]+[\t ]+", "", file_name);
    }

    # escape: white spaces, ( or )
    gsub(" ", "\\ ", file_name);
    gsub("\\(", "\\(", file_name);
    gsub("\\)", "\\)", file_name);
    # print md5, file_name;

    if( md5s[md5] ) {
        print file_name;
    }
    else {
        md5s[md5] = file_name;
    }

}

END {
}


