# query_results() works for alpline skiing results for all categories

    Code
      print(dh, width = Inf, n = Inf)
    Output
      # A tibble: 31 x 11
         athlete      date       place                  nation sector
         <chr>        <date>     <chr>                  <chr>  <chr> 
       1 Cuche Didier 2010-03-19 Stoos                  SUI    AL    
       2 Cuche Didier 2010-03-18 Stoos                  SUI    AL    
       3 Cuche Didier 2010-03-17 Stoos                  SUI    AL    
       4 Cuche Didier 2010-03-17 Stoos                  SUI    AL    
       5 Cuche Didier 2010-03-10 Garmisch-Partenkirchen GER    AL    
       6 Cuche Didier 2010-03-09 Garmisch-Partenkirchen GER    AL    
       7 Cuche Didier 2010-03-06 Kvitfjell              NOR    AL    
       8 Cuche Didier 2010-03-05 Kvitfjell              NOR    AL    
       9 Cuche Didier 2010-03-04 Kvitfjell              NOR    AL    
      10 Cuche Didier 2010-02-15 Whistler Creekside     CAN    AL    
      11 Cuche Didier 2010-02-11 Whistler Creekside     CAN    AL    
      12 Cuche Didier 2010-01-23 Kitzbuehel             AUT    AL    
      13 Cuche Didier 2010-01-21 Kitzbuehel             AUT    AL    
      14 Cuche Didier 2010-01-20 Kitzbuehel             AUT    AL    
      15 Cuche Didier 2010-01-16 Wengen                 SUI    AL    
      16 Cuche Didier 2010-01-15 Wengen                 SUI    AL    
      17 Cuche Didier 2010-01-14 Wengen                 SUI    AL    
      18 Cuche Didier 2010-01-12 Wengen                 SUI    AL    
      19 Cuche Didier 2009-12-29 Bormio                 ITA    AL    
      20 Cuche Didier 2009-12-28 Bormio                 ITA    AL    
      21 Cuche Didier 2009-12-27 Bormio                 ITA    AL    
      22 Cuche Didier 2009-12-19 Val Gardena-Groeden    ITA    AL    
      23 Cuche Didier 2009-12-17 Val Gardena-Groeden    ITA    AL    
      24 Cuche Didier 2009-12-16 Val Gardena-Groeden    ITA    AL    
      25 Cuche Didier 2009-12-05 Beaver Creek           USA    AL    
      26 Cuche Didier 2009-12-04 Beaver Creek           USA    AL    
      27 Cuche Didier 2009-12-03 Beaver Creek           USA    AL    
      28 Cuche Didier 2009-12-02 Beaver Creek           USA    AL    
      29 Cuche Didier 2009-11-28 Lake Louise            CAN    AL    
      30 Cuche Didier 2009-11-27 Lake Louise            CAN    AL    
      31 Cuche Didier 2009-11-25 Lake Louise            CAN    AL    
         category               discipline  rank fis_points cup_points race_id
         <chr>                  <chr>      <int>      <dbl>      <dbl> <chr>  
       1 National Championships Downhill       3      13.2          NA 60969  
       2 FIS                    Downhill       1       9            NA 60967  
       3 Training               Downhill       1      NA            NA 60964  
       4 Training               Downhill       1      NA            NA 60962  
       5 World Cup              Downhill       8       2.12         32 59275  
       6 Training               Downhill       6      NA            NA 59273  
       7 World Cup              Downhill       1       0           100 59320  
       8 Training               Downhill       1      NA            NA 59319  
       9 Training               Downhill       1      NA            NA 59318  
      10 Olympic Winter Games   Downhill       6       4.16         NA 59529  
      11 Training               Downhill      NA      NA            NA 62048  
      12 World Cup              Downhill       1       0           100 59312  
      13 Training               Downhill       2      NA            NA 59310  
      14 Training               Downhill       1      NA            NA 59309  
      15 World Cup              Downhill       5       7.46         45 59306  
      16 World Cup Speed Event  Downhill      NA      NA            NA 59305  
      17 Training               Downhill       8      NA            NA 59303  
      18 Training               Downhill       1      NA            NA 62038  
      19 World Cup              Downhill       5      14.0          45 59774  
      20 Training               Downhill       3      NA            NA 59773  
      21 Training               Downhill       6      NA            NA 59772  
      22 World Cup              Downhill      10       9.25         26 59296  
      23 Training               Downhill       1      NA            NA 59294  
      24 Training               Downhill       6      NA            NA 59293  
      25 World Cup              Downhill       2       0.26         80 59287  
      26 World Cup Speed Event  Downhill       2       3.17         NA 59286  
      27 Training               Downhill       2      NA            NA 59284  
      28 Training               Downhill      29      NA            NA 59283  
      29 World Cup              Downhill       1       0           100 59017  
      30 Training               Downhill       8      NA            NA 59016  
      31 Training               Downhill       1      NA            NA 59014  

