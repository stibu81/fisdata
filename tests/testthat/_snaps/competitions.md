# query_competitions() works for an apline skiing event

    Code
      print(competitions, width = Inf, n = Inf)
    Output
      # A tibble: 6 x 9
        place  date       time  competition       sector category gender cancelled
        <chr>  <date>     <chr> <chr>             <chr>  <chr>    <chr>  <lgl>    
      1 Wengen 2025-01-14 12:30 Downhill Training AL     TRA      M      FALSE    
      2 Wengen 2025-01-15 12:30 Downhill Training AL     TRA      M      FALSE    
      3 Wengen 2025-01-16 <NA>  Downhill Training AL     TRA      M      TRUE     
      4 Wengen 2025-01-17 12:30 Super G           AL     WC       M      FALSE    
      5 Wengen 2025-01-18 12:45 Downhill          AL     WC       M      FALSE    
      6 Wengen 2025-01-19 10:15 Slalom            AL     WC       M      FALSE    
        race_id
        <chr>  
      1 122804 
      2 122805 
      3 122806 
      4 122807 
      5 122808 
      6 122809 

# query_competitions() works for a ski jumping event

    Code
      print(competitions, width = Inf, n = Inf)
    Output
      # A tibble: 6 x 9
        place date       time  competition                 sector category gender
        <chr> <date>     <chr> <chr>                       <chr>  <chr>    <chr> 
      1 Lahti 2025-03-20 18:10 Large Hill HS130            JP     WC       W     
      2 Lahti 2025-03-20 <NA>  Large Hill HS130            JP     QUA      W     
      3 Lahti 2025-03-21 15:50 Large Hill HS130            JP     WC       W     
      4 Lahti 2025-03-22 17:35 Large Hill HS130            JP     WC       M     
      5 Lahti 2025-03-22 16:00 Large Hill HS130            JP     QUA      M     
      6 Lahti 2025-03-23 17:30 Super Team Large Hill HS130 JP     WC       M     
        cancelled race_id
        <lgl>     <chr>  
      1 FALSE     7258   
      2 FALSE     7257   
      3 FALSE     7260   
      4 FALSE     7262   
      5 FALSE     7261   
      6 FALSE     7264   

# query_competitions() works for a cross-country event

    Code
      print(competitions, width = Inf, n = Inf)
    Output
      # A tibble: 7 x 9
        place   date       time  competition               sector category gender
        <chr>   <date>     <chr> <chr>                     <chr>  <chr>    <chr> 
      1 Engadin 2025-01-24 16:00 4x5km Relay Classic/Free  CC     WC       A     
      2 Engadin 2025-01-25 10:45 Sprint Qualification Free CC     SPWQ     W     
      3 Engadin 2025-01-25 11:20 Sprint Qualification Free CC     SPWQ     M     
      4 Engadin 2025-01-25 13:15 Sprint Final Free         CC     WC       W     
      5 Engadin 2025-01-25 13:45 Sprint Final Free         CC     WC       M     
      6 Engadin 2025-01-26 12:30 20km Mass Start Free      CC     WC       M     
      7 Engadin 2025-01-26 15:00 20km Mass Start Free      CC     WC       W     
        cancelled race_id
        <lgl>     <chr>  
      1 FALSE     46803  
      2 FALSE     46804  
      3 FALSE     46805  
      4 FALSE     46806  
      5 FALSE     46807  
      6 FALSE     46809  
      7 FALSE     46808  

