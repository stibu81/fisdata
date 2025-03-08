# query_race() works for an alpine skiing world cup race

    Code
      print(wengen_dh, width = Inf, n = Inf)
    Output
      # A tibble: 48 x 13
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
         time      diff_time fis_points cup_points sector competitor_id
         <Period>  <Period>       <dbl>      <dbl> <chr>  <chr>        
       1 2M 22.58S 0S              0           100 AL     190231       
       2 2M 22.95S 0.37S           3.24         80 AL     220878       
       3 2M 23.15S 0.57S           5            60 AL     163381       
       4 2M 23.27S 0.69S           6.05         50 AL     109079       
       5 2M 23.29S 0.71S           6.22         45 AL     189309       
       6 2M 23.41S 0.83S           7.28         40 AL     137204       
       7 2M 23.76S 1.18S          10.4          36 AL     138572       
       8 2M 23.85S 1.27S          11.1          32 AL     195440       
       9 2M 23.86S 1.28S          11.2          29 AL     188682       
      10 2M 23.95S 1.37S          12.0          26 AL     165366       
      11 2M 24.03S 1.45S          12.7          24 AL     139503       
      12 2M 24.24S 1.66S          14.6          22 AL     156299       
      13 2M 24.31S 1.73S          15.2          20 AL     118669       
      14 2M 24.68S 2.1S           18.4          18 AL     120313       
      15 2M 24.75S 2.17S          19.0          16 AL     173338       
      16 2M 24.96S 2.38S          20.9          15 AL     130869       
      17 2M 24.97S 2.39S          21.0          14 AL     126498       
      18 2M 24.99S 2.41S          21.1          13 AL     154638       
      19 2M 25.13S 2.55S          22.4          12 AL     215760       
      20 2M 25.29S 2.71S          23.8          11 AL     172438       
      21 2M 25.34S 2.76S          24.2          10 AL     176974       
      22 2M 25.36S 2.78S          24.4           9 AL     196154       
      23 2M 25.44S 2.86S          25.1           8 AL     154753       
      24 2M 25.47S 2.89S          25.3           7 AL     154956       
      25 2M 25.47S 2.89S          25.3           7 AL     61175        
      26 2M 25.48S 2.9S           25.4           5 AL     164059       
      27 2M 25.5S  2.92S          25.6           4 AL     229136       
      28 2M 25.51S 2.93S          25.7           3 AL     212090       
      29 2M 25.51S 2.93S          25.7           3 AL     126467       
      30 2M 25.53S 2.95S          25.9           1 AL     205325       
      31 2M 25.58S 3S             26.3           0 AL     189550       
      32 2M 25.76S 3.18S          27.9           0 AL     214543       
      33 2M 25.86S 3.28S          28.8           0 AL     221571       
      34 2M 26.03S 3.45S          30.2           0 AL     137323       
      35 2M 26.13S 3.55S          31.1           0 AL     26841        
      36 2M 26.15S 3.57S          31.3           0 AL     195813       
      37 2M 26.22S 3.64S          31.9           0 AL     205081       
      38 2M 26.25S 3.67S          32.2           0 AL     196711       
      39 2M 26.28S 3.7S           32.4           0 AL     156277       
      40 2M 26.44S 3.86S          33.8           0 AL     187933       
      41 2M 26.64S 4.06S          35.6           0 AL     172446       
      42 2M 26.94S 4.36S          38.2           0 AL     113774       
      43 2M 27.07S 4.49S          39.4           0 AL     190039       
      44 2M 27.15S 4.57S          40.1           0 AL     156153       
      45 2M 27.36S 4.78S          41.9           0 AL     194744       
      46 2M 27.38S 4.8S           42.1           0 AL     196047       
      47 2M 28.07S 5.49S          48.1           0 AL     195130       
      48 2M 28.08S 5.5S           48.2           0 AL     137585       

# query_race() works for an alpine skiing world cup race with 2 runs

    Code
      print(chuenis_gs, width = Inf, n = Inf)
    Output
      # A tibble: 25 x 15
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
         run1      run2      total_time diff_time fis_points cup_points sector
         <Period>  <Period>  <Period>   <Period>       <dbl>      <dbl> <chr> 
       1 1M 15.49S 1M 12.06S 2M 27.55S  0S              0           100 AL    
       2 1M 15.15S 1M 12.6S  2M 27.75S  0.2S            1.37         80 AL    
       3 1M 16.55S 1M 11.69S 2M 28.24S  0.69S           4.72         60 AL    
       4 1M 15.83S 1M 12.86S 2M 28.69S  1.14S           7.8          50 AL    
       5 1M 16.31S 1M 12.7S  2M 29.01S  1.46S           9.99         45 AL    
       6 1M 16.48S 1M 12.8S  2M 29.28S  1.73S          11.8          40 AL    
       7 1M 16.88S 1M 12.53S 2M 29.41S  1.86S          12.7          36 AL    
       8 1M 16.08S 1M 13.59S 2M 29.67S  2.12S          14.5          32 AL    
       9 1M 16.49S 1M 13.19S 2M 29.68S  2.13S          14.6          29 AL    
      10 1M 17.3S  1M 12.63S 2M 29.93S  2.38S          16.3          26 AL    
      11 1M 16.78S 1M 13.16S 2M 29.94S  2.39S          16.4          24 AL    
      12 1M 16.75S 1M 13.38S 2M 30.13S  2.58S          17.7          22 AL    
      13 1M 17.14S 1M 13.07S 2M 30.21S  2.66S          18.2          20 AL    
      14 1M 16.13S 1M 14.13S 2M 30.26S  2.71S          18.6          18 AL    
      15 1M 17.85S 1M 12.64S 2M 30.49S  2.94S          20.1          16 AL    
      16 1M 17.43S 1M 13.11S 2M 30.54S  2.99S          20.5          15 AL    
      17 1M 18.32S 1M 12.42S 2M 30.74S  3.19S          21.8          14 AL    
      18 1M 18.24S 1M 12.66S 2M 30.9S   3.35S          22.9          13 AL    
      19 1M 17.48S 1M 13.42S 2M 30.9S   3.35S          22.9          13 AL    
      20 1M 17.27S 1M 13.63S 2M 30.9S   3.35S          22.9          13 AL    
      21 1M 17.53S 1M 13.75S 2M 31.28S  3.73S          25.5          10 AL    
      22 1M 18.52S 1M 12.81S 2M 31.33S  3.78S          25.9           9 AL    
      23 1M 18.21S 1M 13.85S 2M 32.06S  4.51S          30.9           8 AL    
      24 1M 17.63S 1M 14.52S 2M 32.15S  4.6S           31.5           7 AL    
      25 1M 18.09S 1M 14.64S 2M 32.73S  5.18S          35.5           6 AL    
         competitor_id
         <chr>        
       1 190231       
       2 174158       
       3 118704       
       4 105040       
       5 146641       
       6 174450       
       7 148274       
       8 166175       
       9 169280       
      10 194503       
      11 220545       
      12 127048       
      13 159244       
      14 137306       
      15 137557       
      16 195408       
      17 219777       
      18 203188       
      19 194529       
      20 204319       
      21 176104       
      22 219780       
      23 189087       
      24 187951       
      25 210853       

