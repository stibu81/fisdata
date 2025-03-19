# query_standings() works

    Code
      print(wc_al_2025, width = Inf, n = Inf)
    Output
      # A tibble: 91 x 15
         sector athlete                  brand     nation all_rank all_points dh_rank
         <chr>  <chr>                    <chr>     <chr>     <int>      <int>   <int>
       1 AL     Odermatt Marco           Stoeckli  SUI           1       1596       1
       2 AL     Kristoffersen Henrik     Van Deer  NOR           2        961      NA
       3 AL     Meillard Loic            Rossignol SUI           3        831      NA
       4 AL     Von Allmen Franjo        Head      SUI           4        776       2
       5 AL     Haugan Timon             Van Deer  NOR           5        639      NA
       6 AL     Pinheiro Braathen Lucas  Atomic    BRA           6        604      NA
       7 AL     Mcgrath Atle Lie         Head      NOR           7        588      NA
       8 AL     Monney Alexis            Stoeckli  SUI           8        567       3
       9 AL     Paris Dominik            Nordica   ITA           9        524       6
      10 AL     Rogentin Stefan          Fischer   SUI          10        505       8
      11 AL     Noel Clement             Dynastar  FRA          11        490      NA
      12 AL     Kriechmayr Vincent       Head      AUT          12        459      11
      13 AL     Crawford James           Head      CAN          13        452       5
      14 AL     Hrobat Miha              Atomic    SLO          14        440       4
      15 AL     Steen Olsen Alexander    Rossignol NOR          15        430      NA
      16 AL     Casse Mattia             Rossignol ITA          16        382      17
      17 AL     Murisier Justin          Head      SUI          17        381       7
      18 AL     Zubcic Filip             Atomic    CRO          18        378      NA
      19 AL     Allegre Nils             Salomon   FRA          19        345      10
      20 AL     Alexander Cameron        Rossignol CAN          20        338       9
      21 AL     Feller Manuel            Atomic    AUT          21        321      NA
      22 AL     Tumler Thomas            Stoeckli  SUI          22        278      NA
      23 AL     Cochran-Siegle Ryan      Head      USA          23        276      12
      24 AL     Vinatzer Alex            Atomic    ITA          24        272      NA
      25 AL     Nef Tanguy               Atomic    SUI          25        266      NA
      26 AL     Sejersted Adrian Smiseth Atomic    NOR          25        266      14
      27 AL     Moeller Fredrik          Atomic    NOR          27        262      37
      28 AL     Gstrein Fabio            Atomic    AUT          28        259      NA
      29 AL     Strasser Linus           Rossignol GER          29        250      NA
      30 AL     Radamus River            Rossignol USA          29        250      NA
      31 AL     Haaser Raphael           Fischer   AUT          31        245      55
      32 AL     Amiez Steven             Rossignol FRA          32        242      NA
      33 AL     Kranjec Zan              Rossignol SLO          33        241      NA
      34 AL     Brennsteiner Stefan      Fischer   AUT          34        239      NA
      35 AL     Eichberger Stefan        Head      AUT          35        230      15
      36 AL     Popov Albert             Head      BUL          36        229      NA
      37 AL     Kolega Samuel            Rossignol CRO          37        214      NA
      38 AL     Hemetsberger Daniel      Fischer   AUT          38        209      17
      39 AL     Yule Daniel              Fischer   SUI          38        209      NA
      40 AL     De Aliprandini Luca      Salomon   ITA          40        208      NA
      41 AL     Schwarz Marco            Atomic    AUT          41        203      NA
      42 AL     Babinsky Stefan          Head      AUT          41        203      19
      43 AL     Bennett Bryce            Fischer   USA          43        190      13
      44 AL     Jakobsen Kristoffer      Fischer   SWE          44        188      NA
      45 AL     Aerni Luca               Fischer   SUI          45        184      NA
      46 AL     Ryding Dave              Head      GBR          46        183      NA
      47 AL     Feurstein Patrick        Rossignol AUT          47        181      NA
      48 AL     Feurstein Lukas          Head      AUT          48        168      NA
      49 AL     Favrot Thibaut           Dynastar  FRA          49        162      NA
      50 AL     Franzoni Giovanni        Rossignol ITA          50        161      32
      51 AL     Verdu Joan               Head      AND          51        153      NA
      52 AL     Anguenot Leo             Rossignol FRA          52        143      NA
      53 AL     Zabystran Jan            Kaestle   CZE          52        143      30
      54 AL     Maes Sam                 Voelkl    BEL          54        142      NA
      55 AL     Goldberg Jared           Rossignol USA          55        141      37
      56 AL     Schieder Florian         Atomic    ITA          55        141      16
      57 AL     Roesti Lars              Stoeckli  SUI          57        131      21
      58 AL     Sarrazin Cyprien         Rossignol FRA          58        126      31
      59 AL     Caviezel Gino            Atomic    SUI          59        125      NA
      60 AL     Ritchie Benjamin         Head      USA          60        124      NA
      61 AL     Rassat Paco              Head      FRA          61        123      NA
      62 AL     Marchant Armand          Head      BEL          62        122      NA
      63 AL     Muffat-Jeandet Victor    Salomon   FRA          63        120      NA
      64 AL     Baumann Romed            Salomon   GER          64        111      25
      65 AL     Raschner Dominik         Fischer   AUT          65        110      NA
      66 AL     Muzaton Maxence          Rossignol FRA          66        105      20
      67 AL     Matt Michael             Blizzard  AUT          67        100      NA
      68 AL     Lehto Elian              Fischer   FIN          68         97      22
      69 AL     Innerhofer Christof      Rossignol ITA          68         97      34
      70 AL     Strolz Johannes          Head      AUT          70         92      NA
      71 AL     Giezendanner Blaise      Atomic    FRA          71         89      33
      72 AL     Striedinger Otmar        Salomon   AUT          71         89      24
      73 AL     Seger Brodie             Atomic    CAN          73         87      23
      74 AL     Theaux Adrien            Salomon   FRA          73         87      28
      75 AL     Grammel Anton            Head      GER          75         81      NA
      76 AL     Pertl Adrian             Atomic    AUT          76         80      NA
      77 AL     Pinturault Alexis        Head      FRA          77         74      NA
      78 AL     Laine Tormis             Voelkl    EST          78         71      NA
      79 AL     Kohler Marco             Stoeckli  SUI          79         68      26
      80 AL     Rochat Marc              Nordica   SUI          79         68      NA
      81 AL     Monsen Felix             Atomic    SWE          81         65      45
      82 AL     Kastlunger Tobias        Head      ITA          82         61      NA
      83 AL     Gross Stefano            Voelkl    ITA          82         61      NA
      84 AL     Taylor Laurie            Head      GBR          84         59      NA
      85 AL     Naralocnik Nejc          Atomic    SLO          85         58      27
      86 AL     Hallberg Eduard Fischer  <NA>      FIN          86         55      NA
      87 AL     Schmid Alexander         Head      GER          87         53      NA
      88 AL     Cater Martin             Salomon   SLO          88         52      29
      89 AL     Bailet Matthieu          Head      FRA          89         50      40
      90 AL     Loriot Florian           Rossignol FRA          90         49      NA
      91 AL     Negomir Kyle             Atomic    USA          90         49      55
         dh_points gs_rank gs_points sg_rank sg_points sl_rank sl_points competitor_id
             <int>   <int>     <int>   <int>     <int>   <int>     <int> <chr>        
       1       605       1       500       1       491      NA        NA 190231       
       2        NA       2       394      NA        NA       1       567 154950       
       3        NA       4       334      34        32       3       465 174158       
       4       522      NA        NA       6       254      NA        NA 220878       
       5        NA      14       180      NA        NA       4       459 174450       
       6        NA       5       291      NA        NA       6       313 213820       
       7        NA      12       194      NA        NA       5       394 213823       
       8       327      NA        NA       7       240      NA        NA 212375       
       9       262      NA        NA       4       262      NA        NA 109079       
      10       234      NA        NA       3       271      NA        NA 156299       
      11        NA      NA        NA      NA        NA       2       490 187117       
      12       178      NA        NA       2       281      NA        NA 126472       
      13       270      NA        NA       9       182      NA        NA 188682       
      14       320      NA        NA      16       120      NA        NA 163381       
      15        NA       3       346      NA        NA      26        84 222507       
      16       122      NA        NA       5       260      NA        NA 118669       
      17       257      43        14      18       110      NA        NA 138572       
      18        NA       7       244      NA        NA      18       134 146641       
      19       193      NA        NA      10       152      NA        NA 154638       
      20       194      NA        NA      12       144      NA        NA 189309       
      21        NA      33        34      NA        NA       7       287 137557       
      22        NA       6       278      NA        NA      NA        NA 105040       
      23       176      NA        NA      20       100      NA        NA 139503       
      24        NA      21        98      NA        NA      17       174 204319       
      25        NA      NA        NA      NA        NA       8       266 175449       
      26       144      NA        NA      14       122      NA        NA 154956       
      27        28      NA        NA       8       234      NA        NA 213729       
      28        NA      NA        NA      NA        NA       9       259 191304       
      29        NA      49         9      NA        NA      11       241 137475       
      30        NA      11       196      26        50      52         4 194503       
      31         6      22        94      11       145      NA        NA 191305       
      32        NA      NA        NA      NA        NA      10       242 194749       
      33        NA       8       241      NA        NA      NA        NA 137306       
      34        NA       9       239      NA        NA      NA        NA 128892       
      35       129      NA        NA      19       101      NA        NA 214543       
      36        NA      NA        NA      NA        NA      12       229 190120       
      37        NA      NA        NA      NA        NA      13       214 202395       
      38       122      NA        NA      22        87      NA        NA 126467       
      39        NA      NA        NA      NA        NA      14       209 148287       
      40        NA      10       208      NA        NA      NA        NA 118704       
      41        NA      18       121      NA        NA      27        82 169280       
      42       121      NA        NA      23        82      NA        NA 176974       
      43       164      NA        NA      40        26      NA        NA 137204       
      44        NA      NA        NA      NA        NA      15       188 160443       
      45        NA      20       120      NA        NA      30        64 148274       
      46        NA      NA        NA      NA        NA      16       183 77191        
      47        NA      13       181      NA        NA      NA        NA 176104       
      48        NA      34        32      13       136      NA        NA 219777       
      49        NA      15       162      NA        NA      NA        NA 159244       
      50        40      NA        NA      15       121      NA        NA 221571       
      51        NA      16       153      NA        NA      NA        NA 166175       
      52        NA      17       143      NA        NA      NA        NA 195194       
      53        46      NA        NA      21        97      NA        NA 196154       
      54        NA      18       121      NA        NA      42        21 194529       
      55        28      NA        NA      17       113      NA        NA 130869       
      56       128      NA        NA      50        13      NA        NA 165366       
      57        99      NA        NA      34        32      NA        NA 195440       
      58        43      55         3      24        80      NA        NA 154653       
      59        NA      23        89      33        36      NA        NA 138512       
      60        NA      NA        NA      NA        NA      19       124 210997       
      61        NA      NA        NA      NA        NA      20       123 194724       
      62        NA      NA        NA      NA        NA      21       122 189043       
      63        NA      53         5      NA        NA      22       115 108784       
      64        62      NA        NA      28        49      NA        NA 68659        
      65        NA      NA        NA      NA        NA      23       110 159978       
      66       105      NA        NA      NA        NA      NA        NA 120313       
      67        NA      NA        NA      NA        NA      24       100 149514       
      68        70      NA        NA      39        27      NA        NA 215760       
      69        38      NA        NA      25        59      NA        NA 26841        
      70        NA      NA        NA      NA        NA      25        92 137598       
      71        39      NA        NA      26        50      NA        NA 126982       
      72        64      NA        NA      42        25      NA        NA 126498       
      73        66      NA        NA      45        21      NA        NA 164059       
      74        57      NA        NA      36        30      NA        NA 61175        
      75        NA      24        81      NA        NA      NA        NA 195408       
      76        NA      NA        NA      NA        NA      28        80 175813       
      77        NA      26        48      40        26      NA        NA 127048       
      78        NA      29        44      NA        NA      39        27 210853       
      79        59      NA        NA      51         9      NA        NA 189550       
      80        NA      NA        NA      NA        NA      29        68 138575       
      81        20      NA        NA      30        45      NA        NA 156153       
      82        NA      NA        NA      NA        NA      31        61 205709       
      83        NA      NA        NA      NA        NA      31        61 71585        
      84        NA      NA        NA      NA        NA      33        59 175928       
      85        58      NA        NA      NA        NA      NA        NA 205081       
      86        NA      NA        NA      NA        NA      34        55 246186       
      87        NA      25        53      NA        NA      NA        NA 156112       
      88        50      NA        NA      57         2      NA        NA 137323       
      89        27      NA        NA      44        23      NA        NA 172438       
      90        NA      NA        NA      28        49      NA        NA 200704       
      91         6      NA        NA      31        43      NA        NA 195130       

