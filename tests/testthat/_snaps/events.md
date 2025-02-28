# query_events() works with events from many sectors

    Code
      print(events_20250201, width = Inf, n = Inf)
    Output
      # A tibble: 67 x 10
         start_date end_date   place                      nation sector
         <date>     <date>     <chr>                      <chr>  <chr> 
       1 2025-01-27 2025-02-01 Schweitzer Mountain Resort USA    AL    
       2 2025-01-27 2025-02-01 Kashkulak (KGZ)            UZB    AL    
       3 2025-01-27 2025-02-01 Val Thorens                FRA    FR    
       4 2025-01-27 2025-02-02 Vars                       FRA    SS    
       5 2025-01-28 2025-02-01 Orcieres Merlette 1850     FRA    AL    
       6 2025-01-29 2025-02-01 La Clusaz - Grand Bornand  FRA    AL    
       7 2025-01-30 2025-02-01 3 5 Pigadia                GRE    CC    
       8 2025-01-30 2025-02-02 Veysonnaz                  SUI    FS    
       9 2025-01-30 2025-02-02 Seefeld                    AUT    NK    
      10 2025-01-30 2025-02-02 Tokamachi                  JPN    CC    
      11 2025-01-30 2025-02-06 Aspen                      USA    FS    
      12 2025-01-30 2025-02-06 Aspen                      USA    SB    
      13 2025-01-31 2025-02-01 Kamui                      JPN    AL    
      14 2025-01-31 2025-02-01 Smugglers Notch Ski Club   USA    AL    
      15 2025-01-31 2025-02-01 Wisla, Kubalonka           POL    CC    
      16 2025-01-31 2025-02-01 Lac-Beauport Quebec        CAN    FS    
      17 2025-01-31 2025-02-01 Kamoidake                  JPN    SB    
      18 2025-01-31 2025-02-01 Blue Mountain              CAN    SB    
      19 2025-01-31 2025-02-01 Val St. Come               CAN    FS    
      20 2025-01-31 2025-02-02 Cogne                      ITA    CC    
      21 2025-01-31 2025-02-02 Grindelwald                SUI    SB    
      22 2025-01-31 2025-02-02 Grindelwald                SUI    FS    
      23 2025-01-31 2025-02-02 Winsport Calgary           CAN    SB    
      24 2025-01-31 2025-02-02 Beidahu                    CHN    SB    
      25 2025-01-31 2025-02-02 Garmisch-Partenkirchen     GER    AL    
      26 2025-01-31 2025-02-02 Kimberley, BC              CAN    CC    
      27 2025-01-31 2025-02-02 Mont Sainte-Anne, QC       CAN    CC    
      28 2025-01-31 2025-02-02 Willingen                  GER    JP    
      29 2025-01-31 2025-02-02 St. Lary                   FRA    SB    
      30 2025-01-31 2025-02-02 Duved                      SWE    AL    
      31 2025-01-31 2025-02-02 Sugadaira Kogen            JPN    MA    
      32 2025-01-31 2025-02-02 Lillehammer                NOR    NK    
      33 2025-01-31 2025-02-02 Zao Liza                   JPN    AL    
      34 2025-01-31 2025-02-02 Kühtai                     AUT    PSB   
      35 2025-01-31 2025-02-02 Kühtai                     AUT    PSB   
      36 2025-01-31 2025-02-07 Alpensia Resort            KOR    AL    
      37 2025-02-01 2025-02-01 Kronplatz (ITA)            ALB    AL    
      38 2025-02-01 2025-02-01 Pariisi Puhkekula          EST    CC    
      39 2025-02-01 2025-02-01 Beret                      ESP    CC    
      40 2025-02-01 2025-02-02 Reiteralm                  AUT    SB    
      41 2025-02-01 2025-02-02 SZCZYRK-SkaliteRK          POL    JP    
      42 2025-02-01 2025-02-02 Dalvik                     ISL    AL    
      43 2025-02-01 2025-02-02 SZCZAWNICA PALENICA        POL    MA    
      44 2025-02-01 2025-02-02 Jyväskylä                  FIN    FS    
      45 2025-02-01 2025-02-02 Val di Fiemme              ITA    PCC   
      46 2025-02-01 2025-02-02 Kamoidake                  JPN    SB    
      47 2025-02-01 2025-02-02 La Molina                  ESP    AL    
      48 2025-02-01 2025-02-02 Ounasvaara                 FIN    AL    
      49 2025-02-01 2025-02-02 Stara Planina              SRB    SB    
      50 2025-02-01 2025-02-02 Grasgehren                 GER    FS    
      51 2025-02-01 2025-02-02 Dobbiaco-Cortina d Ampezzo ITA    CC    
      52 2025-02-01 2025-02-02 Kamui                      JPN    AL    
      53 2025-02-01 2025-02-02 Lenzerheide                SUI    AL    
      54 2025-02-01 2025-02-02 Hochficht                  AUT    AL    
      55 2025-02-01 2025-02-02 Les Diablerets             SUI    AL    
      56 2025-02-01 2025-02-02 Hassela                    SWE    AL    
      57 2025-02-01 2025-02-02 Keystone Resort            USA    AL    
      58 2025-02-01 2025-02-02 Stoneham                   CAN    AL    
      59 2025-02-01 2025-02-02 Government Peak            USA    CC    
      60 2025-02-01 2025-02-02 Ratschings                 ITA    SB    
      61 2025-02-01 2025-02-02 Lillehammer                NOR    JP    
      62 2025-02-01 2025-02-02 Oberammergau               GER    CC    
      63 2025-02-01 2025-02-02 Val Gardena - Groeden      ITA    AL    
      64 2025-02-01 2025-02-02 West Mountain              USA    AL    
      65 2025-02-01 2025-02-02 Les Menuires               FRA    AL    
      66 2025-02-01 2025-02-02 San Vito di Cadore         ITA    AL    
      67 2025-02-01 2025-02-03 Bardonecchia               ITA    AL    
         categories       disciplines                          genders cancelled
         <chr>            <chr>                                <chr>   <lgl>    
       1 TRA / FIS        8xDH / 4xSG                          M / W   FALSE    
       2 FIS / NJR        4xSL / 4xGS                          M / W   FALSE    
       3 FWTP             2xSB / 2xSK                          M / W   FALSE    
       4 WC               4xA                                  M / W   FALSE    
       5 TRA / EC         4xDH / SG                            M       FALSE    
       6 FIS              4xSL / 4xGS                          M / W   FALSE    
       7 CHI / BC         10x5k / 2x10k                        M / W   FALSE    
       8 QUA / WC         8xSX                                 M / W   FALSE    
       9 PR / WC          4xGUN / 2xMSN / 2xICN                M / W   FALSE    
      10 NC               3x10k / 4xSP / 15k                   M / W   FALSE    
      11 QUA / WC         4xHP / 4xSS / 4xBA                   M / W   FALSE    
      12 QUA / WC         4xHP / 4xBA / 4xSS                   M / W   FALSE    
      13 FIS              2xGS                                 M / W   FALSE    
      14 UNI              2xSL / 2xGS                          M / W   FALSE    
      15 JUN / FIS        2x10k / 2x15k / 8xSP                 M / W   FALSE    
      16 FIS / OPN        4xAE                                 M / W   FALSE    
      17 FIS              2xSS                                 M / W   TRUE     
      18 FIS              2xSS                                 M / W   FALSE    
      19 WC               2xMO / 2xDM                          M / W   FALSE    
      20 WC / TSPQ / SPWQ 2x10k / 2x12TSPQ / 2xTsp / TSPQ / SP M / W   FALSE    
      21 FIS / JUN / CHI  6xHP / 4xSS                          M / W   FALSE    
      22 FIS / JUN / CHI  6xHP / 4xSS                          M / W   FALSE    
      23 FIS              2xHP / 2xSS                          M / W   FALSE    
      24 QUA / WC         8xSBX                                M / W   FALSE    
      25 TRA              2xDH                                 M       TRUE     
      26 FIS              2x15k / 2xPur / 4xSP                 M / W   FALSE    
      27 FIS              2x10k / 4xSP                         M / W   FALSE    
      28 QUA / WC         6xLH / TL                            M / W   FALSE    
      29 EC / NC          6xSBX                                M / W   FALSE    
      30 NJR / FIS / ENL  6xGS / 2xSG                          M / W   FALSE    
      31 MAS              4xSL / 4xGS                          M / W   FALSE    
      32 COC              4xGUN / GUL                          M / W   FALSE    
      33 FIS              4xSL                                 M / W   FALSE    
      34 TRA / WC         6xBSL                                M / W   FALSE    
      35 TRA / EC         6xBSL                                M / W   FALSE    
      36 FEC              8xSL                                 M / W   FALSE    
      37 NJC              2xSL                                 M / W   FALSE    
      38 ML               2xMar                                M / W   TRUE     
      39 NC               4xSP                                 M / W   FALSE    
      40 JUN              4xSBX                                M / W   FALSE    
      41 FC               2xNH                                 M       FALSE    
      42 ENL              4xSL / 2xGS                          M / W   TRUE     
      43 MAS              4xSL / 4xGS                          M / W   FALSE    
      44 EC               4xMO                                 M / W   FALSE    
      45 WC               2xINT / 2xSPQ / 2xSPF                M / W   FALSE    
      46 FIS              2xSS                                 M / W   TRUE     
      47 FIS              2xSL / 2xGS                          M / W   FALSE    
      48 FIS / NJC        4xSL                                 M / W   FALSE    
      49 FIS              4xGS / 4xSL                          M / W   FALSE    
      50 JUN              4xSX                                 M / W   FALSE    
      51 ML               2xMar / 2xML                         M / W   FALSE    
      52 FIS              2xGS                                 M / W   FALSE    
      53 FIS              2xSL                                 W       FALSE    
      54 FIS              2xGS                                 M       FALSE    
      55 UNI              2xSL / 2xGS                          M / W   FALSE    
      56 FIS              2xSL / 4xGS                          M / W   FALSE    
      57 FIS              4xSL                                 M / W   FALSE    
      58 ENL              4xGS                                 M / W   FALSE    
      59 FIS              2x5k / 2x10k                         M / W   FALSE    
      60 EC / QUA         8xPSL                                M / W   FALSE    
      61 COC              2xLH                                 M       FALSE    
      62 ML               4x10k / 4x30k / 4x50k                M / W   TRUE     
      63 NJR              4xSL                                 M / W   FALSE    
      64 UNI              4xGS                                 M / W   FALSE    
      65 CIT              4xSL                                 M / W   FALSE    
      66 NJR              4xSL                                 M / W   FALSE    
      67 NJR              4xSL                                 M / W   FALSE    
         event_id
         <chr>   
       1 56757   
       2 57710   
       3 57668   
       4 57175   
       5 55627   
       6 56157   
       7 56265   
       8 55696   
       9 55911   
      10 57040   
      11 55930   
      12 55932   
      13 56372   
      14 56758   
      15 57046   
      16 57323   
      17 57471   
      18 57565   
      19 55679   
      20 57322   
      21 57494   
      22 57517   
      23 57558   
      24 57596   
      25 55602   
      26 56632   
      27 56633   
      28 55892   
      29 55970   
      30 56325   
      31 56272   
      32 56261   
      33 56371   
      34 56041   
      35 56042   
      36 56712   
      37 57665   
      38 56884   
      39 56072   
      40 57407   
      41 56110   
      42 57363   
      43 57342   
      44 57158   
      45 56094   
      46 57472   
      47 56076   
      48 56009   
      49 57681   
      50 57724   
      51 56897   
      52 56373   
      53 56481   
      54 56582   
      55 56610   
      56 56313   
      57 56759   
      58 56774   
      59 56874   
      60 56120   
      61 56260   
      62 56232   
      63 57100   
      64 57134   
      65 56167   
      66 57230   
      67 56981   