# query_race() works for an alpine skiing parallel race

    Code
      print(chamonix_par, width = Inf, n = Inf)
    Output
      # A tibble: 32 x 9
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
         cup_points sector competitor_id
              <dbl> <chr>  <chr>        
       1        100 AL     174158       
       2         80 AL     105040       
       3         60 AL     156112       
       4         50 AL     105908       
       5         45 AL     137306       
       6         40 AL     159244       
       7         36 AL     137380       
       8         32 AL     163838       
       9         29 AL     191304       
      10         26 AL     154950       
      11         24 AL     118704       
      12         22 AL     146641       
      13         20 AL     127048       
      14         18 AL     118636       
      15         16 AL     137475       
      16         15 AL     125587       
      17         14 AL     213820       
      18         13 AL     128896       
      19         12 AL     160443       
      20         11 AL     81859        
      21         10 AL     139687       
      22         10 AL     165208       
      23          8 AL     135985       
      24          7 AL     169280       
      25          6 AL     108784       
      26          5 AL     136473       
      27          4 AL     154653       
      28          3 AL     146868       
      29          2 AL     174356       
      30          2 AL     137452       
      31          1 AL     174450       
      32          1 AL     175449       

# query_race() works for an alpine skiing world championships race

    Code
      print(wsc_dh, width = Inf, n = Inf)
    Output
      # A tibble: 41 x 11
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
         diff_time fis_points sector competitor_id
         <Period>       <dbl> <chr>  <chr>        
       1 0S               0   AL     190231       
       2 0.48S            5.6 AL     137380       
       3 0.89S           10.4 AL     189309       
       4 0.93S           10.9 AL     169280       
       5 1.01S           11.8 AL     188682       
       6 1.08S           12.6 AL     120313       
       7 1.09S           12.7 AL     165366       
       8 1.13S           13.2 AL     163381       
       9 1.13S           13.2 AL     109079       
      10 1.15S           13.4 AL     146460       
      11 1.16S           13.6 AL     126472       
      12 1.23S           14.4 AL     138572       
      13 1.23S           14.4 AL     166533       
      14 1.28S           15.0 AL     126467       
      15 1.53S           17.9 AL     37873        
      16 1.58S           18.4 AL     154956       
      17 1.61S           18.8 AL     173262       
      18 1.75S           20.4 AL     212375       
      19 1.8S            21.0 AL     68659        
      20 1.83S           21.4 AL     118669       
      21 1.87S           21.8 AL     154638       
      22 1.88S           22.0 AL     154753       
      23 1.89S           22.1 AL     10394        
      24 1.9S            22.2 AL     139503       
      25 1.92S           22.4 AL     215760       
      26 1.98S           23.1 AL     130869       
      27 2.07S           24.2 AL     95447        
      28 2.2S            25.7 AL     97246        
      29 2.4S            28.0 AL     104588       
      30 2.45S           28.6 AL     187933       
      31 2.57S           30.0 AL     205081       
      32 2.69S           31.4 AL     176974       
      33 3.45S           40.3 AL     156277       
      34 3.46S           40.4 AL     61175        
      35 3.98S           46.5 AL     137323       
      36 4.36S           50.9 AL     231954       
      37 4.43S           51.7 AL     195417       
      38 5.69S           66.4 AL     190115       
      39 5.71S           66.7 AL     146884       
      40 6.99S           81.6 AL     146317       
      41 7.4S            86.4 AL     221763       