# query_results() works for alpline skiing results for trainings

    Code
      print(tra, width = Inf, n = Inf)
    Output
      # A tibble: 18 x 11
         athlete      date       place                  nation sector category
         <chr>        <date>     <chr>                  <chr>  <chr>  <chr>   
       1 Cuche Didier 2010-03-17 Stoos                  SUI    AL     Training
       2 Cuche Didier 2010-03-17 Stoos                  SUI    AL     Training
       3 Cuche Didier 2010-03-09 Garmisch-Partenkirchen GER    AL     Training
       4 Cuche Didier 2010-03-05 Kvitfjell              NOR    AL     Training
       5 Cuche Didier 2010-03-04 Kvitfjell              NOR    AL     Training
       6 Cuche Didier 2010-02-11 Whistler Creekside     CAN    AL     Training
       7 Cuche Didier 2010-01-21 Kitzbuehel             AUT    AL     Training
       8 Cuche Didier 2010-01-20 Kitzbuehel             AUT    AL     Training
       9 Cuche Didier 2010-01-14 Wengen                 SUI    AL     Training
      10 Cuche Didier 2010-01-12 Wengen                 SUI    AL     Training
      11 Cuche Didier 2009-12-28 Bormio                 ITA    AL     Training
      12 Cuche Didier 2009-12-27 Bormio                 ITA    AL     Training
      13 Cuche Didier 2009-12-17 Val Gardena-Groeden    ITA    AL     Training
      14 Cuche Didier 2009-12-16 Val Gardena-Groeden    ITA    AL     Training
      15 Cuche Didier 2009-12-03 Beaver Creek           USA    AL     Training
      16 Cuche Didier 2009-12-02 Beaver Creek           USA    AL     Training
      17 Cuche Didier 2009-11-27 Lake Louise            CAN    AL     Training
      18 Cuche Didier 2009-11-25 Lake Louise            CAN    AL     Training
         discipline  rank fis_points cup_points race_id
         <chr>      <int>      <dbl>      <dbl> <chr>  
       1 Downhill       1         NA         NA 60964  
       2 Downhill       1         NA         NA 60962  
       3 Downhill       6         NA         NA 59273  
       4 Downhill       1         NA         NA 59319  
       5 Downhill       1         NA         NA 59318  
       6 Downhill      NA         NA         NA 62048  
       7 Downhill       2         NA         NA 59310  
       8 Downhill       1         NA         NA 59309  
       9 Downhill       8         NA         NA 59303  
      10 Downhill       1         NA         NA 62038  
      11 Downhill       3         NA         NA 59773  
      12 Downhill       6         NA         NA 59772  
      13 Downhill       1         NA         NA 59294  
      14 Downhill       6         NA         NA 59293  
      15 Downhill       2         NA         NA 59284  
      16 Downhill      29         NA         NA 59283  
      17 Downhill       8         NA         NA 59016  
      18 Downhill       1         NA         NA 59014  

# query_results() works for alpline skiing results for World Championships

    Code
      print(wsc, width = Inf, n = Inf)
    Output
      # A tibble: 6 x 11
        athlete      date       place                  nation sector
        <chr>        <date>     <chr>                  <chr>  <chr> 
      1 Cuche Didier 2011-02-09 Garmisch-Partenkirchen GER    AL    
      2 Cuche Didier 2009-02-04 Val d'Isère            FRA    AL    
      3 Cuche Didier 2007-02-06 Are                    SWE    AL    
      4 Cuche Didier 2003-02-02 St. Moritz             SUI    AL    
      5 Cuche Didier 2001-01-30 St. Anton              AUT    AL    
      6 Cuche Didier 1999-02-02 Vail/Beaver Creek, CO  USA    AL    
        category            discipline  rank fis_points cup_points race_id
        <chr>               <chr>      <int>      <dbl>      <dbl> <chr>  
      1 World Championships Super G        4      11.1          NA 62334  
      2 World Championships Super G        1       0            NA 54003  
      3 World Championships Super G        4       8.73         NA 49071  
      4 World Championships Super G       11      15.6          NA 19138  
      5 World Championships Super G        5       2.78         NA 13480  
      6 World Championships Super G        8      10.5          NA 7942   

