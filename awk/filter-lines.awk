BEGIN {

    # for csv file
    FS = "\t";

    # village codes
    village_codes["110106201212"] = "110106201212";
    village_codes["110106201213"] = "110106201213";
    village_codes["110106201216"] = "110106201216";
    village_codes["110106201218"] = "110106201218";
    village_codes["110106202201"] = "110106202201";
    village_codes["110106202202"] = "110106202202";
    village_codes["110108020xxx"] = "110108020xxx";
    village_codes["110108102009"] = "110108102009";
    village_codes["110108102010"] = "110108102010";
    village_codes["110108102011"] = "110108102011";
    village_codes["110108102202"] = "110108102202";
    village_codes["110108103205"] = "110108103205";
    village_codes["110108103210"] = "110108103210";
    village_codes["110108105202"] = "110108105202";
    village_codes["110108105203"] = "110108105203";
    village_codes["110108105208"] = "110108105208";
    village_codes["110108105209"] = "110108105209";
    village_codes["110108105210"] = "110108105210";
    village_codes["110108105211"] = "110108105211";
    village_codes["110108105214"] = "110108105214";
    village_codes["110113004904"] = "110113004904";

    # 110228 密云区
    # 110116 怀柔区
    # 110111 房山区
    # 110229 延庆区
    # 110101 东城区
    # 110109 门头沟区
    # 110108 海淀区
    # 110112 通州区
    # 110117 平谷区
    # 110113 顺义区
    # 110114 昌平区
    # 110105 朝阳区
    # 110106 丰台区
    # 110107 石景山区
    # 110102 西城区
    # 110115 大兴区

}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    # 2. file encoding must be utf-8
    # 3. sed regular expression: \s not support
    ##

    # print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10;
    code = $2;

    for (i in village_codes) {
        if (index(code, i) >= 1) {
            print $0;
        }
    }

}

END {

}