# query_race() works for an alpine skiing downhill training

    Code
      print(wengen_training, width = Inf, n = Inf)
    Output
      # A tibble: 58 x 11
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
         time      diff_time sector competitor_id
         <Period>  <Period>  <chr>  <chr>        
       1 2M 25.54S 0S        AL     139503       
       2 2M 25.8S  0.26S     AL     154956       
       3 2M 26.03S 0.49S     AL     118669       
       4 2M 26.51S 0.97S     AL     126472       
       5 2M 26.78S 1.24S     AL     113774       
       6 2M 26.78S 1.24S     AL     220878       
       7 2M 26.8S  1.26S     AL     26841        
       8 2M 26.98S 1.44S     AL     215760       
       9 2M 27.06S 1.52S     AL     137323       
      10 2M 27.11S 1.57S     AL     187315       
      11 2M 27.16S 1.62S     AL     205081       
      12 2M 27.2S  1.66S     AL     189550       
      13 2M 27.22S 1.68S     AL     205325       
      14 2M 27.24S 1.7S      AL     68659        
      15 2M 27.42S 1.88S     AL     126498       
      16 2M 27.45S 1.91S     AL     163381       
      17 2M 27.47S 1.93S     AL     190231       
      18 2M 27.49S 1.95S     AL     109079       
      19 2M 27.51S 1.97S     AL     126467       
      20 2M 27.55S 2.01S     AL     120313       
      21 2M 27.74S 2.2S      AL     189309       
      22 2M 27.83S 2.29S     AL     61175        
      23 2M 27.87S 2.33S     AL     212375       
      24 2M 27.88S 2.34S     AL     213729       
      25 2M 27.89S 2.35S     AL     154753       
      26 2M 27.89S 2.35S     AL     196711       
      27 2M 27.91S 2.37S     AL     130869       
      28 2M 27.94S 2.4S      AL     164059       
      29 2M 28S    2.46S     AL     156277       
      30 2M 28S    2.46S     AL     195440       
      31 2M 28.02S 2.48S     AL     156153       
      32 2M 28.13S 2.59S     AL     165366       
      33 2M 28.15S 2.61S     AL     229136       
      34 2M 28.17S 2.63S     AL     212090       
      35 2M 28.21S 2.67S     AL     173338       
      36 2M 28.23S 2.69S     AL     172438       
      37 2M 28.34S 2.8S      AL     154638       
      38 2M 28.35S 2.81S     AL     172446       
      39 2M 28.35S 2.81S     AL     188682       
      40 2M 28.38S 2.84S     AL     195130       
      41 2M 28.46S 2.92S     AL     196154       
      42 2M 28.51S 2.97S     AL     194744       
      43 2M 28.62S 3.08S     AL     214543       
      44 2M 28.68S 3.14S     AL     137204       
      45 2M 28.75S 3.21S     AL     221571       
      46 2M 28.87S 3.33S     AL     138572       
      47 2M 28.94S 3.4S      AL     196047       
      48 2M 29.03S 3.49S     AL     126982       
      49 2M 29.28S 3.74S     AL     190039       
      50 2M 29.33S 3.79S     AL     176974       
      51 2M 29.62S 4.08S     AL     137585       
      52 2M 29.73S 4.19S     AL     155676       
      53 2M 29.74S 4.2S      AL     195813       
      54 2M 29.92S 4.38S     AL     174158       
      55 2M 30.13S 4.59S     AL     187933       
      56 2M 30.56S 5.02S     AL     255561       
      57 2M 31.09S 5.55S     AL     219777       
      58 2M 32.83S 7.29S     AL     194503       

# query_race() works for a cross-country world cup race

    Code
      print(oslo_cc, width = Inf, n = Inf)
    Output
      # A tibble: 58 x 11
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
         diff_time fis_points sector competitor_id
         <Period>       <dbl> <chr>  <chr>        
       1 0S              0    CC     10834        
       2 0S              0    CC     89621        
       3 1.1S            0.21 CC     72945        
       4 4.2S            0.8  CC     119252       
       5 4.4S            0.84 CC     183635       
       6 4.5S            0.86 CC     119233       
       7 15.1S           2.89 CC     90931        
       8 25.9S           4.96 CC     141301       
       9 32.4S           6.21 CC     107353       
      10 33.5S           6.42 CC     69253        
      11 43.5S           8.33 CC     70446        
      12 45.5S           8.72 CC     144104       
      13 46.3S           8.87 CC     158493       
      14 53.5S          10.2  CC     179004       
      15 56S            10.7  CC     79716        
      16 56.3S          10.8  CC     145942       
      17 58S            11.1  CC     121367       
      18 1M 24.8S       16.2  CC     147348       
      19 1M 35.7S       18.3  CC     152089       
      20 1M 49.9S       21.0  CC     133358       
      21 1M 51.8S       21.4  CC     101046       
      22 1M 56.3S       22.3  CC     132351       
      23 2M 31.7S       29.1  CC     168084       
      24 2M 36.1S       29.9  CC     150212       
      25 3M 26.6S       39.6  CC     177963       
      26 3M 29.2S       40.1  CC     177826       
      27 3M 40.3S       42.2  CC     120399       
      28 3M 43.6S       42.8  CC     30177        
      29 3M 55.5S       45.1  CC     111688       
      30 4M 13.7S       48.6  CC     177570       
      31 4M 15.4S       48.9  CC     147968       
      32 4M 26.4S       51.0  CC     167595       
      33 4M 54.8S       56.5  CC     35268        
      34 4M 55.1S       56.5  CC     140197       
      35 5M 21.6S       61.6  CC     119224       
      36 5M 21.7S       61.6  CC     197844       
      37 6M 4.4S        69.8  CC     159267       
      38 6M 19.7S       72.7  CC     135044       
      39 6M 32.4S       75.2  CC     150094       
      40 6M 49.6S       78.5  CC     184205       
      41 6M 50.3S       78.6  CC     147554       
      42 7M 2.4S        80.9  CC     151323       
      43 7M 11S         82.6  CC     163257       
      44 7M 56.3S       91.2  CC     141905       
      45 8M 5.7S        93.0  CC     124281       
      46 8M 12.3S       94.3  CC     167025       
      47 8M 13.6S       94.6  CC     161923       
      48 8M 37S         99.0  CC     184231       
      49 9M 20S        107.   CC     90213        
      50 10M 17.2S     118.   CC     180263       
      51 10M 27.9S     120.   CC     133325       
      52 12M 44.2S     146.   CC     180596       
      53 13M 19.8S     153.   CC     195655       
      54 13M 39S       157.   CC     117379       
      55 14M 13.4S     163.   CC     184834       
      56 15M 7.5S      174.   CC     183277       
      57 19M 25S       223.   CC     182899       
      58 21M 19.3S     245.   CC     138274       

# query_race() works for a telemark world cup race

    Code
      print(samoens_tm, width = Inf, n = Inf)
    Output
      # A tibble: 28 x 11
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
         diff_time fis_points sector competitor_id
         <Period>       <dbl> <chr>  <chr>        
       1 0S              7.73 TM     193547       
       2 1.59S          13.7  TM     170735       
       3 2.64S          17.7  TM     111987       
       4 4.38S          24.3  TM     185441       
       5 4.5S           24.7  TM     180020       
       6 4.88S          26.2  TM     207995       
       7 4.95S          26.4  TM     185747       
       8 5.89S          30.0  TM     199855       
       9 7.8S           37.2  TM     171675       
      10 9.53S          43.7  TM     206910       
      11 10.17S         46.2  TM     160172       
      12 12.53S         55.1  TM     194455       
      13 13.49S         58.7  TM     206909       
      14 16.05S         68.4  TM     197203       
      15 16.6S          70.5  TM     217014       
      16 16.7S          70.8  TM     226014       
      17 17.39S         73.4  TM     217623       
      18 18.36S         77.1  TM     247905       
      19 22.77S         93.8  TM     201335       
      20 22.97S         94.5  TM     208675       
      21 23.09S         95.0  TM     179531       
      22 24.33S         99.7  TM     195466       
      23 29.53S        119.   TM     216835       
      24 30.65S        124.   TM     226368       
      25 30.75S        124.   TM     234753       
      26 35.81S        143.   TM     195736       
      27 46.58S        184.   TM     212043       
      28 1M 10.96S     276.   TM     250718       

