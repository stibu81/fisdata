# query_race() works for an alpline skiing world cup race

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

---

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
         time      diff_time fis_points cup_points
         <Period>  <Period>       <dbl>      <dbl>
       1 2M 25.54S 0S                NA         NA
       2 2M 25.8S  0.26S             NA         NA
       3 2M 26.03S 0.49S             NA         NA
       4 2M 26.51S 0.97S             NA         NA
       5 2M 26.78S 1.24S             NA         NA
       6 2M 26.78S 1.24S             NA         NA
       7 2M 26.8S  1.26S             NA         NA
       8 2M 26.98S 1.44S             NA         NA
       9 2M 27.06S 1.52S             NA         NA
      10 2M 27.11S 1.57S             NA         NA
      11 2M 27.16S 1.62S             NA         NA
      12 2M 27.2S  1.66S             NA         NA
      13 2M 27.22S 1.68S             NA         NA
      14 2M 27.24S 1.7S              NA         NA
      15 2M 27.42S 1.88S             NA         NA
      16 2M 27.45S 1.91S             NA         NA
      17 2M 27.47S 1.93S             NA         NA
      18 2M 27.49S 1.95S             NA         NA
      19 2M 27.51S 1.97S             NA         NA
      20 2M 27.55S 2.01S             NA         NA
      21 2M 27.74S 2.2S              NA         NA
      22 2M 27.83S 2.29S             NA         NA
      23 2M 27.87S 2.33S             NA         NA
      24 2M 27.88S 2.34S             NA         NA
      25 2M 27.89S 2.35S             NA         NA
      26 2M 27.89S 2.35S             NA         NA
      27 2M 27.91S 2.37S             NA         NA
      28 2M 27.94S 2.4S              NA         NA
      29 2M 28S    2.46S             NA         NA
      30 2M 28S    2.46S             NA         NA
      31 2M 28.02S 2.48S             NA         NA
      32 2M 28.13S 2.59S             NA         NA
      33 2M 28.15S 2.61S             NA         NA
      34 2M 28.17S 2.63S             NA         NA
      35 2M 28.21S 2.67S             NA         NA
      36 2M 28.23S 2.69S             NA         NA
      37 2M 28.34S 2.8S              NA         NA
      38 2M 28.35S 2.81S             NA         NA
      39 2M 28.35S 2.81S             NA         NA
      40 2M 28.38S 2.84S             NA         NA
      41 2M 28.46S 2.92S             NA         NA
      42 2M 28.51S 2.97S             NA         NA
      43 2M 28.62S 3.08S             NA         NA
      44 2M 28.68S 3.14S             NA         NA
      45 2M 28.75S 3.21S             NA         NA
      46 2M 28.87S 3.33S             NA         NA
      47 2M 28.94S 3.4S              NA         NA
      48 2M 29.03S 3.49S             NA         NA
      49 2M 29.28S 3.74S             NA         NA
      50 2M 29.33S 3.79S             NA         NA
      51 2M 29.62S 4.08S             NA         NA
      52 2M 29.73S 4.19S             NA         NA
      53 2M 29.74S 4.2S              NA         NA
      54 2M 29.92S 4.38S             NA         NA
      55 2M 30.13S 4.59S             NA         NA
      56 2M 30.56S 5.02S             NA         NA
      57 2M 31.09S 5.55S             NA         NA
      58 2M 32.83S 7.29S             NA         NA

