BEGIN {

    # for csv file
    FS = " *, *";

    # switches
    use_main = 0;
    use_all_congye = 0;
    use_guomin_jingji_congye = 0;
    use_jingji_pucha_faren_congye_2013 = 0;
    use_chengzhen_congye = 1;
    use_zujin_monthly = 0;

    # config
    district_list[ "合计" ] = "110";
    district_list[ "全市" ] = "110";
    district_list[ "密云区" ] = "110228";
    district_list[ "怀柔区" ] = "110116";
    district_list[ "房山区" ] = "110111";
    district_list[ "延庆区" ] = "110229";
    district_list[ "东城区" ] = "110101";
    district_list[ "门头沟区" ] = "110109";
    district_list[ "海淀区" ] = "110108";
    district_list[ "通州区" ] = "110112";
    district_list[ "平谷区" ] = "110117";
    district_list[ "顺义区" ] = "110113";
    district_list[ "昌平区" ] = "110114";
    district_list[ "朝阳区" ] = "110105";
    district_list[ "丰台区" ] = "110106";
    district_list[ "石景山区" ] = "110107";
    district_list[ "西城区" ] = "110102";
    district_list[ "大兴区" ] = "110115";

    industry_list[ "合计" ] = "total";
    industry_list[ "农、林、牧、渔业" ] = "nong_lin_mu_yu";
    industry_list[ "采矿业" ] = "caikuang";
    industry_list[ "制造业" ] = "zhizao";
    industry_list[ "电力、热力、燃气及水生产和供应业" ] = "dianli_reli_ranqi_shuichan";
    industry_list[ "建筑业" ] = "jianzhu";
    industry_list[ "批发和零售业" ] = "pifa_lingshou";
    industry_list[ "交通运输、仓储和邮政业" ] = "jiaotong";
    industry_list[ "住宿和餐饮业" ] = "zhusu_canyin";
    industry_list[ "信息传输、软件和信息技术服务业" ] = "xinxi_ruanjian";
    industry_list[ "金融业" ] = "jinrong";
    industry_list[ "房地产业" ] = "fangdichan";
    industry_list[ "租赁和商务服务业" ] = "zulin_shangwu";
    industry_list[ "科学研究和技术服务业" ] = "kexue_yanjiu";
    industry_list[ "水利、环境和公共设施管理业" ] = "shuili_huanjing";
    industry_list[ "居民服务、修理和其他服务业" ] = "juminfuwu_xiuli";
    industry_list[ "教育" ] = "jiaoyu";
    industry_list[ "卫生和社会工作" ] = "weisheng_shehui";
    industry_list[ "文化、体育和娱乐业" ] = "wenhua_tiyu_yule";
    industry_list[ "公共管理、社会保障和社会组织" ] = "gonggongguanli_shehuibaozhang";
    industry_list[ "国际组织" ] = "guojizuzhi";

    industry_codes[ 1 ] = "total";
    industry_codes[ 2 ] = "nong_lin_mu_yu";
    industry_codes[ 3 ] = "caikuang";
    industry_codes[ 4 ] = "zhizao";
    industry_codes[ 5 ] = "dianli_reli_ranqi_shuichan";
    industry_codes[ 6 ] = "jianzhu";
    industry_codes[ 7 ] = "pifa_lingshou";
    industry_codes[ 8 ] = "jiaotong";
    industry_codes[ 9 ] = "zhusu_canyin";
    industry_codes[ 10 ] = "xinxi_ruanjian";
    industry_codes[ 11 ] = "jinrong";
    industry_codes[ 12 ] = "fangdichan";
    industry_codes[ 13 ] = "zulin_shangwu";
    industry_codes[ 14 ] = "kexue_yanjiu";
    industry_codes[ 15 ] = "shuili_huanjing";
    industry_codes[ 16 ] = "juminfuwu_xiuli";
    industry_codes[ 17 ] = "jiaoyu";
    industry_codes[ 18 ] = "weisheng_shehui";
    industry_codes[ 19 ] = "wenhua_tiyu_yule";
    industry_codes[ 20 ] = "gonggongguanli_shehuibaozhang";
    industry_codes[ 21 ] = "guojizuzhi";

    years[ 1 ] = 2017;
    years[ 2 ] = 2016;
    years[ 3 ] = 2015;
    years[ 4 ] = 2014;
    years[ 5 ] = 2013;
    years[ 6 ] = 2012;
    years[ 7 ] = 2011;
    years[ 8 ] = 2010;
    years[ 9 ] = 2009;


    # state variables
    is_first_line = 1;

    # pre action
    print "{";
}