# query_race() works for a ski jumping event

    Code
      print(vancouver_jp, width = Inf, n = Inf)
    Output
      # A tibble: 49 x 10
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
         diff_points sector competitor_id
               <dbl> <chr>  <chr>        
       1         0   JP     973          
       2       -14.2 JP     37284        
       3       -21.4 JP     106378       
       4       -22.4 JP     68743        
       5       -36.9 JP     68745        
       6       -38.1 JP     43223        
       7       -43   JP     75148        
       8       -44.4 JP     29533        
       9       -49.9 JP     32297        
      10       -53.3 JP     35788        
      11       -55.7 JP     108891       
      12       -57.2 JP     90663        
      13       -58.1 JP     9834         
      14       -59.5 JP     73228        
      15       -60   JP     134802       
      16       -61.3 JP     131309       
      17       -62.2 JP     27594        
      18       -65.8 JP     74412        
      19       -66.4 JP     73229        
      20       -66.7 JP     73166        
      21       -72   JP     13322        
      22       -72.2 JP     2950         
      23       -75.1 JP     104161       
      24       -78.7 JP     32824        
      25       -80.9 JP     62975        
      26       -81.2 JP     23834        
      27       -81.4 JP     71839        
      28       -83.1 JP     72592        
      29       -85.1 JP     92162        
      30      -101.  JP     54682        
      31      -173.  JP     445          
      32      -193   JP     120495       
      33      -194.  JP     12274        
      34      -198   JP     34374        
      35      -198.  JP     90236        
      36      -199.  JP     118117       
      37      -200.  JP     73277        
      38      -203.  JP     101217       
      39      -204.  JP     94124        
      40      -204.  JP     115912       
      41      -205.  JP     75708        
      42      -206.  JP     30417        
      43      -206.  JP     97610        
      44      -210.  JP     78558        
      45      -210.  JP     100406       
      46      -212   JP     73920        
      47      -220.  JP     75190        
      48      -224.  JP     81305        
      49      -227.  JP     10064        

# query_race() works for a snowbard halfpipe event

    Code
      print(laax_sb, width = Inf, n = Inf)
    Output
      # A tibble: 45 x 11
          rank   bib fis_code name                   birth_year nation score
         <int> <int> <chr>    <chr>                       <int> <chr>  <dbl>
       1     1     2 9040117  James Scotty                 1994 AUS    95.75
       2     2     4 9300799  Hirano Ruka                  2002 JPN    93.75
       3     3     3 9300658  Hirano Ayumu                 1998 JPN    87   
       4     4     1 9300752  Totsuka Yuto                 2001 JPN    85.25
       5     5     5 9300976  Shigeno Shuichiro            2005 JPN    81.25
       6     6    10 9410071  Melville Ives Campbell       2006 NZL    78.75
       7     7     9 9530715  Josey Chase                  1995 USA    70   
       8     8    11 9510239  Burgener Patrick             1994 SUI    60.75
       9     9     7 9301010  Yamada Ryusei                2006 JPN    37.25
      10    10     8 9531741  Barbieri Alessandro          2008 USA    33.75
      11    11    16 1124985  Wang Ziyang                  2003 CHN    16.25
      12    12     6 9320213  Lee Chaeun                   2006 KOR     7.75
      13    13    18 9301117  Murakami Konosuke            2009 JPN    82.5 
      14    14    19 9510510  Hasler Jonas                 2006 SUI    80.75
      15    15    22 9320241  Kim Geonhui                  2008 KOR    78.25
      16    16    23 9530811  Wachendorfer Ryan            1996 USA    76   
      17    17    45 9510223  Podladtchikov Iouri          1988 SUI    75.25
      18    18    27 9531115  Bowman Joshua                1998 USA    74.25
      19    19    28 9200190  Lechner Florian              2005 AUT    70.25
      20    20    12 9320235  Lee Jio                      2008 KOR    69.75
      21    21    15 7535030  Vito Iii Louis Philip        1988 ITA    69.25
      22    22    29 9510455  Biele Gian Andrin            2003 SUI    62.25
      23    23    13 9531295  Wolle Jason                  1999 USA    61.25
      24    24    30 9510542  Zuercher Mischa              2008 SUI    60   
      25    25    26 9200133  Lechner Christoph            2000 GER    57.5 
      26    26    40 1084977  Teixeira Augustinho          2005 BRA    53.5 
      27    27    43 9120149  Zhang Xinhao                 2007 CHN    53.25
      28    28    31 9531572  Ullah Siddhartha             2006 GBR    52.5 
      29    29    34 9320198  Kim Kangsan                  2004 KOR    50.5 
      30    30    39 9510559  Saraiva Leonardo             2009 SUI    46.75
      31    31    42 9100953  Pershad Kiran                2000 CAN    44.5 
      32    32    41 9290295  Gennero Lorenzo              1997 ITA    44   
      33    33    37 1124970  Fan Xiaobing                 2001 CHN    42.75
      34    34    32 9531837  Wild Aaron                   2009 GBR    42.25
      35    35    33 9101134  Vo Ryan                      2004 CAN    40   
      36    36    21 9101051  Gill Liam                    2003 CAN    37.75
      37    37    35 9560193  Stante Tit                   1998 SLO    35.75
      38    38    36 9531746  Cowan Taitten                2008 CHI    33.5 
      39    39    44 1124957  Gu Ao                        1999 CHN    30.75
      40    40    24 9531230  Foster Lucas                 1999 USA    26.75
      41    41    38 9120150  Ren Chongshuo                2008 CHN    26.25
      42    42    17 9531125  Blackwell Chase              1999 USA    25.25
      43    43    20 9531687  Avallone Noah                2007 USA    20   
      44    44    14 9531364  Okesson Joey                 2002 USA    17.25
      45    45    25 9300940  Kikuchihara Koyata           2004 JPN    14.5 
         fis_points cup_points sector competitor_id
              <dbl>      <dbl> <chr>  <chr>        
       1     1000          100 SB     142558       
       2      828.5         80 SB     205185       
       3      693.6         60 SB     174771       
       4      587.3         50 SB     197627       
       5      503.3         45 SB     231780       
       6      436.5         40 SB     240357       
       7      383.3         36 SB     152118       
       8      340.6         32 SB     142877       
       9      306.1         29 SB     240872       
      10      278           26 SB     265354       
      11      254.8         24 SB     223026       
      12      235.5         22 SB     239112       
      13      219.3         20 SB     270413       
      14      205.3         18 SB     246604       
      15      193.2         16 SB     261977       
      16      182.5         15 SB     160166       
      17      173           14 SB     138689       
      18      164.2         13 SB     185968       
      19      156.2         12 SB     234395       
      20      148.7         11 SB     261333       
      21      141.6         10 SB     77042        
      22      134.8          9 SB     222669       
      23      128.2          8 SB     205992       
      24      121.9          7 SB     265405       
      25      115.7          6 SB     198482       
      26      109.6          5 SB     229815       
      27      103.6          4 SB     278558       
      28       97.7          3 SB     240632       
      29       91.8          2 SB     220952       
      30       86            1 SB     273118       
      31       80.2          0 SB     205781       
      32       74.4          0 SB     185759       
      33       68.6          0 SB     213352       
      34       62.9          0 SB     270975       
      35       57.2          0 SB     226307       
      36       51.5          0 SB     217064       
      37       45.8          0 SB     177403       
      38       40.1          0 SB     265979       
      39       34.4          0 SB     201888       
      40       28.7          0 SB     198884       
      41       23            0 SB     278559       
      42       17.3          0 SB     186702       
      43       11.6          0 SB     258085       
      44        6            0 SB     215936       
      45        0.3          0 SB     225866       

