# query_race() works for an alpine skiing world cup race

    Code
      print(wengen_dh, width = Inf, n = Inf)
    Output
      # A tibble: 48 x 11
          rank   bib fis_code name                     brand     birth_year nation
         <int> <int> <chr>    <chr>                    <chr>          <int> <chr> 
       1     1    13 512269   Odermatt Marco           Stoeckli        1997 SUI   
       2     2    12 512471   Von Allmen Franjo        Head            2001 SUI   
       3     3     1 561310   Hrobat Miha              Atomic          1995 SLO   
       4     4     6 291459   Paris Dominik            Nordica         1989 ITA   
       5     5     7 104537   Alexander Cameron        Rossignol       1997 CAN   
       6     6    14 6530104  Bennett Bryce            Fischer         1992 USA   
       7     7     9 511896   Murisier Justin          Head            1992 SUI   
       8     8    37 512281   Roesti Lars              Stoeckli        1998 SUI   
       9     9    16 104531   Crawford James           Head            1997 CAN   
      10    10     3 6291625  Schieder Florian         Atomic          1995 ITA   
      11    11    11 6530319  Cochran-Siegle Ryan      Head            1992 USA   
      12    12     2 512038   Rogentin Stefan          Fischer         1994 SUI   
      13    13    15 990081   Casse Mattia             Rossignol       1990 ITA   
      14    14    17 194167   Muzaton Maxence          Rossignol       1990 FRA   
      15    15    25 6531520  Morse Sam                Fischer         1996 USA   
      16    16    34 934643   Goldberg Jared           Rossignol       1991 USA   
      17    17     5 54005    Striedinger Otmar        Salomon         1991 AUT   
      18    18    10 194858   Allegre Nils             Salomon         1994 FRA   
      19    19    31 180877   Lehto Elian              Fischer         2000 FIN   
      20    20    32 6190176  Bailet Matthieu          Head            1996 FRA   
      21    21     4 54371    Babinsky Stefan          Head            1996 AUT   
      22    22    36 151238   Zabystran Jan            Kaestle         1998 CZE   
      23    23    42 110324   Von Appen Henrik         Head            1994 CHI   
      24    24    23 422310   Sejersted Adrian Smiseth Atomic          1994 NOR   
      25    24    21 192746   Theaux Adrien            Salomon         1984 FRA   
      26    26    22 104272   Seger Brodie             Atomic          1995 CAN   
      27    27    43 203096   Vogt Luis                Rossignol       2002 GER   
      28    28    48 6293445  Alliod Benjamin Jacques  Rossignol       2000 ITA   
      29    28    30 53975    Hemetsberger Daniel      Fischer         1991 AUT   
      30    30    47 54538    Rieser Stefan            Atomic          1999 AUT   
      31    31    19 512228   Kohler Marco             Stoeckli        1997 SUI   
      32    32    29 54609    Eichberger Stefan        Head            2000 AUT   
      33    33    53 6293831  Franzoni Giovanni        Rossignol       2001 ITA   
      34    34    28 561255   Cater Martin             Salomon         1992 SLO   
      35    35    26 293006   Innerhofer Christof      Rossignol       1984 ITA   
      36    36    35 512303   Boisset Arnaud           Salomon         1998 SUI   
      37    37    41 561397   Naralocnik Nejc          Atomic          1999 SLO   
      38    38    39 54481    Traninger Manuel         Atomic          1998 AUT   
      39    39    45 350095   Pfiffner Marco           Salomon         1994 LIE   
      40    40    33 104468   Read Jeffrey             Atomic          1997 CAN   
      41    41    24 6190179  Alphand Nils             Head            1996 FRA   
      42    42    40 930024   Maple Wiley              Atomic          1990 USA   
      43    43    54 54438    Ploier Andreas           Fischer         1997 AUT   
      44    44    50 501987   Monsen Felix             Atomic          1994 SWE   
      45    45    49 6190556  Caillot Ken              Atomic          1998 FRA   
      46    46    44 6292783  Molteni Nicolo           Head            1998 ITA   
      47    47    38 6532123  Negomir Kyle             Atomic          1998 USA   
      48    48    52 54080    Neumayer Christopher     Atomic          1992 AUT   
         time      diff_time fis_points cup_points
         <Period>  <Period>       <dbl>      <dbl>
       1 2M 22.58S 0S              0           100
       2 2M 22.95S 0.37S           3.24         80
       3 2M 23.15S 0.57S           5            60
       4 2M 23.27S 0.69S           6.05         50
       5 2M 23.29S 0.71S           6.22         45
       6 2M 23.41S 0.83S           7.28         40
       7 2M 23.76S 1.18S          10.4          36
       8 2M 23.85S 1.27S          11.1          32
       9 2M 23.86S 1.28S          11.2          29
      10 2M 23.95S 1.37S          12.0          26
      11 2M 24.03S 1.45S          12.7          24
      12 2M 24.24S 1.66S          14.6          22
      13 2M 24.31S 1.73S          15.2          20
      14 2M 24.68S 2.1S           18.4          18
      15 2M 24.75S 2.17S          19.0          16
      16 2M 24.96S 2.38S          20.9          15
      17 2M 24.97S 2.39S          21.0          14
      18 2M 24.99S 2.41S          21.1          13
      19 2M 25.13S 2.55S          22.4          12
      20 2M 25.29S 2.71S          23.8          11
      21 2M 25.34S 2.76S          24.2          10
      22 2M 25.36S 2.78S          24.4           9
      23 2M 25.44S 2.86S          25.1           8
      24 2M 25.47S 2.89S          25.3           7
      25 2M 25.47S 2.89S          25.3           7
      26 2M 25.48S 2.9S           25.4           5
      27 2M 25.5S  2.92S          25.6           4
      28 2M 25.51S 2.93S          25.7           3
      29 2M 25.51S 2.93S          25.7           3
      30 2M 25.53S 2.95S          25.9           1
      31 2M 25.58S 3S             26.3           0
      32 2M 25.76S 3.18S          27.9           0
      33 2M 25.86S 3.28S          28.8           0
      34 2M 26.03S 3.45S          30.2           0
      35 2M 26.13S 3.55S          31.1           0
      36 2M 26.15S 3.57S          31.3           0
      37 2M 26.22S 3.64S          31.9           0
      38 2M 26.25S 3.67S          32.2           0
      39 2M 26.28S 3.7S           32.4           0
      40 2M 26.44S 3.86S          33.8           0
      41 2M 26.64S 4.06S          35.6           0
      42 2M 26.94S 4.36S          38.2           0
      43 2M 27.07S 4.49S          39.4           0
      44 2M 27.15S 4.57S          40.1           0
      45 2M 27.36S 4.78S          41.9           0
      46 2M 27.38S 4.8S           42.1           0
      47 2M 28.07S 5.49S          48.1           0
      48 2M 28.08S 5.5S           48.2           0