{

    ##
    # 1. file format must be unix, which means lines end with \n( 0x0a )
    # 2. file encoding must be utf-8
    # 3. sed regular expression: \s not support
    ##

    # print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10;
    district_name = $1;
    gsub( " +", "", district_name );
    if ( district_name == "合计" ) {
        district_name = "全市";
    }
    district_code = district_list[ district_name ];

    if ( is_first_line ) {
        line_prefix = "";
    }
    else {
        line_prefix = ", ";
    }

    # 三次产业从业人员构成
    if ( use_all_congye ) {
        year = $1;
        gsub( " +", "", year );
        if ( match( year, "^(2009|201[0-8])$" ) ) {

            printf "%s\"%s\": {\
    \"total_congye\": %s\
    , \"congye_unit\": \"万\"\
    , \"ratio_unit\": \"%%\"\
    , \"chanye1_congye\": %s\
    , \"chanye2_congye\": %s\
    , \"chanye3_congye\": %s\
    , \"chanye1_ratio\": %s\
    , \"chanye2_ratio\": %s\
    , \"chanye3_ratio\": %s\
}\n", line_prefix, $1, $2, $3, $4, $5, $6, $7, $8;

            is_first_line = 0;
        }
    }


    # 2009-2017从业人员按国民经济行业的分布 
    if ( use_guomin_jingji_congye && $3 ) {
        industry_name = $1;
        gsub( " +", "", industry_name );
        industry_code = industry_list[ industry_name ];

        if ( industry_code ) {
            data_of_industry[ "2017", industry_code ] = $2;
            data_of_industry[ "2016", industry_code ] = $3;
            data_of_industry[ "2015", industry_code ] = $4;
            data_of_industry[ "2014", industry_code ] = $5;
            data_of_industry[ "2013", industry_code ] = $6;
            data_of_industry[ "2012", industry_code ] = $7;
            data_of_industry[ "2011", industry_code ] = $8;
            data_of_industry[ "2010", industry_code ] = $9;
            data_of_industry[ "2009", industry_code ] = $10;
        }
    }


    # 2013经济普查从业人口
    if ( use_jingji_pucha_faren_congye_2013 && district_code ) {
        printf "%s\"%s\": {\
    \"name\": \"%s\"\
    , \"unit\": \"万\"\
    , \"total_faren\": %s\
    , \"total_congye\": %s\
    , \"chanye2_faren\": %s\
    , \"chanye2_congye\": %s\
    , \"chanye3_faren\": %s\
    , \"chanye3_congye\": %s\
    , \"shiye_faren\": %s\
    , \"shiye_congye\": %s\
    , \"jiguan_faren\": %s\
    , \"jiguan_congye\": %s\
    , \"minbanfei_faren\": %s\
    , \"minbanfei_congye\": %s\
    , \"shehui_faren\": %s\
    , \"shehui_congye\": %s\
}\n", line_prefix, district_code, district_name, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15;

        is_first_line = 0;
    }

    # 城镇从业人口
    if ( use_chengzhen_congye && district_code ) {
        printf "%s\"%s\": {\
    \"name\": \"%s\"\
    , \"unit\": \"万\"\
    , \"2016\": %.1f\
    , \"2015\": %.1f\
    , \"2014\": %.1f\
    , \"2013\": %.1f\
    , \"2012\": %.1f\
    , \"2011\": %.1f\
    , \"2010\": %.1f\
    , \"2009\": %.1f\
}\n", line_prefix, district_code, district_name, $2 / 10000, $3 / 10000, $4 / 10000, $5 / 10000, $6 / 10000, $7 / 10000, $8 / 10000, $9 / 10000;

        is_first_line = 0;
    }

    # 租金月报
    if ( use_zujin_monthly && $1 ) {

        lastFieldOfLine = $11;
        sub( "\r", "", lastFieldOfLine );

        printf "\"%s\": {\
\"district\": \"%s\"\
, \"name\": \"%s\"\
, \"p1810\": \"%s\"\
, \"p1811\": \"%s\"\
, \"link-relative-ratio\": \"%s\"\
}\n", $3, $1, $2, $6, $9, lastFieldOfLine;
    }

}

END {
    if ( use_guomin_jingji_congye ) {
        outer_is_first_item = 1;
        for ( j = 1; j <= length( years ); j++) {
            outer_prefix = "";
            if ( ! outer_is_first_item ) {
                outer_prefix = ", ";
            }
            printf "%s\"%s\": {", outer_prefix, years[ j ];
            inner_is_first_item = 1;
            for ( i = 1; i <= length( industry_codes ); i++ ) {
                inner_prefix = "";
                if ( ! inner_is_first_item ) {
                    inner_prefix = ", ";
                }
                v = data_of_industry[ years[ j ], industry_codes[ i ] ];
                if ( ! v ) v = 0;
                printf "\n    %s\"%s\": %s", inner_prefix, industry_codes[ i ], v;
                inner_is_first_item = 0;
            }
            print " \n    , \"unit\": \"万\"\n}";
            outer_is_first_item = 0;
        }
    }

    if ( use_main ) {
        for( i = 1; i <= 50; i++ ) {
            arr[ i ] = i;
        }

        for ( i in arr ) print arr[ i ];
    }

    print "}";
}