# query_race() works for a freestyle ski cross event

    Code
      print(craigleith_sc, width = Inf, n = Inf)
    Output
      # A tibble: 20 x 11
          rank   bib fis_code name                     birth_year nation qual_time
         <int> <int> <chr>    <chr>                         <int> <chr>  <Period> 
       1     1     1 2526373  Smith Fanny                    1992 SUI    49.9S    
       2     2     4 2532937  Hoffos Courtney                1997 CAN    50.28S   
       3     3     7 2527689  Thompson Marielle              1992 CAN    50.47S   
       4     4     3 2534674  Schmidt Hannah                 1994 CAN    50.24S   
       5     5     5 2526015  Ofner Katrin                   1990 AUT    50.29S   
       6     6     6 2537303  Grillet Aubert Jade            1997 FRA    50.39S   
       7     7    10 2529562  Sherret India                  1996 CAN    50.55S   
       8     8    16 2533149  Gantenbein Talina              1998 SUI    51.03S   
       9     9     8 2532843  Tansley Antoinette             1997 CAN    50.5S    
      10    10    11 2531978  Phelan Brittany                1991 CAN    50.61S   
      11    11    12 2537873  Galli Jole                     1995 ITA    50.89S   
      12    12    15 2531251  Mcewen Abby                    1996 CAN    50.96S   
      13    13     9 2532679  Gairns Tiana                   1998 CAN    50.53S   
      14    14    13 2538024  Holzmann Johanna               1995 GER    50.93S   
      15    15    14 2534134  Cousin Sixtine                 1999 SUI    50.95S   
      16    16     2 2529528  Berger Sabbatel Marielle       1990 FRA    50.21S   
      17    17    36 2534895  Foedermayr Christina           2001 AUT    51.15S   
      18    18    33 2533798  Lack Saskja                    2000 SUI    51.24S   
      19    19    35 2527841  Kucerova Nikol                 1989 CZE    51.42S   
      20    20    37 2532106  Chore Zoe                      1998 CAN    51.68S   
         fis_points cup_points sector competitor_id
              <dbl>      <dbl> <chr>  <chr>        
       1       1000        100 FS     134641       
       2        800         80 FS     204930       
       3        600         60 FS     153591       
       4        500         50 FS     227453       
       5        450         45 FS     125036       
       6        400         40 FS     249756       
       7        360         36 FS     173659       
       8        320         32 FS     207899       
       9        290         29 FS     204157       
      10        260         26 FS     194473       
      11        240         24 FS     257459       
      12        220         22 FS     186618       
      13        200         20 FS     202003       
      14        180         18 FS     259740       
      15        160         16 FS     219423       
      16        150         15 FS     173145       
      17        140         14 FS     229923       
      18        130         13 FS     215305       
      19        120         12 FS     154373       
      20        110         11 FS     196351       