# query_race() works for an alpine skiing world cup race with 2 runs

    Code
      print(chuenis_gs, width = Inf, n = Inf)
    Output
      # A tibble: 25 x 13
          rank   bib fis_code name                 brand     birth_year nation
         <int> <int> <chr>    <chr>                <chr>          <int> <chr> 
       1     1     4 512269   Odermatt Marco       Stoeckli        1997 SUI   
       2     2     1 512182   Meillard Loic        Rossignol       1996 SUI   
       3     3    10 990116   De Aliprandini Luca  Salomon         1990 ITA   
       4     4    11 511638   Tumler Thomas        Stoeckli        1989 SUI   
       5     5     5 380335   Zubcic Filip         Atomic          1993 CRO   
       6     6    15 422507   Haugan Timon         Van Deer        1996 NOR   
       7     7    26 511983   Aerni Luca           Fischer         1993 SUI   
       8     8    12 20398    Verdu Joan           Head            1995 AND   
       9     9     8 54320    Schwarz Marco        Atomic          1995 AUT   
      10    10    14 6532084  Radamus River        Rossignol       1998 USA   
      11    11    28 6293775  Della Vite Filippo   Rossignol       2001 ITA   
      12    12    17 194364   Pinturault Alexis    Head            1991 FRA   
      13    13    18 194935   Favrot Thibaut       Dynastar        1994 FRA   
      14    14     6 561244   Kranjec Zan          Rossignol       1992 SLO   
      15    15    16 54063    Feller Manuel        Atomic          1992 AUT   
      16    16    29 202883   Grammel Anton        Head            1998 GER   
      17    17    47 54628    Feurstein Lukas      Head            2001 AUT   
      18    18    35 202909   Stockinger Jonas     Voelkl          1999 GER   
      19    18    22 60261    Maes Sam             Voelkl          1998 BEL   
      20    18    13 6293171  Vinatzer Alex        Atomic          1999 ITA   
      21    21    20 54359    Feurstein Patrick    Rossignol       1996 AUT   
      22    22    42 54631    Zwischenbrugger Noel Atomic          2001 AUT   
      23    23    41 6531928  Kenney Patrick       Voelkl          1997 USA   
      24    24    30 202829   Gratz Fabian         Fischer         1997 GER   
      25    25    31 390044   Laine Tormis         Voelkl          2000 EST   
         run1      run2      total_time diff_time fis_points cup_points
         <Period>  <Period>  <Period>   <Period>       <dbl>      <dbl>
       1 1M 15.49S 1M 12.06S 2M 27.55S  0S              0           100
       2 1M 15.15S 1M 12.6S  2M 27.75S  0.2S            1.37         80
       3 1M 16.55S 1M 11.69S 2M 28.24S  0.69S           4.72         60
       4 1M 15.83S 1M 12.86S 2M 28.69S  1.14S           7.8          50
       5 1M 16.31S 1M 12.7S  2M 29.01S  1.46S           9.99         45
       6 1M 16.48S 1M 12.8S  2M 29.28S  1.73S          11.8          40
       7 1M 16.88S 1M 12.53S 2M 29.41S  1.86S          12.7          36
       8 1M 16.08S 1M 13.59S 2M 29.67S  2.12S          14.5          32
       9 1M 16.49S 1M 13.19S 2M 29.68S  2.13S          14.6          29
      10 1M 17.3S  1M 12.63S 2M 29.93S  2.38S          16.3          26
      11 1M 16.78S 1M 13.16S 2M 29.94S  2.39S          16.4          24
      12 1M 16.75S 1M 13.38S 2M 30.13S  2.58S          17.7          22
      13 1M 17.14S 1M 13.07S 2M 30.21S  2.66S          18.2          20
      14 1M 16.13S 1M 14.13S 2M 30.26S  2.71S          18.6          18
      15 1M 17.85S 1M 12.64S 2M 30.49S  2.94S          20.1          16
      16 1M 17.43S 1M 13.11S 2M 30.54S  2.99S          20.5          15
      17 1M 18.32S 1M 12.42S 2M 30.74S  3.19S          21.8          14
      18 1M 18.24S 1M 12.66S 2M 30.9S   3.35S          22.9          13
      19 1M 17.48S 1M 13.42S 2M 30.9S   3.35S          22.9          13
      20 1M 17.27S 1M 13.63S 2M 30.9S   3.35S          22.9          13
      21 1M 17.53S 1M 13.75S 2M 31.28S  3.73S          25.5          10
      22 1M 18.52S 1M 12.81S 2M 31.33S  3.78S          25.9           9
      23 1M 18.21S 1M 13.85S 2M 32.06S  4.51S          30.9           8
      24 1M 17.63S 1M 14.52S 2M 32.15S  4.6S           31.5           7
      25 1M 18.09S 1M 14.64S 2M 32.73S  5.18S          35.5           6