# query_standings() works for nations cup

    Code
      print(wc_al_2025_nations, width = Inf, n = Inf)
    Output
      # A tibble: 32 x 13
         sector athlete                  nation all_rank all_points gs_rank gs_points
         <chr>  <chr>                    <chr>     <int>      <int>   <int>     <int>
       1 AL     Switzerland              SUI           1      10020       1      2043
       2 AL     Austria                  AUT           2       6778       3      1226
       3 AL     Italy                    ITA           3       6072       4      1211
       4 AL     Norway                   NOR           4       4670       2      1714
       5 AL     United States Of America USA           5       3817       5      1029
       6 AL     France                   FRA           6       3118       9       480
       7 AL     Germany                  GER           7       1888      11       343
       8 AL     Sweden                   SWE           8       1779       6       555
       9 AL     Slovenia                 SLO           9       1545      10       447
      10 AL     Canada                   CAN          10       1522      13       298
      11 AL     Croatia                  CRO          11       1482       8       519
      12 AL     New Zealand              NZL          12        668       7       520
      13 AL     Brazil                   BRA          13        664      14       291
      14 AL     Albania                  ALB          14        586      12       334
      15 AL     Czechia                  CZE          15        553      NA        NA
      16 AL     Great Britain            GBR          16        311      NA        NA
      17 AL     Belgium                  BEL          17        288      16       121
      18 AL     Bulgaria                 BUL          18        229      NA        NA
      19 AL     Andorra                  AND          19        153      15       153
      20 AL     Finland                  FIN          20        152      NA        NA
      21 AL     Poland                   POL          21        104      17        98
      22 AL     Estonia                  EST          22         71      18        44
      23 AL     Bosnia And Herzegovina   BIH          23         29      NA        NA
      24 AL     Spain                    ESP          24         16      NA        NA
      25 AL     Slovakia                 SVK          25         13      19        13
      26 AL     Greece                   GRE          26         12      NA        NA
      27 AL     Latvia                   LAT          27         10      NA        NA
      28 AL     Chile                    CHI          28          8      NA        NA
      29 AL     Netherlands              NED          28          8      20         8
      30 AL     Japan                    JPN          30          6      NA        NA
      31 AL     Liechtenstein            LIE          31          4      NA        NA
      32 AL     Argentina                ARG          32          1      21         1
         sl_rank sl_points dh_rank dh_points sg_rank sg_points
           <int>     <int>   <int>     <int>   <int>     <int>
       1       1      2589       1      2816       1      2572
       2       2      2075       3      1560       3      1917
       3       9       518       2      1817       2      2526
       4       3      1877       8       415       6       664
       5       7       880       4      1055       4       853
       6       4      1269       5       594       5       775
       7       8       820       9       383       8       342
       8       5      1159      12        20      12        45
       9      11       342       6       562      10       194
      10      15       220       7       543       7       461
      11       6       963      NA        NA      NA        NA
      12      NA        NA      15         4      11       144
      13      10       373      NA        NA      NA        NA
      14      13       252      NA        NA      NA        NA
      15      18        36      10       229       9       288
      16      12       311      NA        NA      NA        NA
      17      16       167      NA        NA      NA        NA
      18      14       229      NA        NA      NA        NA
      19      NA        NA      NA        NA      NA        NA
      20      17        55      11        70      13        27
      21      NA        NA      NA        NA      15         6
      22      19        27      NA        NA      NA        NA
      23      NA        NA      14         6      14        23
      24      20        16      NA        NA      NA        NA
      25      NA        NA      NA        NA      NA        NA
      26      21        12      NA        NA      NA        NA
      27      22        10      NA        NA      NA        NA
      28      NA        NA      13         8      NA        NA
      29      NA        NA      NA        NA      NA        NA
      30      23         6      NA        NA      NA        NA
      31      NA        NA      15         4      NA        NA
      32      NA        NA      NA        NA      NA        NA