# query_race() works for a nordic combined world cup race

    Code
      print(lillehammer_nk, width = Inf, n = Inf)
    Output
      # A tibble: 32 x 13
          rank   bib fis_code name                 birth_year nation distance points
         <int> <int> <chr>    <chr>                     <int> <chr>     <dbl>  <dbl>
       1     1     3 100733   Hagen Ida Marie            2000 NOR        96    119.6
       2     2     9 187104   Armbruster Nathalie        2006 GER        87.5  103.9
       3     3    13 100845   Westvold Hansen Gyda       2002 NOR        85.5   98.1
       4     4    14 101146   Volavsek Ema               2002 SLO        84.5   96  
       5     5    10 101144   Hirner Lisa                2003 AUT        86.5  103.6
       6     6    12 101203   Kasai Haruka               2004 JPN        85     99.2
       7     7    17 100988   Leinan Lund Marte          2001 NOR        83     91.4
       8     8     4 101204   Kasai Yuna                 2004 JPN        94.5  116.6
       9     9     6 100696   Nowak Jenny                2002 GER        91    109.9
      10    10    18 187263   Korhonen Minja             2007 FIN        80     87.7
      11    11    22 101376   Brabec Alexa               2004 USA        78     84.2
      12    12     1 100655   Gerboth Maria              2002 GER        96.5  125.8
      13    13    21 101072   Brocard Lena               2000 FRA        80     84.6
      14    14    34 100731   Midtsundstad Hanna         1999 NOR        58     34.7
      15    15     8 187079   Purker Claudia             1999 AUT        89    104  
      16    16    19 100941   Azegami Sana               2001 JPN        80.5   86.2
      17    17    29 101198   Gianmoena Veronica         1995 ITA        75     72.9
      18    18    16 187282   Malovrh Tia                2008 SLO        83.5   92.5
      19    19    28 101437   Kil Joanna                 2000 POL        75     74.2
      20    20     5 101515   Loh Ronja                  2005 GER        88.5  110.9
      21    21    24 101377   Malacinski Annika          2001 USA        76     78.2
      22    22    11 187403   Hirvonen Heta              2008 FIN        87    102.3
      23    23    33 101301   Pletz Laura                2005 AUT        67.5   54.9
      24    24    20 101109   Haasch Cindy               2004 GER        80     85.7
      25    25    32 101180   Hagen Mille Marie          2002 NOR        71     58  
      26    26     7 187084   Wuerth Svenja              1993 GER        89.5  107.7
      27    27    25 101211   Pinzani Greta              2005 ITA        77.5   78.1
      28    28    23 187141   Pavec Teja                 2007 SLO        79     80.8
      29    29    15 100995   Slamik Annalena            2003 AUT        84.5   92.6
      30    30    31 100683   Dejori Daniela             2002 ITA        68.5   65  
      31    31    30 187400   Evans Nora Helene          2008 NOR        74.5   67.4
      32    32    27 187081   Senoner Anna               2007 ITA        75.5   74.7
         jump_rank time      diff_time sector competitor_id
             <int> <Period>  <Period>  <chr>  <chr>        
       1         3 13M 43.4S 0S        NK     196877       
       2         9 14M 34.5S 51.1S     NK     251741       
       3        13 14M 39.1S 55.7S     NK     201876       
       4        14 14M 39.2S 55.8S     NK     217159       
       5        10 14M 56.3S 1M 12.9S  NK     217157       
       6        12 14M 59S   1M 15.6S  NK     220268       
       7        17 15M 8.1S  1M 24.7S  NK     209673       
       8         4 15M 13.3S 1M 29.9S  NK     220269       
       9         6 15M 21.7S 1M 38.3S  NK     196537       
      10        18 15M 27.9S 1M 44.5S  NK     262733       
      11        22 15M 34.6S 1M 51.2S  NK     230378       
      12         1 15M 35.4S 1M 52S    NK     196092       
      13        21 15M 37.3S 1M 53.9S  NK     212341       
      14        34 15M 37.8S 1M 54.4S  NK     196875       
      15         8 15M 44.3S 2M 0.9S   NK     251524       
      16        19 15M 45.9S 2M 2.5S   NK     205314       
      17        29 15M 47.8S 2M 4.4S   NK     220118       
      18        16 15M 51.3S 2M 7.9S   NK     263977       
      19        28 15M 52.6S 2M 9.2S   NK     235847       
      20         5 15M 55S   2M 11.6S  NK     240218       
      21        24 16M 3.4S  2M 20S    NK     230380       
      22        11 16M 13.2S 2M 29.8S  NK     271467       
      23        33 16M 13.9S 2M 30.5S  NK     227624       
      24        20 16M 14.7S 2M 31.3S  NK     212974       
      25        32 16M 25.1S 2M 41.7S  NK     219215       
      26         7 16M 27.2S 2M 43.8S  NK     251619       
      27        25 16M 33.7S 2M 50.3S  NK     220986       
      28        23 16M 37.4S 2M 54S    NK     254682       
      29        15 17M 1.8S  3M 18.4S  NK     209722       
      30        31 17M 2S    3M 18.6S  NK     196396       
      31        30 17M 31.3S 3M 47.9S  NK     271453       
      32        27 17M 56.3S 4M 12.9S  NK     251563       