# query_race() works for an alpine skiing parallel race

    Code
      print(chamonix_par, width = Inf, n = Inf)
    Output
      # A tibble: 32 x 7
          rank   bib fis_code name                          birth_year nation
         <int> <int> <chr>    <chr>                              <int> <chr> 
       1     1     7 512182   Meillard Loic                       1996 SUI   
       2     2    20 511638   Tumler Thomas                       1989 SUI   
       3     3    19 202597   Schmid Alexander                    1994 GER   
       4     4    16 531799   Ford Tommy                          1989 USA   
       5     5    11 561244   Kranjec Zan                         1992 SLO   
       6     6    24 194935   Favrot Thibaut                      1994 FRA   
       7     7    18 422139   Kilde Aleksander Aamodt             1992 NOR   
       8     8     5 6291430  Maurberger Simon                    1995 ITA   
       9     9     8 54444    Gstrein Fabio                       1997 AUT   
      10    10    27 422304   Kristoffersen Henrik                1994 NOR   
      11    11     2 990116   De Aliprandini Luca                 1990 ITA   
      12    12    12 380335   Zubcic Filip                        1993 CRO   
      13    13     3 194364   Pinturault Alexis                   1991 FRA   
      14    14     1 990048   Borsotti Giovanni                   1990 ITA   
      15    15     4 202451   Strasser Linus                      1992 GER   
      16    16    23 103729   Read Erik                           1991 CAN   
      17    17    21 422729   Braathen Lucas                      2000 NOR   
      18    18    14 54031    Leitinger Roland                    1991 AUT   
      19    19     9 502015   Jakobsen Kristoffer                 1994 SWE   
      20    20    26 421669   Nestvold-Haugen Leif Kristian       1987 NOR   
      21    21    25 481327   Trikhichev Pavel                    1992 RUS   
      22    21    17 561322   Hadalin Stefan                      1995 SLO   
      23    23    30 194495   Faivre Mathieu                      1992 FRA   
      24    24     6 54320    Schwarz Marco                       1995 AUT   
      25    25    22 193967   Muffat-Jeandet Victor               1989 FRA   
      26    26    13 103865   Philp Trevor                        1992 CAN   
      27    27    10 194873   Sarrazin Cyprien                    1994 FRA   
      28    28    15 422278   Windingstad Rasmus                  1993 NOR   
      29    29    29 422469   Solheim Fabian Wilkens              1996 NOR   
      30    29    28 202437   Luitz Stefan                        1992 GER   
      31    31    31 422507   Haugan Timon                        1996 NOR   
      32    32    32 512203   Nef Tanguy                          1996 SUI   
         cup_points
              <dbl>
       1        100
       2         80
       3         60
       4         50
       5         45
       6         40
       7         36
       8         32
       9         29
      10         26
      11         24
      12         22
      13         20
      14         18
      15         16
      16         15
      17         14
      18         13
      19         12
      20         11
      21         10
      22         10
      23          8
      24          7
      25          6
      26          5
      27          4
      28          3
      29          2
      30          2
      31          1
      32          1