# query_race() works for an alpline skiing world championships race

    Code
      print(wsc_dh, width = Inf, n = Inf)
    Output
      # A tibble: 41 x 11
          rank   bib fis_code name                     brand birth_year nation
         <int> <int> <chr>    <chr>                    <chr>      <int> <chr> 
       1     1    10 512269   Odermatt Marco           <NA>        1997 SUI   
       2     2    15 422139   Kilde Aleksander Aamodt  <NA>        1992 NOR   
       3     3    20 104537   Alexander Cameron        <NA>        1997 CAN   
       4     4    21 54320    Schwarz Marco            <NA>        1995 AUT   
       5     5    12 104531   Crawford James           <NA>        1997 CAN   
       6     6    24 194167   Muzaton Maxence          <NA>        1990 FRA   
       7     7     1 6291625  Schieder Florian         <NA>        1995 ITA   
       8     8    28 561310   Hrobat Miha              <NA>        1995 SLO   
       9     8    14 291459   Paris Dominik            <NA>        1989 ITA   
      10    10    16 202535   Dressen Thomas           <NA>        1993 GER   
      11    11     6 53980    Kriechmayr Vincent       <NA>        1991 AUT   
      12    12    23 511896   Murisier Justin          <NA>        1992 SUI   
      13    12     9 512124   Hintermann Niels         <NA>        1995 SUI   
      14    14     7 53975    Hemetsberger Daniel      <NA>        1991 AUT   
      15    15    19 293550   Marsaglia Matteo         <NA>        1985 ITA   
      16    16     3 422310   Sejersted Adrian Smiseth <NA>        1994 NOR   
      17    17    31 6531444  Arvidsson Erik           <NA>        1996 USA   
      18    18    29 512408   Monney Alexis            <NA>        2000 SUI   
      19    19     4 51215    Baumann Romed            <NA>        1986 GER   
      20    20    11 990081   Casse Mattia             <NA>        1990 ITA   
      21    21    30 194858   Allegre Nils             <NA>        1994 FRA   
      22    22    34 110324   Von Appen Henrik         <NA>        1994 CHI   
      23    23     8 191740   Clarey Johan             <NA>        1981 FRA   
      24    24     2 6530319  Cochran-Siegle Ryan      <NA>        1992 USA   
      25    25    33 180877   Lehto Elian              <NA>        2000 FIN   
      26    26    18 934643   Goldberg Jared           <NA>        1991 USA   
      27    27    17 202059   Ferstl Josef             <NA>        1988 GER   
      28    28    13 530874   Ganong Travis            <NA>        1988 USA   
      29    29    27 200379   Sander Andreas           <NA>        1989 GER   
      30    30    32 104468   Read Jeffrey             <NA>        1997 CAN   
      31    31    38 561397   Naralocnik Nejc          <NA>        1999 SLO   
      32    32    35 54371    Babinsky Stefan          <NA>        1996 AUT   
      33    33    36 350095   Pfiffner Marco           <NA>        1994 LIE   
      34    34    22 192746   Theaux Adrien            <NA>        1984 FRA   
      35    35    25 561255   Cater Martin             <NA>        1992 SLO   
      36    36    41 180904   Tapanainen Jaakko        <NA>        2002 FIN   
      37    37    40 240148   Szollos Barnabas         <NA>        1998 ISR   
      38    38    44 390041   Luik Juhan               <NA>        1997 EST   
      39    39    39 221053   Steudle Roy-Alexander    <NA>        1993 GBR   
      40    40    42 690694   Kovbasnyuk Ivan          <NA>        1993 UKR   
      41    41    45 550109   Opmanis Lauris           <NA>        2001 LAT   
         time      diff_time fis_points cup_points
         <Period>  <Period>       <dbl>      <dbl>
       1 1M 47.05S 0S               0           NA
       2 1M 47.53S 0.48S            5.6         NA
       3 1M 47.94S 0.89S           10.4         NA
       4 1M 47.98S 0.93S           10.9         NA
       5 1M 48.06S 1.01S           11.8         NA
       6 1M 48.13S 1.08S           12.6         NA
       7 1M 48.14S 1.09S           12.7         NA
       8 1M 48.18S 1.13S           13.2         NA
       9 1M 48.18S 1.13S           13.2         NA
      10 1M 48.2S  1.15S           13.4         NA
      11 1M 48.21S 1.16S           13.6         NA
      12 1M 48.28S 1.23S           14.4         NA
      13 1M 48.28S 1.23S           14.4         NA
      14 1M 48.33S 1.28S           15.0         NA
      15 1M 48.58S 1.53S           17.9         NA
      16 1M 48.63S 1.58S           18.4         NA
      17 1M 48.66S 1.61S           18.8         NA
      18 1M 48.8S  1.75S           20.4         NA
      19 1M 48.85S 1.8S            21.0         NA
      20 1M 48.88S 1.83S           21.4         NA
      21 1M 48.92S 1.87S           21.8         NA
      22 1M 48.93S 1.88S           22.0         NA
      23 1M 48.94S 1.89S           22.1         NA
      24 1M 48.95S 1.9S            22.2         NA
      25 1M 48.97S 1.92S           22.4         NA
      26 1M 49.03S 1.98S           23.1         NA
      27 1M 49.12S 2.07S           24.2         NA
      28 1M 49.25S 2.2S            25.7         NA
      29 1M 49.45S 2.4S            28.0         NA
      30 1M 49.5S  2.45S           28.6         NA
      31 1M 49.62S 2.57S           30.0         NA
      32 1M 49.74S 2.69S           31.4         NA
      33 1M 50.5S  3.45S           40.3         NA
      34 1M 50.51S 3.46S           40.4         NA
      35 1M 51.03S 3.98S           46.5         NA
      36 1M 51.41S 4.36S           50.9         NA
      37 1M 51.48S 4.43S           51.7         NA
      38 1M 52.74S 5.69S           66.4         NA
      39 1M 52.76S 5.71S           66.7         NA
      40 1M 54.04S 6.99S           81.6         NA
      41 1M 54.45S 7.4S            86.4         NA