# query_race() works for a speed skiing world cup race

    Code
      print(grandvalira_ss, width = Inf, n = Inf)
    Output
      # A tibble: 49 x 12
          rank   bib fis_code name                 birth_year nation n_runs  speed
         <int> <int> <chr>    <chr>                     <int> <chr>   <int>  <dbl>
       1     1     4 510089   May Philippe               1970 SUI         1 199.56
       2     2     6 190130   Montes Bastien             1985 FRA         1 198.71
       3     3    15 7039     Origone Simone             1979 ITA         1 198.44
       4     4    13 7178     Schrottshammer Klaus       1979 AUT         1 198.12
       5     5    14 7463     Kramer Manuel              1989 AUT         1 196.49
       6     6     5 7078     Origone Ivan               1987 ITA         1 195.52
       7     7    11 7049     Adarraga Ricardo           1965 ESP         1 195.32
       8     8     3 7194     Eigenmann Reto             1970 SUI         1 194.35
       9     9     8 7391     Giacomelli Emilio          1984 ITA         1 193.98
      10    10     7 7491     Bekes Michal               1989 SVK         1 193.56
      11    11     1 7043     Montes Jimmy               1987 FRA         1 193.39
      12    12    18 7250     Vandendries Joost          1971 BEL         1 193.08
      13    13     2 7295     Farrell Jan                1983 GBR         1 192.7 
      14    14    12 7278     Backlund Erik              1993 SWE         1 192.56
      15    15     9 7461     Raab Daniel                1997 AUT         1 192.34
      16    16    27 290009   Renaldo Antonio            1961 ITA         1 191.9 
      17    17    16 7436     Ribbegardh Carl            1974 SWE         1 191.45
      18    18    10 7424     Sanchez Juan Carlos        1993 ESP         1 190.43
      19    19    21 7243     Mabit Emmeric              1993 FRA         1 187.88
      20    20    25 7110     Sage Mathieu               1973 FRA         1 186.78
      21    21    23 7065     Prihoda Michal             1968 CZE         1 185.05
      22    22    24 7483     Yatsunami Tomoyuki         1977 JPN         1 184.52
      23    23    17 7350     Manrique Eduard            1985 ESP         1 182.72
      24    24    20 7440     Karjalainen Rauli          1946 USA         1 181.64
      25    25    42 7210     Meichtry Gregory           1977 SUI         1 181.46
      26    26    19 7206     Jechoux Tommy              1993 FRA         1 181.23
      27    27    26 7400     Donat Nicolas              1966 FRA         1 178.41
      28    28    39 7328     Amann Marc                 1994 GER         1 178.1 
      29    29    48 7327     Schoell Daniel             1982 GER         1 177.97
      30    30    47 7460     Henzler Oliver             1983 GER         1 177.61
      31    31    38 7088     Beskow Lars                1969 SWE         1 177.55
      32    32    41 7406     Urban Petr                 1979 CZE         1 177.34
      33    33    43 510085   Goumoens Michel            1968 SUI         1 177.33
      34    34    65 7441     Portal Ugo                 1998 FRA         1 177.06
      35    35    49 7481     Mika Jeffrey               1963 USA         1 176.83
      36    36    22 7422     Riviera Maxime             1978 SUI         1 176.65
      37    37    52 7522     Thiercelin Lionel          1966 FRA         1 176.58
      38    38    67 7512     Thiercelin Killian         2000 FRA         1 175.92
      39    39    40 7466     Foldyna Edvard             1989 CZE         1 175.81
      40    40    66 7524     Echantillon Yoan           1999 FRA         1 175.52
      41    41    54 7500     Bernardet Benjamin         1982 FRA         1 175.25
      42    42    50 7294     Portal Robin               1995 FRA         1 174.08
      43    43    62 7502     Brunnberg Jonantan         2000 SWE         1 173.22
      44    44    45 7416     Toche Sebastien            1995 FRA         1 173.01
      45    45    63 7490     Garcia Alvaro              1999 ESP         1 172.67
      46    46    61 7485     Martinez Tom               1999 FRA         1 172.07
      47    47    51 7517     Tanazawa Hiroyoshi         1957 JPN         1 168.04
      48    48    64 7478     Jechoux Axel               1999 FRA         1 166.41
      49    49    44 7417     Jaques Robert              1962 SUI         1 164.29
         diff_speed fis_points sector competitor_id
              <dbl>      <dbl> <chr>  <chr>        
       1       0          0    SS     76260        
       2      -0.85       6.42 SS     73851        
       3      -1.12       8.47 SS     96769        
       4      -1.44      10.9  SS     143622       
       5      -3.07      23.44 SS     201670       
       6      -4.04      30.99 SS     112972       
       7      -4.24      32.56 SS     102494       
       8      -5.21      40.21 SS     144563       
       9      -5.58      43.15 SS     186406       
      10      -6         46.5  SS     210403       
      11      -6.17      47.86 SS     101533       
      12      -6.48      50.34 SS     161487       
      13      -6.86      53.4  SS     171549       
      14      -7         54.53 SS     163114       
      15      -7.22      56.31 SS     201668       
      16      -7.66      59.87 SS     76105        
      17      -8.11      63.54 SS     194095       
      18      -9.13      71.92 SS     193928       
      19     -11.68      93.25 SS     154457       
      20     -12.78     102.63 SS     125222       
      21     -14.51     117.62 SS     111914       
      22     -15.04     122.26 SS     209401       
      23     -16.84     138.24 SS     180746       
      24     -17.92     147.99 SS     195293       
      25     -18.1      100    SS     152586       
      26     -18.33     151.71 SS     152582       
      27     -21.15     177.82 SS     186542       
      28     -21.46     128.3  SS     174524       
      29     -21.59     129.42 SS     174523       
      30     -21.95     132.52 SS     201633       
      31     -22.01     133.03 SS     119424       
      32     -22.22     134.85 SS     186834       
      33     -22.23     134.93 SS     76256        
      34     -22.5      180    SS     195314       
      35     -22.73     139.28 SS     207855       
      36     -22.91     194.54 SS     193789       
      37     -22.98     141.45 SS     219332       
      38     -23.64     189.72 SS     218117       
      39     -23.75     148.21 SS     201812       
      40     -24.04     193.16 SS     219425       
      41     -24.31     153.15 SS     213426       
      42     -25.48     163.59 SS     171462       
      43     -26.34     213.25 SS     216082       
      44     -26.55     173.26 SS     193372       
      45     -26.89     218.14 SS     210223       
      46     -27.49     223.5  SS     209609       
      47     -31.52     219.79 SS     219159       
      48     -33.15     276    SS     203463       
      49     -35.27     256.77 SS     193407       