# query_race() works for an alpine skiing world championships race

    Code
      print(wsc_dh, width = Inf, n = Inf)
    Output
      # A tibble: 41 x 9
          rank   bib fis_code name                     birth_year nation time     
         <int> <int> <chr>    <chr>                         <int> <chr>  <Period> 
       1     1    10 512269   Odermatt Marco                 1997 SUI    1M 47.05S
       2     2    15 422139   Kilde Aleksander Aamodt        1992 NOR    1M 47.53S
       3     3    20 104537   Alexander Cameron              1997 CAN    1M 47.94S
       4     4    21 54320    Schwarz Marco                  1995 AUT    1M 47.98S
       5     5    12 104531   Crawford James                 1997 CAN    1M 48.06S
       6     6    24 194167   Muzaton Maxence                1990 FRA    1M 48.13S
       7     7     1 6291625  Schieder Florian               1995 ITA    1M 48.14S
       8     8    28 561310   Hrobat Miha                    1995 SLO    1M 48.18S
       9     8    14 291459   Paris Dominik                  1989 ITA    1M 48.18S
      10    10    16 202535   Dressen Thomas                 1993 GER    1M 48.2S 
      11    11     6 53980    Kriechmayr Vincent             1991 AUT    1M 48.21S
      12    12    23 511896   Murisier Justin                1992 SUI    1M 48.28S
      13    12     9 512124   Hintermann Niels               1995 SUI    1M 48.28S
      14    14     7 53975    Hemetsberger Daniel            1991 AUT    1M 48.33S
      15    15    19 293550   Marsaglia Matteo               1985 ITA    1M 48.58S
      16    16     3 422310   Sejersted Adrian Smiseth       1994 NOR    1M 48.63S
      17    17    31 6531444  Arvidsson Erik                 1996 USA    1M 48.66S
      18    18    29 512408   Monney Alexis                  2000 SUI    1M 48.8S 
      19    19     4 51215    Baumann Romed                  1986 GER    1M 48.85S
      20    20    11 990081   Casse Mattia                   1990 ITA    1M 48.88S
      21    21    30 194858   Allegre Nils                   1994 FRA    1M 48.92S
      22    22    34 110324   Von Appen Henrik               1994 CHI    1M 48.93S
      23    23     8 191740   Clarey Johan                   1981 FRA    1M 48.94S
      24    24     2 6530319  Cochran-Siegle Ryan            1992 USA    1M 48.95S
      25    25    33 180877   Lehto Elian                    2000 FIN    1M 48.97S
      26    26    18 934643   Goldberg Jared                 1991 USA    1M 49.03S
      27    27    17 202059   Ferstl Josef                   1988 GER    1M 49.12S
      28    28    13 530874   Ganong Travis                  1988 USA    1M 49.25S
      29    29    27 200379   Sander Andreas                 1989 GER    1M 49.45S
      30    30    32 104468   Read Jeffrey                   1997 CAN    1M 49.5S 
      31    31    38 561397   Naralocnik Nejc                1999 SLO    1M 49.62S
      32    32    35 54371    Babinsky Stefan                1996 AUT    1M 49.74S
      33    33    36 350095   Pfiffner Marco                 1994 LIE    1M 50.5S 
      34    34    22 192746   Theaux Adrien                  1984 FRA    1M 50.51S
      35    35    25 561255   Cater Martin                   1992 SLO    1M 51.03S
      36    36    41 180904   Tapanainen Jaakko              2002 FIN    1M 51.41S
      37    37    40 240148   Szollos Barnabas               1998 ISR    1M 51.48S
      38    38    44 390041   Luik Juhan                     1997 EST    1M 52.74S
      39    39    39 221053   Steudle Roy-Alexander          1993 GBR    1M 52.76S
      40    40    42 690694   Kovbasnyuk Ivan                1993 UKR    1M 54.04S
      41    41    45 550109   Opmanis Lauris                 2001 LAT    1M 54.45S
         diff_time fis_points
         <Period>       <dbl>
       1 0S               0  
       2 0.48S            5.6
       3 0.89S           10.4
       4 0.93S           10.9
       5 1.01S           11.8
       6 1.08S           12.6
       7 1.09S           12.7
       8 1.13S           13.2
       9 1.13S           13.2
      10 1.15S           13.4
      11 1.16S           13.6
      12 1.23S           14.4
      13 1.23S           14.4
      14 1.28S           15.0
      15 1.53S           17.9
      16 1.58S           18.4
      17 1.61S           18.8
      18 1.75S           20.4
      19 1.8S            21.0
      20 1.83S           21.4
      21 1.87S           21.8
      22 1.88S           22.0
      23 1.89S           22.1
      24 1.9S            22.2
      25 1.92S           22.4
      26 1.98S           23.1
      27 2.07S           24.2
      28 2.2S            25.7
      29 2.4S            28.0
      30 2.45S           28.6
      31 2.57S           30.0
      32 2.69S           31.4
      33 3.45S           40.3
      34 3.46S           40.4
      35 3.98S           46.5
      36 4.36S           50.9
      37 4.43S           51.7
      38 5.69S           66.4
      39 5.71S           66.7
      40 6.99S           81.6
      41 7.4S            86.4

