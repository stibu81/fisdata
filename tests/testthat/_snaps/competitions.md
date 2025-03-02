# query_competitions() works for an apline skiing event

    Code
      print(competitions, width = Inf, n = Inf)
    Output
      # A tibble: 6 x 8
        date       time  competition       sector category gender cancelled race_id
        <date>     <chr> <chr>             <chr>  <chr>    <chr>  <lgl>     <chr>  
      1 2025-01-14 12:30 Downhill Training AL     TRA      M      FALSE     122804 
      2 2025-01-15 12:30 Downhill Training AL     TRA      M      FALSE     122805 
      3 2025-01-16 <NA>  Downhill Training AL     TRA      M      TRUE      122806 
      4 2025-01-17 12:30 Super G           AL     WC       M      FALSE     122807 
      5 2025-01-18 12:45 Downhill          AL     WC       M      FALSE     122808 
      6 2025-01-19 10:15 Slalom            AL     WC       M      FALSE     122809 

# query_competitions() works for a ski jumping event

    Code
      print(competitions, width = Inf, n = Inf)
    Output
      # A tibble: 6 x 8
        date       time  competition                 sector category gender cancelled
        <date>     <chr> <chr>                       <chr>  <chr>    <chr>  <lgl>    
      1 2025-03-20 18:10 Large Hill HS130            JP     WC       W      FALSE    
      2 2025-03-20 <NA>  Large Hill HS130            JP     QUA      W      FALSE    
      3 2025-03-21 15:50 Large Hill HS130            JP     WC       W      FALSE    
      4 2025-03-22 17:35 Large Hill HS130            JP     WC       M      FALSE    
      5 2025-03-22 16:00 Large Hill HS130            JP     QUA      M      FALSE    
      6 2025-03-23 17:30 Super Team Large Hill HS130 JP     WC       M      FALSE    
        race_id
        <chr>  
      1 7258   
      2 7257   
      3 7260   
      4 7262   
      5 7261   
      6 7264   

# query_competitions() works for a cross-country event

    Code
      print(competitions, width = Inf, n = Inf)
    Output
      # A tibble: 7 x 8
        date       time  competition               sector category gender cancelled
        <date>     <chr> <chr>                     <chr>  <chr>    <chr>  <lgl>    
      1 2025-01-24 16:00 4x5km Relay Classic/Free  CC     WC       A      FALSE    
      2 2025-01-25 10:45 Sprint Qualification Free CC     SPWQ     W      FALSE    
      3 2025-01-25 11:20 Sprint Qualification Free CC     SPWQ     M      FALSE    
      4 2025-01-25 13:15 Sprint Final Free         CC     WC       W      FALSE    
      5 2025-01-25 13:45 Sprint Final Free         CC     WC       M      FALSE    
      6 2025-01-26 12:30 20km Mass Start Free      CC     WC       M      FALSE    
      7 2025-01-26 15:00 20km Mass Start Free      CC     WC       W      FALSE    
        race_id
        <chr>  
      1 46803  
      2 46804  
      3 46805  
      4 46806  
      5 46807  
      6 46809  
      7 46808  

