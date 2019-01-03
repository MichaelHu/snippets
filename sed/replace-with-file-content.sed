/^, "--replace:congye_renyuan_all@.\/all-congye.json": ""$/{
    s/^, "--replace:\([^@]\{1,\}\)@\([^"]\{1,\}\)".*$/, "\1": /
    r ./all-congye.json
}

/^, "--replace:congye_renyuan_chengzhen@.\/chengzhen-congye.json": ""$/{
    s/^, "--replace:\([^@]\{1,\}\)@\([^"]\{1,\}\)".*$/, "\1": /
    r ./chengzhen-congye.json
}

/^, "--replace:congye_renyuan_guomin_jingji@.\/guomin-jingji-congye.json": ""$/{
    s/^, "--replace:\([^@]\{1,\}\)@\([^"]\{1,\}\)".*$/, "\1": /
    r ./guomin-jingji-congye.json
}

/^, "--replace:congye_renyuan_jingji_pucha@.\/jingji-pucha-faren-congye-2013.json": ""$/{
    s/^, "--replace:\([^@]\{1,\}\)@\([^"]\{1,\}\)".*$/, "\1": /
    r ./jingji-pucha-faren-congye-2013.json
}