# query_race() works for an alpine skiing downhill training

    Code
      print(wengen_training, width = Inf, n = Inf)
    Output
      # A tibble: 58 x 9
          rank   bib fis_code name                     brand     birth_year nation
         <int> <int> <chr>    <chr>                    <chr>          <int> <chr> 
       1     1    14 6530319  Cochran-Siegle Ryan      Head            1992 USA   
       2     2    30 422310   Sejersted Adrian Smiseth Atomic          1994 NOR   
       3     3    13 990081   Casse Mattia             Rossignol       1990 ITA   
       4     4     7 53980    Kriechmayr Vincent       Head            1991 AUT   
       5     5    42 930024   Maple Wiley              Atomic          1990 USA   
       6     5    12 512471   Von Allmen Franjo        Head            2001 SUI   
       7     7    27 293006   Innerhofer Christof      Rossignol       1984 ITA   
       8     8    22 180877   Lehto Elian              Fischer         2000 FIN   
       9     9    28 561255   Cater Martin             Salomon         1992 SLO   
      10    10    53 6190459  Alphand Sam              Rossignol       1997 FRA   
      11    11    43 561397   Naralocnik Nejc          Atomic          1999 SLO   
      12    12    20 512228   Kohler Marco             Stoeckli        1997 SUI   
      13    13    49 54538    Rieser Stefan            Atomic          1999 AUT   
      14    14    26 51215    Baumann Romed            Salomon         1986 GER   
      15    15    18 54005    Striedinger Otmar        Salomon         1991 AUT   
      16    16     5 561310   Hrobat Miha              Atomic          1995 SLO   
      17    17     6 512269   Odermatt Marco           Stoeckli        1997 SUI   
      18    18    10 291459   Paris Dominik            Nordica         1989 ITA   
      19    19    31 53975    Hemetsberger Daniel      Fischer         1991 AUT   
      20    20    19 194167   Muzaton Maxence          Rossignol       1990 FRA   
      21    21    15 104537   Alexander Cameron        Rossignol       1997 CAN   
      22    22    25 192746   Theaux Adrien            Salomon         1984 FRA   
      23    23    17 512408   Monney Alexis            Stoeckli        2000 SUI   
      24    24    48 422707   Moeller Fredrik          Atomic          2000 NOR   
      25    25    44 110324   Von Appen Henrik         Head            1994 CHI   
      26    25    40 54481    Traninger Manuel         Atomic          1998 AUT   
      27    27    35 934643   Goldberg Jared           Rossignol       1991 USA   
      28    28    21 104272   Seger Brodie             Atomic          1995 CAN   
      29    29    47 350095   Pfiffner Marco           Salomon         1994 LIE   
      30    29    38 512281   Roesti Lars              Stoeckli        1998 SUI   
      31    31    52 501987   Monsen Felix             Atomic          1994 SWE   
      32    32     4 6291625  Schieder Florian         Atomic          1995 ITA   
      33    33    45 203096   Vogt Luis                Rossignol       2002 GER   
      34    34    50 6293445  Alliod Benjamin Jacques  Rossignol       2000 ITA   
      35    35    32 6531520  Morse Sam                Fischer         1996 USA   
      36    36    29 6190176  Bailet Matthieu          Head            1996 FRA   
      37    37     9 194858   Allegre Nils             Salomon         1994 FRA   
      38    38    24 6190179  Alphand Nils             Head            1996 FRA   
      39    38     2 104531   Crawford James           Head            1997 CAN   
      40    40    39 6532123  Negomir Kyle             Atomic          1998 USA   
      41    41    37 151238   Zabystran Jan            Kaestle         1998 CZE   
      42    42    51 6190556  Caillot Ken              Atomic          1998 FRA   
      43    43    23 54609    Eichberger Stefan        Head            2000 AUT   
      44    44     8 6530104  Bennett Bryce            Fischer         1992 USA   
      45    45    57 6293831  Franzoni Giovanni        Rossignol       2001 ITA   
      46    46    11 511896   Murisier Justin          Head            1992 SUI   
      47    47    46 6292783  Molteni Nicolo           Head            1998 ITA   
      48    48    16 194298   Giezendanner Blaise      Atomic          1991 FRA   
      49    49    58 54438    Ploier Andreas           Fischer         1997 AUT   
      50    50     1 54371    Babinsky Stefan          Head            1996 AUT   
      51    51    55 54080    Neumayer Christopher     Atomic          1992 AUT   
      52    52    56 6290985  Buzzi Emanuele           Fischer         1994 ITA   
      53    53    36 512303   Boisset Arnaud           Salomon         1998 SUI   
      54    54    33 512182   Meillard Loic            Rossignol       1996 SUI   
      55    55    34 104468   Read Jeffrey             Atomic          1997 CAN   
      56    56    59 6294868  Bernardi Gregorio        Rossignol       2004 ITA   
      57    57    54 54628    Feurstein Lukas          Head            2001 AUT   
      58    58    60 6532084  Radamus River            Rossignol       1998 USA   
         time      diff_time
         <Period>  <Period> 
       1 2M 25.54S 0S       
       2 2M 25.8S  0.26S    
       3 2M 26.03S 0.49S    
       4 2M 26.51S 0.97S    
       5 2M 26.78S 1.24S    
       6 2M 26.78S 1.24S    
       7 2M 26.8S  1.26S    
       8 2M 26.98S 1.44S    
       9 2M 27.06S 1.52S    
      10 2M 27.11S 1.57S    
      11 2M 27.16S 1.62S    
      12 2M 27.2S  1.66S    
      13 2M 27.22S 1.68S    
      14 2M 27.24S 1.7S     
      15 2M 27.42S 1.88S    
      16 2M 27.45S 1.91S    
      17 2M 27.47S 1.93S    
      18 2M 27.49S 1.95S    
      19 2M 27.51S 1.97S    
      20 2M 27.55S 2.01S    
      21 2M 27.74S 2.2S     
      22 2M 27.83S 2.29S    
      23 2M 27.87S 2.33S    
      24 2M 27.88S 2.34S    
      25 2M 27.89S 2.35S    
      26 2M 27.89S 2.35S    
      27 2M 27.91S 2.37S    
      28 2M 27.94S 2.4S     
      29 2M 28S    2.46S    
      30 2M 28S    2.46S    
      31 2M 28.02S 2.48S    
      32 2M 28.13S 2.59S    
      33 2M 28.15S 2.61S    
      34 2M 28.17S 2.63S    
      35 2M 28.21S 2.67S    
      36 2M 28.23S 2.69S    
      37 2M 28.34S 2.8S     
      38 2M 28.35S 2.81S    
      39 2M 28.35S 2.81S    
      40 2M 28.38S 2.84S    
      41 2M 28.46S 2.92S    
      42 2M 28.51S 2.97S    
      43 2M 28.62S 3.08S    
      44 2M 28.68S 3.14S    
      45 2M 28.75S 3.21S    
      46 2M 28.87S 3.33S    
      47 2M 28.94S 3.4S     
      48 2M 29.03S 3.49S    
      49 2M 29.28S 3.74S    
      50 2M 29.33S 3.79S    
      51 2M 29.62S 4.08S    
      52 2M 29.73S 4.19S    
      53 2M 29.74S 4.2S     
      54 2M 29.92S 4.38S    
      55 2M 30.13S 4.59S    
      56 2M 30.56S 5.02S    
      57 2M 31.09S 5.55S    
      58 2M 32.83S 7.29S    

