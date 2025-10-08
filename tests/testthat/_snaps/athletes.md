# query_athletes() works

    Code
      print(cuche, width = Inf, n = Inf)
    Output
      # A tibble: 8 x 11
        active fis_code name          nation   age birthdate  gender sector
        <lgl>  <chr>    <chr>         <chr>  <int> <chr>      <chr>  <chr> 
      1 FALSE  510030   Cuche Didier  SUI       NA 1974       M      AL    
      2 FALSE  511217   Cuche Dimitri SUI       NA 1985       M      AL    
      3 FALSE  511516   Cuche Gregory SUI       NA 1986       M      AL    
      4 TRUE   512715   Cuche Quentin SUI       19 2006-10-05 M      AL    
      5 FALSE  194543   Cuche Remi    FRA       NA 1992       M      AL    
      6 TRUE   512385   Cuche Remi    SUI       25 2000-04-25 M      AL    
      7 TRUE   200665   Cuche Robin   SUI       27 1998-05-21 M      PAL   
      8 FALSE  3454     Cucheron Per  NOR       NA <NA>       M      JP    
        club                 brand competitor_id
        <chr>                <chr> <chr>        
      1 Chasseral Dombresson Head  11795        
      2 SAS Lausanne         <NA>  11796        
      3 <NA>                 <NA>  94494        
      4 Chasseral-Dombresson <NA>  270006       
      5 Sc Val morteau       <NA>  136057       
      6 Chasseral-Dombresson Head  212253       
      7 <NA>                 <NA>  289853       
      8 <NA>                 <NA>  11798        

