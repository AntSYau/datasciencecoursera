# load files
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accesType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv")
restData = read.csv("./data/restaurants.csv")

# look at a bit of data
head(restData, 3) # first three rows in the data frame
tail(restData, 3) # last three rows

## SUMMARY!
summary(restData)
#  results:
#                            name         zipCode             neighborhood councilDistrict 
#  MCDONALD'S                  :   8   Min.   :-21226   Downtown    :128   Min.   : 1.000  
#  POPEYES FAMOUS FRIED CHICKEN:   7   1st Qu.: 21202   Fells Point : 91   1st Qu.: 2.000  
#  SUBWAY                      :   6   Median : 21218   Inner Harbor: 89   Median : 9.000  
#  KENTUCKY FRIED CHICKEN      :   5   Mean   : 21185   Canton      : 81   Mean   : 7.191  
#  BURGER KING                 :   4   3rd Qu.: 21226   Federal Hill: 42   3rd Qu.:11.000  
#  DUNKIN DONUTS               :   4   Max.   : 21287   Mount Vernon: 33   Max.   :14.000  
#  (Other)                     :1293                    (Other)     :863                   
#       policeDistrict                          Location.1    
#  SOUTHEASTERN:385    1101 RUSSELL ST\nBaltimore, MD\n:   9  
#  CENTRAL     :288    201 PRATT ST\nBaltimore, MD\n   :   8  
#  SOUTHERN    :213    2400 BOSTON ST\nBaltimore, MD\n :   8  
#  NORTHERN    :157    300 LIGHT ST\nBaltimore, MD\n   :   5  
#  NORTHEASTERN: 72    300 CHARLES ST\nBaltimore, MD\n :   4  
#  EASTERN     : 67    301 LIGHT ST\nBaltimore, MD\n   :   4  
#  (Other)     :145    (Other)                         :1289  

str(restData)
# results:
# 'data.frame':	1327 obs. of  6 variables:
#  $ name           : Factor w/ 1277 levels "1919","19TH HOLE",..: 9 1 990 3 4 2 6 7 8 5 ...
#  $ zipCode        : int  21206 21231 21224 21211 21223 21218 21205 21211 21205 21231 ...
#  $ neighborhood   : Factor w/ 173 levels "Abell","Arlington",..: 53 52 18 66 104 33 98 133 98 157 ...
#  $ councilDistrict: int  2 1 1 14 9 14 13 7 13 1 ...
#  $ policeDistrict : Factor w/ 9 levels "CENTRAL","EASTERN",..: 3 6 6 4 8 3 6 4 6 6 ...
#  $ Location.1     : Factor w/ 1210 levels "1000 ALICEANNA ST\nBaltimore, MD\n",..: 833 324 550 755 484 532 498 525 500 571 ...

quantile(restData$councilDistrict,na.rm = TRUE)
# results:
#   0%  25%  50%  75% 100% 
#    1    2    9   11   14 
quantile(restData$councilDistrict,probs = c(0.5,0.75,0.9))

# make table
table(restData$zipCode,useNA = "ifany")
# useNA = "ifany": add a column to count NAs.
#     By default, R does not.

# make a table in two dimensions
table(restData$councilDistrict,restData$zipCode)

# check for missing values
sum(is.na(restData$councilDistrict)) # [1] 0
any(is.na(restData$councilDistrict)) # [1] FALSE
all(restData$zipCode > 0) # [1] FALSE

# another way to check NAs faster
colSums(is.na(restData)) # count NAs in each column.
all(colSums(is.na(restData)) == 0) # check if all counts equal to 0.

# values with specific characteristics
table(restData$zipCode %in% c("21212","21213"))

# substract it
restData[restData$zipCode %in% c("21212","21213"),]

# cross tabs
data("UCBAdmissions")
DF <- as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data = DF)
# break down freq by gender and admit.
# results:
#         Admit
# Gender   Admitted Rejected
#   Male       1198     1493
#   Female      557     1278