# query_race() works for a cross-country world cup race

    Code
      print(oslo_cc, width = Inf, n = Inf)
    Output
      # A tibble: 58 x 9
          rank   bib fis_code name                     birth_year nation time        
         <int> <int> <chr>    <chr>                         <int> <chr>  <Period>    
       1     1     4 3510023  Cologna Dario                  1986 SUI    2H 1M 48.1S 
       2     2     3 3420228  Sundby Martin Johnsrud         1984 NOR    2H 1M 48.1S 
       3     3    29 3480013  Vylegzhanin Maxim              1982 RUS    2H 1M 49.2S 
       4     4    20 3420605  Roethe Sjur                    1988 NOR    2H 1M 52.3S 
       5     5    14 3482280  Spitsov Denis                  1996 RUS    2H 1M 52.5S 
       6     6     6 3420586  Holund Hans Christer           1989 NOR    2H 1M 52.6S 
       7     7    12 3220002  Musgrave Andrew                1990 GBR    2H 2M 3.2S  
       8     8    24 3200376  Notz Florian                   1992 GER    2H 2M 14S   
       9     9     5 3100110  Harvey Alex                    1988 CAN    2H 2M 20.5S 
      10    10    42 3190029  Duvillard Robin                1983 FRA    2H 2M 21.6S 
      11    11    13 3500015  Rickardsson Daniel             1982 SWE    2H 2M 31.6S 
      12    12    30 3190268  Backscheider Adrien            1992 FRA    2H 2M 33.6S 
      13    13     7 3421779  Krueger Simen Hegstad          1993 NOR    2H 2M 34.4S 
      14    14    23 3422521  Augdal Eirik Sverdrup          1995 NOR    2H 2M 41.6S 
      15    15    22 3300190  Yoshida Keishin                1987 JPN    2H 2M 44.1S 
      16    16    32 3530532  Patterson Scott                1992 USA    2H 2M 44.4S 
      17    17    41 3420672  Sveen Simen Andreas            1988 NOR    2H 2M 46.1S 
      18    18    27 3421269  Stock Daniel                   1992 NOR    2H 3M 12.9S 
      19    19    51 3290357  Bertolina Mirco                1991 ITA    2H 3M 23.8S 
      20    20    33 3200356  Dobler Jonas                   1991 GER    2H 3M 38S   
      21    21     2 3190111  Manificat Maurice              1986 FRA    2H 3M 39.9S 
      22    22    18 3480695  Bessmertnykh Alexander         1986 RUS    2H 3M 44.4S 
      23    23    53 3501167  Engdahl Petter                 1994 SWE    2H 4M 19.8S 
      24    24     9 3180535  Niskanen Iivo                  1992 FIN    2H 4M 24.2S 
      25    25     8 3482119  Chervotkin Alexey              1995 RUS    2H 5M 14.7S 
      26    26    47 3501297  Sandstroem Bjoern              1995 SWE    2H 5M 17.3S 
      27    27    44 3420614  Nygaard Per Kristian           1987 NOR    2H 5M 28.4S 
      28    28    35 3100006  Kershaw Devon                  1982 CAN    2H 5M 31.7S 
      29    29    21 3180301  Lehtonen Lari                  1987 FIN    2H 5M 43.6S 
      30    30    34 3482105  Yakimushkin Ivan               1996 RUS    2H 6M 1.8S  
      31    31    28 3421467  Rundgreen Mathias              1991 NOR    2H 6M 3.5S  
      32    32    31 3422029  Hoel Johan                     1994 NOR    2H 6M 14.5S 
      33    33    26 1362656  Livers Toni                    1983 SUI    2H 6M 42.9S 
      34    34    48 3100175  Killick Graeme                 1989 CAN    2H 6M 43.2S 
      35    35    16 3420577  Dyrhaug Niklas                 1987 NOR    2H 7M 9.7S  
      36    36    43 3300494  Baba Naoto                     1996 JPN    2H 7M 9.8S  
      37    37    17 3190302  Parisse Clement                1993 FRA    2H 7M 52.5S 
      38    38    37 3530496  Norris David                   1990 USA    2H 8M 7.8S  
      39    39    25 3190280  Tarantola Damien               1991 FRA    2H 8M 20.5S 
      40    40     1 3422819  Klaebo Johannes Hoesflot       1996 NOR    2H 8M 37.7S 
      41    41    11 3421320  Iversen Emil                   1991 NOR    2H 8M 38.4S 
      42    42    39 3180557  Hyvarinen Perttu               1991 FIN    2H 8M 50.5S 
      43    43    54 3150509  Knop Petr                      1994 CZE    2H 8M 59.1S 
      44    44    10 3420994  Toenseth Didrik                1991 NOR    2H 9M 44.4S 
      45    45    57 3050159  Tritscher Bernhard             1988 AUT    2H 9M 53.8S 
      46    46    40 3530629  Caldwell Patrick               1994 USA    2H 10M 0.4S 
      47    47    45 3100232  Shields Andy                   1991 CAN    2H 10M 1.7S 
      48    48    38 3190398  Lapierre Jules                 1996 FRA    2H 10M 25.1S
      49    49    46 3150070  Razym Ales                     1986 CZE    2H 11M 8.1S 
      50    50    55 3150570  Novak Michal                   1996 CZE    2H 12M 5.3S 
      51    51    49 3530489  Hoffman Noah                   1989 USA    2H 12M 16S  
      52    52    50 3530713  Bolger Kevin                   1993 USA    2H 14M 32.3S
      53    53    61 3320185  Kim Magnus                     1998 KOR    2H 15M 7.9S 
      54    54    56 3490145  Rojo Imanol                    1990 ESP    2H 15M 27.1S
      55    55    59 3181007  Vuorela Markus                 1996 FIN    2H 16M 1.5S 
      56    56    60 3180978  Gummerus Lauri                 1996 FIN    2H 16M 55.6S
      57    57    58 3501356  Danielsson Filip               1996 SWE    2H 21M 13.1S
      58    58    15 3420961  Krogh Finn Haagen              1990 NOR    2H 23M 7.4S 
         diff_time fis_points
         <Period>       <dbl>
       1 0S              0   
       2 0S              0   
       3 1.1S            0.21
       4 4.2S            0.8 
       5 4.4S            0.84
       6 4.5S            0.86
       7 15.1S           2.89
       8 25.9S           4.96
       9 32.4S           6.21
      10 33.5S           6.42
      11 43.5S           8.33
      12 45.5S           8.72
      13 46.3S           8.87
      14 53.5S          10.2 
      15 56S            10.7 
      16 56.3S          10.8 
      17 58S            11.1 
      18 1M 24.8S       16.2 
      19 1M 35.7S       18.3 
      20 1M 49.9S       21.0 
      21 1M 51.8S       21.4 
      22 1M 56.3S       22.3 
      23 2M 31.7S       29.1 
      24 2M 36.1S       29.9 
      25 3M 26.6S       39.6 
      26 3M 29.2S       40.1 
      27 3M 40.3S       42.2 
      28 3M 43.6S       42.8 
      29 3M 55.5S       45.1 
      30 4M 13.7S       48.6 
      31 4M 15.4S       48.9 
      32 4M 26.4S       51.0 
      33 4M 54.8S       56.5 
      34 4M 55.1S       56.5 
      35 5M 21.6S       61.6 
      36 5M 21.7S       61.6 
      37 6M 4.4S        69.8 
      38 6M 19.7S       72.7 
      39 6M 32.4S       75.2 
      40 6M 49.6S       78.5 
      41 6M 50.3S       78.6 
      42 7M 2.4S        80.9 
      43 7M 11S         82.6 
      44 7M 56.3S       91.2 
      45 8M 5.7S        93.0 
      46 8M 12.3S       94.3 
      47 8M 13.6S       94.6 
      48 8M 37S         99.0 
      49 9M 20S        107.  
      50 10M 17.2S     118.  
      51 10M 27.9S     120.  
      52 12M 44.2S     146.  
      53 13M 19.8S     153.  
      54 13M 39S       157.  
      55 14M 13.4S     163.  
      56 15M 7.5S      174.  
      57 19M 25S       223.  
      58 21M 19.3S     245.  