# query_race() works when only start list is published

    Code
      print(start_list, width = Inf, n = Inf)
    Output
      # A tibble: 72 x 9
         order   bib fis_code name                     brand     birth_year nation
         <int> <int> <chr>    <chr>                    <chr>          <int> <chr> 
       1     1     1 54371    Babinsky Stefan          Head            1996 AUT   
       2     2     2 422310   Sejersted Adrian Smiseth Atomic          1994 NOR   
       3     3     3 512038   Rogentin Stefan          Fischer         1994 SUI   
       4     4     4 53975    Hemetsberger Daniel      Fischer         1991 AUT   
       5     5     5 54609    Eichberger Stefan        Head            2000 AUT   
       6     6     6 561310   Hrobat Miha              Atomic          1995 SLO   
       7     7     7 194858   Allegre Nils             Salomon         1994 FRA   
       8     8     8 291459   Paris Dominik            Nordica         1989 ITA   
       9     9     9 6530104  Bennett Bryce            Fischer         1992 USA   
      10    10    10 511896   Murisier Justin          Head            1992 SUI   
      11    11    11 512269   Odermatt Marco           Stoeckli        1997 SUI   
      12    12    12 104531   Crawford James           Head            1997 CAN   
      13    13    13 512408   Monney Alexis            Stoeckli        2000 SUI   
      14    14    14 512471   Von Allmen Franjo        Head            2001 SUI   
      15    15    15 53980    Kriechmayr Vincent       Head            1991 AUT   
      16    16    16 990081   Casse Mattia             Rossignol       1990 ITA   
      17    17    17 6530319  Cochran-Siegle Ryan      Head            1992 USA   
      18    18    18 180877   Lehto Elian              Fischer         2000 FIN   
      19    19    19 194167   Muzaton Maxence          Rossignol       1990 FRA   
      20    20    20 6291625  Schieder Florian         Atomic          1995 ITA   
      21    21    21 54005    Striedinger Otmar        Salomon         1991 AUT   
      22    22    22 934643   Goldberg Jared           Rossignol       1991 USA   
      23    23    23 104272   Seger Brodie             Atomic          1995 CAN   
      24    24    24 51215    Baumann Romed            Salomon         1986 GER   
      25    25    25 192746   Theaux Adrien            Salomon         1984 FRA   
      26    26    26 6190176  Bailet Matthieu          Head            1996 FRA   
      27    27    27 293006   Innerhofer Christof      Rossignol       1984 ITA   
      28    28    28 512281   Roesti Lars              Stoeckli        1998 SUI   
      29    29    29 512228   Kohler Marco             Stoeckli        1997 SUI   
      30    30    30 561255   Cater Martin             Salomon         1992 SLO   
      31    31    31 54445    Haaser Raphael           Fischer         1997 AUT   
      32    32    32 104468   Read Jeffrey             Atomic          1997 CAN   
      33    33    33 6531520  Morse Sam                Fischer         1996 USA   
      34    34    34 512549   Hiltbrand Livio          FISCHER         2003 SUI   
      35    35    35 501987   Monsen Felix             Atomic          1994 SWE   
      36    36    36 151238   Zabystran Jan            Kaestle         1998 CZE   
      37    37    37 6532123  Negomir Kyle             Atomic          1998 USA   
      38    38    38 54481    Traninger Manuel         Atomic          1998 AUT   
      39    39    39 6292783  Molteni Nicolo           Head            1998 ITA   
      40    40    40 930024   Maple Wiley              Atomic          1990 USA   
      41    41    41 561397   Naralocnik Nejc          Atomic          1999 SLO   
      42    42    42 54733    Wieser Vincent           Salomon         2002 AUT   
      43    43    43 422707   Moeller Fredrik          Atomic          2000 NOR   
      44    44    44 512527   Miggiano Alessio         Head            2002 SUI   
      45    45    45 6293831  Franzoni Giovanni        Rossignol       2001 ITA   
      46    46    46 110324   Von Appen Henrik         Head            1994 CHI   
      47    47    47 203096   Vogt Luis                Rossignol       2002 GER   
      48    48    48 54538    Rieser Stefan            Atomic          1999 AUT   
      49    49    49 54438    Ploier Andreas           Fischer         1997 AUT   
      50    50    50 6293445  Alliod Benjamin Jacques  Rossignol       2000 ITA   
      51    51    51 350095   Pfiffner Marco           Salomon         1994 LIE   
      52    52    52 512362   Torrent Christophe       Rossignol       1999 SUI   
      53    53    53 512410   Zulauf Gael              Fischer         2000 SUI   
      54    54    54 54812    Haas Matteo              Salomon         2004 AUT   
      55    55    55 6190556  Caillot Ken              Atomic          1998 FRA   
      56    56    56 6294638  Perathoner Max           Salomon         2003 ITA   
      57    57    57 6190459  Alphand Sam              Rossignol       1997 FRA   
      58    58    58 54628    Feurstein Lukas          Head            2001 AUT   
      59    59    59 6191134  Gamel Seigneur Charles   Rossignol       2002 FRA   
      60    60    60 561435   Aznoh Rok                Atomic          2002 SLO   
      61    61    61 6532793  Smith Jack               Rossignol       2001 USA   
      62    62    62 6293164  Franzoso Matteo          Atomic          1999 ITA   
      63    63    63 6191056  Ducros Leo               Atomic          2001 FRA   
      64    64    64 422851   Sellaeg Simen            Head            2003 NOR   
      65    65    65 54774    Endstrasser Felix        Fischer         2003 AUT   
      66    66    66 6100011  Lessard Raphael          Head            2001 CAN   
      67    67    67 422793   Buer Jonas               -               2001 NOR   
      68    68    68 54732    Tritscher Luis           Head            2002 AUT   
      69    69    69 30488    Gravier Tiziano          Head            2002 ARG   
      70    70    70 6532084  Radamus River            Rossignol       1998 USA   
      71    71    71 6190687  Loriot Florian           Rossignol       1998 FRA   
      72    72    72 422278   Windingstad Rasmus       Atomic          1993 NOR   
         sector competitor_id
         <chr>  <chr>        
       1 AL     176974       
       2 AL     154956       
       3 AL     156299       
       4 AL     126467       
       5 AL     214543       
       6 AL     163381       
       7 AL     154638       
       8 AL     109079       
       9 AL     137204       
      10 AL     138572       
      11 AL     190231       
      12 AL     188682       
      13 AL     212375       
      14 AL     220878       
      15 AL     126472       
      16 AL     118669       
      17 AL     139503       
      18 AL     215760       
      19 AL     120313       
      20 AL     165366       
      21 AL     126498       
      22 AL     130869       
      23 AL     164059       
      24 AL     68659        
      25 AL     61175        
      26 AL     172438       
      27 AL     26841        
      28 AL     195440       
      29 AL     189550       
      30 AL     137323       
      31 AL     191305       
      32 AL     187933       
      33 AL     173338       
      34 AL     238436       
      35 AL     156153       
      36 AL     196154       
      37 AL     195130       
      38 AL     196711       
      39 AL     196047       
      40 AL     113774       
      41 AL     205081       
      42 AL     231190       
      43 AL     213729       
      44 AL     230179       
      45 AL     221571       
      46 AL     154753       
      47 AL     229136       
      48 AL     205325       
      49 AL     190039       
      50 AL     212090       
      51 AL     156277       
      52 AL     203820       
      53 AL     212377       
      54 AL     253307       
      55 AL     194744       
      56 AL     245120       
      57 AL     187315       
      58 AL     219777       
      59 AL     228583       
      60 AL     230052       
      61 AL     219841       
      62 AL     204211       
      63 AL     220900       
      64 AL     245551       
      65 AL     239796       
      66 AL     220696       
      67 AL     222820       
      68 AL     231189       
      69 AL     228976       
      70 AL     194503       
      71 AL     200704       
      72 AL     146868       

