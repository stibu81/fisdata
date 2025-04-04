# summarise_results() works with default settings

    Code
      print(cuche_sum, width = Inf, n = Inf)
    Output
      # A tibble: 10 x 15
         athlete      season category            discipline podium  pos1  pos2  pos3
         <chr>         <int> <chr>               <chr>       <int> <int> <int> <int>
       1 Cuche Didier   2009 World Cup           Downhill        0     0     0     0
       2 Cuche Didier   2009 World Championships Super G         1     1     0     0
       3 Cuche Didier   2009 World Championships Downhill        1     0     1     0
       4 Cuche Didier   2010 World Cup           Super G         0     0     0     0
       5 Cuche Didier   2010 World Cup           Downhill        1     1     0     0
       6 Cuche Didier   2011 World Cup           Super G         1     0     0     1
       7 Cuche Didier   2011 World Championships Super G         0     0     0     0
       8 Cuche Didier   2011 World Championships Downhill        1     0     1     0
       9 Cuche Didier   2011 World Cup           Downhill        0     0     0     0
      10 Cuche Didier   2012 World Cup           Downhill        0     0     0     0
          top5 top10 top20 top30   dnf n_races cup_points
         <int> <int> <int> <int> <int>   <int>      <dbl>
       1     1     0     1     0     0       2         70
       2     0     0     0     0     0       1          0
       3     0     0     0     0     0       1          0
       4     0     0     0     0     1       1          0
       5     0     0     0     0     0       1        100
       6     1     0     0     0     0       2        110
       7     1     0     0     0     0       1          0
       8     0     0     0     0     0       1          0
       9     1     1     0     0     0       2         81
      10     0     1     1     0     0       2         54