# query_race() works for a telemark world cup race

    Code
      print(samoens_tm, width = Inf, n = Inf)
    Output
      # A tibble: 28 x 9
          rank   bib fis_code name                  birth_year nation time     
         <int> <int> <chr>    <chr>                      <int> <chr>  <Period> 
       1     1     1 4510016  Matter Stefan               1987 SUI    2M 12.31S
       2     2     2 4510011  Michel Nicolas              1995 SUI    2M 13.9S 
       3     3     5 4510001  Dayer Bastien               1987 SUI    2M 14.95S
       4     4     3 4190048  Lopez Matti                 1996 FRA    2M 16.69S
       5     5     4 4560009  Ales Jure                   1995 SLO    2M 16.81S
       6     6     9 4190056  Claye Noe                   1999 FRA    2M 17.19S
       7     7     7 4420098  Moster Haugen Amund         1996 NOR    2M 17.26S
       8     8     8 4190055  Nabot Elie                  1997 FRA    2M 18.2S 
       9     9     6 4420078  Hole Sivert                 1995 NOR    2M 20.11S
      10    10    11 4200019  Mueller Leonhard            1991 GER    2M 21.84S
      11    11    15 4530013  Snyder Cory                 1992 USA    2M 22.48S
      12    12    24 4510017  Beney Romain                1997 SUI    2M 24.84S
      13    13    10 4200018  Orlovius Thomas             1989 GER    2M 25.8S 
      14    14    12 4190053  Sillon Theo                 1998 FRA    2M 28.36S
      15    15    16 4190060  Etievent Adrien             1998 FRA    2M 28.91S
      16    16    13 4200024  Frank Christoph             1998 GER    2M 29.01S
      17    17    18 4420125  Alveberg Jacob              2000 NOR    2M 29.7S 
      18    18    29 4190067  Page Alexis                 2003 FRA    2M 30.67S
      19    19    28 4220034  Taylor Jasper               1996 GBR    2M 35.08S
      20    20    19 4510019  Roduit Valentin             1999 SUI    2M 35.28S
      21    21    17 4510014  Procureur Gaetan            1995 SUI    2M 35.4S 
      22    22    20 4220032  Bingham Sion                1997 GBR    2M 36.64S
      23    23    22 4220037  Emsley Ben                  1996 GBR    2M 41.84S
      24    24    26 4220039  Emsley Jack                 1998 GBR    2M 42.96S
      25    25    27 4020000  Rodriguez Barrull Ian       2001 AND    2M 43.06S
      26    26    23 4220033  Dixon Colin                 1998 GBR    2M 48.12S
      27    27    25 4480000  Isaev Nikolay               1980 RUS    2M 58.89S
      28    28    30 4270000  Screawn Max                 2002 IRL    3M 23.27S
         diff_time fis_points
         <Period>       <dbl>
       1 0S              7.73
       2 1.59S          13.7 
       3 2.64S          17.7 
       4 4.38S          24.3 
       5 4.5S           24.7 
       6 4.88S          26.2 
       7 4.95S          26.4 
       8 5.89S          30.0 
       9 7.8S           37.2 
      10 9.53S          43.7 
      11 10.17S         46.2 
      12 12.53S         55.1 
      13 13.49S         58.7 
      14 16.05S         68.4 
      15 16.6S          70.5 
      16 16.7S          70.8 
      17 17.39S         73.4 
      18 18.36S         77.1 
      19 22.77S         93.8 
      20 22.97S         94.5 
      21 23.09S         95.0 
      22 24.33S         99.7 
      23 29.53S        119.  
      24 30.65S        124.  
      25 30.75S        124.  
      26 35.81S        143.  
      27 46.58S        184.  
      28 1M 10.96S     276.  

