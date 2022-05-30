//+------------------------------------------------------------------+
//|                                                FontSelection.mqh |
//|                               Copyright 2022, Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svetozar Pasulschi"
#property link      "https://www.mql5.com"

#define  FONT_MALGNUM                              "@Malgun Gothic"
#define  FONT_MALGNUM_GOTHIC_SEMILIGHT             "@Malgun Gothic Semilight"
#define  FONT_MICROSOFT_JHENGHEI                   "@Microsoft JhengHei"
#define  FONT_MICROSOFT_JHENGHEI_LIGHT             "@Microsoft JhengHei Light"
#define  FONT_MICROSOFT_JHENGHEI_UI                "@Microsoft JhengHei UI"
#define  FONT_MICROSOFT_JHENGHEI_UI_LIGHT          "@Microsoft JhengHei UI Light"
#define  FONT_MICROSOFT_YAHEI                      "@Microsoft YaHei"
#define  FONT_MICROSOFT_YAHEI_LIGHT                "@Microsoft YaHei Light"
#define  FONT_MICROSOFT_YAHEI_UI                   "@Microsoft YaHei UI"
#define  FONT_MICROSOFT_YAHEI_UI_LIGHT             "@Microsoft YaHei UI Light"
#define  FONT_MINGLIU_HKSCS_EXTB                   "@MingLiU_HKSCS-ExtB"
#define  FONT_MINGLIU_EXTB                         "@MingLiU-ExtB"
#define  FONT_MS_GOTHIC                            "@MS Gothic"
#define  FONT_MS_PGOTHIC                           "@MS PGothic"
#define  FONT_MS_UI_GOTHIC                         "@MS UI Gothic"
#define  FONT_NSIMSUN                              "@NSimSun"
#define  FONT_PMINGLIU_EXTB                        "@PMingLiU-ExtB"
#define  FONT_SIMSUN                               "@SimSun"
#define  FONT_SIMSUN_EXTB                          "@SimSun-ExtB"
#define  FONT_YU_GOTHIC                            "@Yu Gothic"
#define  FONT_YU_GOTHIC_LIGHT                      "@Yu Gothic Light"
#define  FONT_YU_GOTHIC_MEDIUM                     "@Yu Gothic Medium"
#define  FONT_YU_GOTHIC_UI                         "@Yu Gothic UI"
#define  FONT_YU_GOTHIC_UI_LIGHT                   "@Yu Gothic UI Light"
#define  FONT_YU_GOTHIC_UI_SEMIBOLD                "@Yu Gothic UI Semibold"
#define  FONT_YU_GOTHIC_UI_UI_SEMILIGHT            "@Yu Gothic UI Semilight"
#define  FONT_ARIAL                                "Arial"
#define  FONT_ARIAL_BLACK                          "Arial Black"
#define  FONT_BAHNSCHRIFT_CONDENSED                "Bahnschrift Condensed"
#define  FONT_BAHNSCHRIFT_LIGHT                    "Bahnschrift Light"
#define  FONT_BAHNSCHRIFT_LIGHT_CONDENSED          "Bahnschrift Light Condensed"
#define  FONT_BAHNSCHRIFT_LIGHT_SEMICONDENSED      "Bahnschrift Light SemiCondensed"
#define  FONT_BAHNSCHRIFT_SEMIBOLD                 "Bahnschrift SemiBold"
#define  FONT_BAHNSCHRIFT_SEMIBOLD_CONDENSED       "Bahnschrift SemiBold Condensed"
#define  FONT_BAHNSCHRIFT_SEMIBOLD_SEMICONDENSED   "Bahnschrift SemiBold SemiCondensed"
#define  FONT_BAHNSCHRIFT_SEMICONDENSED            "Bahnschrift SemiCondensed"
#define  FONT_BAHNSCHRIFT_SEMILIGHT                "Bahnschrift SemiLight"
#define  FONT_BAHNSCHRIFT_SEMILIGHT_CONDENSED      "Bahnschrift SemiLight Condensed"
#define  FONT_BAHNSCHRIFT_SEMILIGHT_SEMICONDENSED  "Bahnschrift SemiLight SemiCondensed"
#define  FONT_CALIBRI                              "Calibri"
#define  FONT_CALIBRI_LIGHT                        "Calibri Light"
#define  FONT_CAMBRIA                              "Cambria"
#define  FONT_CAMBRIA_MATH                         "Cambria Math"
#define  FONT_CANDARA                              "Candara"
#define  FONT_CANDARA_LIGHT                        "Candara Light"
#define  FONT_COMIC_SANS_MS                        "Comic Sans MS"
#define  FONT_CONSOLAS                             "Consolas"
#define  FONT_CONSTANTIA                           "Constantia"
#define  FONT_CORBEL                               "Corbel"
#define  FONT_CORBEL_LIGHT                         "Corbel Light"
#define  FONT_COURIER                              "Courier"
#define  FONT_COURIER_NEW                          "Courier New"
#define  FONT_EBRIMA                               "Ebrima"
#define  FONT_FIXEDSYS                             "Fixedsys"
#define  FONT_FRANKLIN_GOTHIC_MEDIUM               "Franklin Gothic Medium"
#define  FONT_GABRIOLA                             "Gabriola"


string FONT_ARRAY[] = {
   "@Malgun Gothic", "@Malgun Gothic Semilight", "@Microsoft JhengHei", "@Microsoft JhengHei Light",  "@Microsoft JhengHei UI",  "@Microsoft JhengHei UI Light",  "@Microsoft YaHei", "@Microsoft YaHei Light",
   "@Microsoft YaHei UI",  "@Microsoft YaHei UI Light",  "@MingLiU_HKSCS-ExtB", "@MingLiU-ExtB",  "@MS Gothic",  "@MS PGothic",  "@MS UI Gothic",  "@NSimSun",  "@PMingLiU-ExtB",  "@SimSun",  "@SimSun-ExtB",
   "@Yu Gothic",  "@Yu Gothic Light", "@Yu Gothic Medium", "@Yu Gothic UI", "@Yu Gothic UI Light",  "@Yu Gothic UI Semibold", "@Yu Gothic UI Semilight",  "Aria", "Arial Black", "Bahnschrift Condensed",
   "Bahnschrift Light", "Bahnschrift Light Condensed", "Bahnschrift Light SemiCondensed", "Bahnschrift SemiBold", "Bahnschrift SemiBold Condensed", "Bahnschrift SemiBold SemiCondensed",
   "Bahnschrift SemiCondensed", "Bahnschrift SemiLight", "Bahnschrift SemiLight Condensed", "Bahnschrift SemiLight SemiCondensed", "Calibri", "Calibri Light", "Cambria", "Cambria Math", "Candara",
   "Candara Light", "Comic Sans MS", "Consolas", "Constantia", "Corbel", "Corbel Light", "Courier", "Courier New", "Ebrima", "Fixedsys", "Franklin Gothic Medium",  "Gabriola"
   };
