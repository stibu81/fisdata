# query_standings() works

    Code
      print(wc_al_2025, width = Inf, n = Inf)
    Output
      # A tibble: 91 x 13
         athlete                  brand     nation all_rank all_points dh_rank
         <chr>                    <chr>     <chr>     <int>      <int>   <int>
       1 Odermatt Marco           Stoeckli  SUI           1       1596       1
       2 Kristoffersen Henrik     Van Deer  NOR           2        961      NA
       3 Meillard Loic            Rossignol SUI           3        831      NA
       4 Von Allmen Franjo        Head      SUI           4        776       2
       5 Haugan Timon             Van Deer  NOR           5        639      NA
       6 Pinheiro Braathen Lucas  Atomic    BRA           6        604      NA
       7 Mcgrath Atle Lie         Head      NOR           7        588      NA
       8 Monney Alexis            Stoeckli  SUI           8        567       3
       9 Paris Dominik            Nordica   ITA           9        524       6
      10 Rogentin Stefan          Fischer   SUI          10        505       8
      11 Noel Clement             Dynastar  FRA          11        490      NA
      12 Kriechmayr Vincent       Head      AUT          12        459      11
      13 Crawford James           Head      CAN          13        452       5
      14 Hrobat Miha              Atomic    SLO          14        440       4
      15 Steen Olsen Alexander    Rossignol NOR          15        430      NA
      16 Casse Mattia             Rossignol ITA          16        382      17
      17 Murisier Justin          Head      SUI          17        381       7
      18 Zubcic Filip             Atomic    CRO          18        378      NA
      19 Allegre Nils             Salomon   FRA          19        345      10
      20 Alexander Cameron        Rossignol CAN          20        338       9
      21 Feller Manuel            Atomic    AUT          21        321      NA
      22 Tumler Thomas            Stoeckli  SUI          22        278      NA
      23 Cochran-Siegle Ryan      Head      USA          23        276      12
      24 Vinatzer Alex            Atomic    ITA          24        272      NA
      25 Nef Tanguy               Atomic    SUI          25        266      NA
      26 Sejersted Adrian Smiseth Atomic    NOR          25        266      14
      27 Moeller Fredrik          Atomic    NOR          27        262      37
      28 Gstrein Fabio            Atomic    AUT          28        259      NA
      29 Strasser Linus           Rossignol GER          29        250      NA
      30 Radamus River            Rossignol USA          29        250      NA
      31 Haaser Raphael           Fischer   AUT          31        245      55
      32 Amiez Steven             Rossignol FRA          32        242      NA
      33 Kranjec Zan              Rossignol SLO          33        241      NA
      34 Brennsteiner Stefan      Fischer   AUT          34        239      NA
      35 Eichberger Stefan        Head      AUT          35        230      15
      36 Popov Albert             Head      BUL          36        229      NA
      37 Kolega Samuel            Rossignol CRO          37        214      NA
      38 Hemetsberger Daniel      Fischer   AUT          38        209      17
      39 Yule Daniel              Fischer   SUI          38        209      NA
      40 De Aliprandini Luca      Salomon   ITA          40        208      NA
      41 Schwarz Marco            Atomic    AUT          41        203      NA
      42 Babinsky Stefan          Head      AUT          41        203      19
      43 Bennett Bryce            Fischer   USA          43        190      13
      44 Jakobsen Kristoffer      Fischer   SWE          44        188      NA
      45 Aerni Luca               Fischer   SUI          45        184      NA
      46 Ryding Dave              Head      GBR          46        183      NA
      47 Feurstein Patrick        Rossignol AUT          47        181      NA
      48 Feurstein Lukas          Head      AUT          48        168      NA
      49 Favrot Thibaut           Dynastar  FRA          49        162      NA
      50 Franzoni Giovanni        Rossignol ITA          50        161      32
      51 Verdu Joan               Head      AND          51        153      NA
      52 Anguenot Leo             Rossignol FRA          52        143      NA
      53 Zabystran Jan            Kaestle   CZE          52        143      30
      54 Maes Sam                 Voelkl    BEL          54        142      NA
      55 Goldberg Jared           Rossignol USA          55        141      37
      56 Schieder Florian         Atomic    ITA          55        141      16
      57 Roesti Lars              Stoeckli  SUI          57        131      21
      58 Sarrazin Cyprien         Rossignol FRA          58        126      31
      59 Caviezel Gino            Atomic    SUI          59        125      NA
      60 Ritchie Benjamin         Head      USA          60        124      NA
      61 Rassat Paco              Head      FRA          61        123      NA
      62 Marchant Armand          Head      BEL          62        122      NA
      63 Muffat-Jeandet Victor    Salomon   FRA          63        120      NA
      64 Baumann Romed            Salomon   GER          64        111      25
      65 Raschner Dominik         Fischer   AUT          65        110      NA
      66 Muzaton Maxence          Rossignol FRA          66        105      20
      67 Matt Michael             Blizzard  AUT          67        100      NA
      68 Lehto Elian              Fischer   FIN          68         97      22
      69 Innerhofer Christof      Rossignol ITA          68         97      34
      70 Strolz Johannes          Head      AUT          70         92      NA
      71 Giezendanner Blaise      Atomic    FRA          71         89      33
      72 Striedinger Otmar        Salomon   AUT          71         89      24
      73 Seger Brodie             Atomic    CAN          73         87      23
      74 Theaux Adrien            Salomon   FRA          73         87      28
      75 Grammel Anton            Head      GER          75         81      NA
      76 Pertl Adrian             Atomic    AUT          76         80      NA
      77 Pinturault Alexis        Head      FRA          77         74      NA
      78 Laine Tormis             Voelkl    EST          78         71      NA
      79 Kohler Marco             Stoeckli  SUI          79         68      26
      80 Rochat Marc              Nordica   SUI          79         68      NA
      81 Monsen Felix             Atomic    SWE          81         65      45
      82 Kastlunger Tobias        Head      ITA          82         61      NA
      83 Gross Stefano            Voelkl    ITA          82         61      NA
      84 Taylor Laurie            Head      GBR          84         59      NA
      85 Naralocnik Nejc          Atomic    SLO          85         58      27
      86 Hallberg Eduard Fischer  <NA>      FIN          86         55      NA
      87 Schmid Alexander         Head      GER          87         53      NA
      88 Cater Martin             Salomon   SLO          88         52      29
      89 Bailet Matthieu          Head      FRA          89         50      40
      90 Loriot Florian           Rossignol FRA          90         49      NA
      91 Negomir Kyle             Atomic    USA          90         49      55
         dh_points gs_rank gs_points sg_rank sg_points sl_rank sl_points
             <int>   <int>     <int>   <int>     <int>   <int>     <int>
       1       605       1       500       1       491      NA        NA
       2        NA       2       394      NA        NA       1       567
       3        NA       4       334      34        32       3       465
       4       522      NA        NA       6       254      NA        NA
       5        NA      14       180      NA        NA       4       459
       6        NA       5       291      NA        NA       6       313
       7        NA      12       194      NA        NA       5       394
       8       327      NA        NA       7       240      NA        NA
       9       262      NA        NA       4       262      NA        NA
      10       234      NA        NA       3       271      NA        NA
      11        NA      NA        NA      NA        NA       2       490
      12       178      NA        NA       2       281      NA        NA
      13       270      NA        NA       9       182      NA        NA
      14       320      NA        NA      16       120      NA        NA
      15        NA       3       346      NA        NA      26        84
      16       122      NA        NA       5       260      NA        NA
      17       257      43        14      18       110      NA        NA
      18        NA       7       244      NA        NA      18       134
      19       193      NA        NA      10       152      NA        NA
      20       194      NA        NA      12       144      NA        NA
      21        NA      33        34      NA        NA       7       287
      22        NA       6       278      NA        NA      NA        NA
      23       176      NA        NA      20       100      NA        NA
      24        NA      21        98      NA        NA      17       174
      25        NA      NA        NA      NA        NA       8       266
      26       144      NA        NA      14       122      NA        NA
      27        28      NA        NA       8       234      NA        NA
      28        NA      NA        NA      NA        NA       9       259
      29        NA      49         9      NA        NA      11       241
      30        NA      11       196      26        50      52         4
      31         6      22        94      11       145      NA        NA
      32        NA      NA        NA      NA        NA      10       242
      33        NA       8       241      NA        NA      NA        NA
      34        NA       9       239      NA        NA      NA        NA
      35       129      NA        NA      19       101      NA        NA
      36        NA      NA        NA      NA        NA      12       229
      37        NA      NA        NA      NA        NA      13       214
      38       122      NA        NA      22        87      NA        NA
      39        NA      NA        NA      NA        NA      14       209
      40        NA      10       208      NA        NA      NA        NA
      41        NA      18       121      NA        NA      27        82
      42       121      NA        NA      23        82      NA        NA
      43       164      NA        NA      40        26      NA        NA
      44        NA      NA        NA      NA        NA      15       188
      45        NA      20       120      NA        NA      30        64
      46        NA      NA        NA      NA        NA      16       183
      47        NA      13       181      NA        NA      NA        NA
      48        NA      34        32      13       136      NA        NA
      49        NA      15       162      NA        NA      NA        NA
      50        40      NA        NA      15       121      NA        NA
      51        NA      16       153      NA        NA      NA        NA
      52        NA      17       143      NA        NA      NA        NA
      53        46      NA        NA      21        97      NA        NA
      54        NA      18       121      NA        NA      42        21
      55        28      NA        NA      17       113      NA        NA
      56       128      NA        NA      50        13      NA        NA
      57        99      NA        NA      34        32      NA        NA
      58        43      55         3      24        80      NA        NA
      59        NA      23        89      33        36      NA        NA
      60        NA      NA        NA      NA        NA      19       124
      61        NA      NA        NA      NA        NA      20       123
      62        NA      NA        NA      NA        NA      21       122
      63        NA      53         5      NA        NA      22       115
      64        62      NA        NA      28        49      NA        NA
      65        NA      NA        NA      NA        NA      23       110
      66       105      NA        NA      NA        NA      NA        NA
      67        NA      NA        NA      NA        NA      24       100
      68        70      NA        NA      39        27      NA        NA
      69        38      NA        NA      25        59      NA        NA
      70        NA      NA        NA      NA        NA      25        92
      71        39      NA        NA      26        50      NA        NA
      72        64      NA        NA      42        25      NA        NA
      73        66      NA        NA      45        21      NA        NA
      74        57      NA        NA      36        30      NA        NA
      75        NA      24        81      NA        NA      NA        NA
      76        NA      NA        NA      NA        NA      28        80
      77        NA      26        48      40        26      NA        NA
      78        NA      29        44      NA        NA      39        27
      79        59      NA        NA      51         9      NA        NA
      80        NA      NA        NA      NA        NA      29        68
      81        20      NA        NA      30        45      NA        NA
      82        NA      NA        NA      NA        NA      31        61
      83        NA      NA        NA      NA        NA      31        61
      84        NA      NA        NA      NA        NA      33        59
      85        58      NA        NA      NA        NA      NA        NA
      86        NA      NA        NA      NA        NA      34        55
      87        NA      25        53      NA        NA      NA        NA
      88        50      NA        NA      57         2      NA        NA
      89        27      NA        NA      44        23      NA        NA
      90        NA      NA        NA      28        49      NA        NA
      91         6      NA        NA      31        43      NA        NA