# query_race() works for a ski jumping event

    Code
      print(vancouver_jp, width = Inf, n = Inf)
    Output
      # A tibble: 49 x 8
          rank   bib fis_code name                     birth_year nation total_points
         <int> <int> <chr>    <chr>                         <int> <chr>         <dbl>
       1     1    50 2067     Ammann Simon                   1981 SUI           284. 
       2     2    45 2039     Malysz Adam                    1977 POL           269. 
       3     3    49 5040     Schlierenzauer Gregor          1990 AUT           262. 
       4     4    47 4141     Kofler Andreas                 1984 AUT           261. 
       5     5    48 4143     Morgenstern Thomas             1986 AUT           247. 
       6     6    34 2927     Neumayer Michael               1979 GER           246. 
       7     7    32 4593     Hajek Antonin                  1987 CZE           241. 
       8     8    36 2022     Kasai Noriaki                  1972 JPN           239. 
       9     9    42 2918     Kranjec Robert                 1981 SLO           234. 
      10    10    46 2088     Loitzl Wolfgang                1980 AUT           230. 
      11    11    30 5064     Hilde Tom                      1987 NOR           228. 
      12    12    43 4889     Jacobsen Anders                1985 NOR           226. 
      13    13    37 2819     Chedal Emmanuel                1983 FRA           226. 
      14    14    31 4321     Stoch Kamil                    1987 POL           224. 
      15    15    39 5749     Evensen Johan Remen            1985 NOR           224. 
      16    16    18 5658     Prevc Peter                    1992 SLO           222. 
      17    17    33 1984     Janda Jakub                    1978 CZE           221. 
      18    18    38 4580     Olli Harri                     1985 FIN           218. 
      19    19    11 4322     Hula Stefan                    1986 POL           217. 
      20    20    40 4259     Ito Daiki                      1985 JPN           217. 
      21    21    12 2987     Descombes Sevoie Vincent       1984 FRA           212. 
      22    22    22 2934     Bardal Anders                  1982 NOR           211. 
      23    23    14 4801     Koudelka Roman                 1989 CZE           208. 
      24    24    26 2062     Kuettel Andreas                1979 SUI           205. 
      25    25    41 2010     Uhrmann Michael                1978 GER           203. 
      26    26    25 1991     Hautamaeki Matti               1981 FIN           202. 
      27    27    24 4186     Colloredo Sebastian            1987 ITA           202. 
      28    28    35 4226     Wank Andreas                   1988 GER           200. 
      29    29    20 4939     Meznar Mitja                   1988 SLO           198. 
      30    30    29 1998     Schmitt Martin                 1978 GER           182. 
      31    31    44 1995     Ahonen Janne                   1977 FIN           111  
      32    32     3 5336     Frenette Peter                 1992 USA            90.6
      33    33    27 4025     Damjan Jernej                  1983 SLO            89.7
      34    34     4 4041     Lazzaroni David                1985 FRA            85.6
      35    35    16 4880     Kornilov Denis                 1986 RUS            85.2
      36    36    23 5302     Mietus Krzysztof               1991 POL            84.7
      37    37    21 4367     Takeuchi Taku                  1987 JPN            83.9
      38    38    17 2546     Karelin Pavel                  1990 RUS            80.2
      39    39     7 1905     Korolev Alexey                 1987 KAZ            79.8
      40    40     5 5219     Alexander Nicholas             1988 USA            79.2
      41    41    15 4643     Cikl Martin                    1987 CZE            78.4
      42    42     8 2024     Kim Hyun-Ki                    1983 KOR            78  
      43    43     2 1967     Zmoray Tomas                   1989 SVK            77.4
      44    44     9 4664     Rosliakov Ilja                 1983 RUS            73.9
      45    45    28 2530     Tochimoto Shohei               1989 JPN            73.4
      46    46     1 4561     Read Stefan                    1987 CAN            71.6
      47    47    10 4613     Ipatov Dimitry                 1984 RUS            63.9
      48    48    19 4724     Morassi Andrea                 1988 ITA            59.9
      49    49     6 2025     Choi Heung-Chul                1981 KOR            56.3
         diff_points
               <dbl>
       1         0  
       2       -14.2
       3       -21.4
       4       -22.4
       5       -36.9
       6       -38.1
       7       -43  
       8       -44.4
       9       -49.9
      10       -53.3
      11       -55.7
      12       -57.2
      13       -58.1
      14       -59.5
      15       -60  
      16       -61.3
      17       -62.2
      18       -65.8
      19       -66.4
      20       -66.7
      21       -72  
      22       -72.2
      23       -75.1
      24       -78.7
      25       -80.9
      26       -81.2
      27       -81.4
      28       -83.1
      29       -85.1
      30      -101. 
      31      -173. 
      32      -193  
      33      -194. 
      34      -198  
      35      -198. 
      36      -199. 
      37      -200. 
      38      -203. 
      39      -204. 
      40      -204. 
      41      -205. 
      42      -206. 
      43      -206. 
      44      -210. 
      45      -210. 
      46      -212  
      47      -220. 
      48      -224. 
      49      -227. 

