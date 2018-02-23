########################################################################################################################—•°
## R for complete beginners (by A.K.)
## start:2017-02-19; last:2017-02-25
########################################################################################################################—•°
########################################################################################################################—•°

########################################################################################################################—•°
## 03. Accessing elements of lists, vectors, matrices, tables, arrays, data.frames, etc.
########################################################################################################################—•°

rm(list=ls())   ## clearing environment

setwd("D:/ROBOCZY/R/TutorialAK/03 Accessing Vectors' Elements/")
load(".RData")  ## if you have saved environment earlier and you want to restore it

###############################################################################—•°
## There are three ways for accessing elements of an object (vector, list):
## 1. via its numeric position,
## 2. via logicals,
## 3. via name of an element.
##
## We haven't yet learned about named vectors but we do soon.

###############################################################################—•°
## Accessing vector's elements is also called "subsetting" as you may choose
## one or more elements i.e. a subset of a set of all elements of a vector
## (it may happen that you choose nothing i.e. an empty subset).
###############################################################################—•°

###################################################################################################—•°
## 1. Referencing elements by numeric position
###################################################################################################—•°

###############################################################################—•°
## 1.1. Vectors (atomic) without dimensions
###############################################################################—•°

(nn <- 11:20)

nn[1]
nn[4]
nn[1:3]
nn[1:3*2]    ## first 3 even indices (how the rule of recycling works here?);
nn[1:(3*2)]
nn[1:3*2-1]  ## first 3 odd indices

nn[11]       ## there's no 11-th elemnt of nn; NA is (almost) the same as NULL in SQL
nn[9:11]

nn[c(3,5,6)]
nn[c(3,11,5,12,6)]

nn[0]
nn[NA]       ## in this context NA is treated as logical and is replicated to the length of a vector
             ## because this is the rule for the logicals used as indices (what is described below);
             ## nonetheless, NA gives NA.

#######################################—•°
## random element
nn[sample(seq_along(nn),1)] ## what is the same as:
   sample(nn,1)
## random elements
nn[sample(seq_along(nn),5)]
   sample(nn,5)

## random sampling (of elements of a given vector) this way is not a good idea ( sample(vactor) is simpler)
## but it is the most efficient method for repeating elements in a regular manner:

#######################################—•°
##!!! repeating elements !!!
nn[c(1,1,1)]
nn[rep(1:3,length=7)]
nn[rep(1:3,each=2)]

nn[rep(seq(1,length(nn),3),each=4)]        ## say it in words
nn[rep(seq(1,length(nn),3),length=100)]

#######################################—•°
## excluding elements
nn[-1]
nn[c(-1,0)]    ## 0 is neutral — used as index returns empty vector
nn[-1:2]       ## ERROR;
nn[-(1:2)]     ## OK — remove first and second element


nn[-(1:3*2)]      ## say it
nn[-(1:(3*2))]
nn[-c(3,7)]

nn[-length(nn)]  ## getting rid of the last element
rev(rev(nn)[-1]) ## the same

   rev(1:5)

#######################################—•°
## now you can use special (predefined) vectors of letters
letters
LETTERS

letters[1:4]
LETTERS[1:4]

   rev(letters[1:4])
   letters[rev(1:4)]
   letters[4:1]

#######################################—•°
save.image()

###############################################################################—•°
## 1.2. Vectors (atomic) with dimensions (arrays, tables, matrices)
###############################################################################—•°

(mm <- matrix(1:24,nrow=6))

mm[1]
mm[1:3]
mm[5:15]

## BUT
mm[1,]      ## first row
mm[1:3,]    ## rows 1 to 3
mm[5:15,]   ## ERROR, there are only 6 rows

mm[,1]      ## first column
mm[,1:3]    ## columns 1 to 3

mm[1,1]
mm[2,3]
mm[1:2,2:3]
mm[1:2*2,2:3]
mm[1:2*2,-(2:3)]

   #######################################—•°
   ## notice that:
   1:3*2
   2*1:3
   1:(3*2)
   ## thus  :  has precedence over  * , and also over -, +, / (as binary operators)
   ## BUT
   -1:3
   -(1:3)
   ## thus  -  (as unary operator — changing sign of a number) has precedence over  :
   #######################################—•°

## permutations and repeating rows and columns
mm[6:1,4:1]
mm[sample(6),sample(4)]
mm[rep(1:3,each=3),]
mm[rep(1:3,3),]
mm[rep(1:3,3),rep(1:3,3)]
mm[rep(seq_len(nrow(mm)),2),rep(seq_len(ncol(mm)),2)]
mm[rep(1:3,each=2),rep(1:3,each=2)]
...

#######################################—•°
## indexing matrix with other matrix
(idx <- cbind(c(1,4,5),c(2,4,1)))   ## first vector for row index the second for column index
mm[idx]

## how to get diagonal elements
(mindim <- min(dim(mm)))
(idx <- matrix(rep(1:mindim,each=2),ncol=2,byrow=TRUE))
mm[idx]

   ## there is command for diagonal
   diag(mm)       ## diagonal of the matrix
   ## BUT
   diag(6)        ## unit matrix of size 6
   diag(as.matrix(6))
   diag(1:6)      ## diagonal matrix constructed from the given vector
   diag(c(3,2,5))


#######################################—•°
## losing dimensions

dim(mm)
dim(mm[1:3,3:4])
## BUT
   mm[1:3,3]
dim(mm[1:3,3])  ##!!!
## If one of the dimensions is 1 then it is abandoned by default, but one dimension is simply length() of the vector.

   #######################################—•°
   ## how it works:
   (xx = 1:4)
   dim(xx)          ## NULL dimensions
   ## dimension is an attribute which you can set manually
   dim(xx) <- 4     ## one dimension
   xx
   attributes(xx)   ## all attributes (but there is only "dim")
   attr(xx,"dim")   ## only "dim" attribute

      ## by the way:
      dim(xx) <- 3   ## ERROR
      dim(xx) <- 5   ## ERROR

   dim(xx) <- c(1,4)
   xx                ## the way the vector is displayed has changed

   dim(xx) <- c(4,1)
   xx

   dim(xx) <- c(4,1,1)
   xx

   dim(xx) <- c(1,1,4)
   xx

   ## Think of it thoroughly!

#######################################—•°
##!!! If you wish to retain dimensionality then use
mm[1:3,3,drop=FALSE]
dim(mm[1:3,3,drop=FALSE])

mm[1,]
mm[1,,drop=FALSE]    ## notice two commas !!

mm[,2]
mm[,2,drop=FALSE]    ##

mm[1,1]
mm[1,1,drop=FALSE]    ##  matrix 1x1

#######################################—•°
## more dimensions

(aa <- array(1:24,dim=c(4,3,2)))

aa[1,]   ## ERROR

aa[1,,]              ## the first row of each page
                     ## notice two commas !!
## We've lost one dimension (the first), but we may retain it
aa[1,,,drop=FALSE]   ## notice three commas !!!


aa[,2,]              ## the second column of each page
aa[,2,,drop=FALSE]   ##

aa[,,2]              ## the second page
aa[,,2,drop=FALSE]   ##

## BUT

aa[1:2,,]
aa[,1:2,]
aa[,,1:2]

## and so on...

#######################################—•°
##    Conclusion
## Remember about    ,drop=FALSE]
## especially when writing a function.
#######################################—•°

#######################################—•°
save.image()

###############################################################################—•°
## 1.3. Lists
###############################################################################—•°


( l0 <- list( 1e3, 1:3, "a", TRUE, function(x)x^2 ) )
str(l0)
length(l0)

l0[1]
class(l0[1]); typeof(l0[1])
## this is still a list...

l0[[1]]
class(l0[[1]]); typeof(l0[[1]])
## that's OK

## Hence if you wish to access the element of the list use [[]].
## So what [] means?

l0[1]
l0[1:2]
l0[c(2,5)]

## For lists [] return indicated part of a list together with what is inside of it (not ONLY this content).
## Think about list as a train consisting of number of wagons into which you may put anything.
## But a wagon is not a freight it carries — it is simply a container.
## List may be a single container
l1 <- list(sample(3))
l1
l1[1]
class(l1[1]); typeof(l1[1])
length(l1)
length(l1[1])

## To get the content of a container (list's element) use [[]]
l1[[1]]
class(l1[[1]]); typeof(l1[[1]])
length(l1[[1]])

## As we see, the term "list's element" has two meanings:
##  1° the specific part of a list which is still a list — a container for something (together with its content);
##  2° the content of this part — the staff we're mostly interested with.
## It is sensible to write
l0[1:2]
## in the first meaning (two containers with their contents — just in a form of list),
## but
l0[[1:2]]
## is nonsense! (you cannot get two contents at once — how to mix them?).

str(l0[1:2])
length(l0[1:2])

l0[5]
str(l0[5])
l0[[5]]
str(l0[[5]])

l0[]   ## the whole list; for objects of some classes  obj[]  gives different output then simply  obj

## you may obviusly repeat elements
l0[rep(1:3,3)]

#######################################—•°
## How to get the element of the element:
l0[[2]]
l0[[2]][3]

## take more complicated list
( l2 <- list( 1e3, 1:3, "a", TRUE, function(x)x^2, list( sample(5), letters[1:3], list(LETTERS[2:5],c(3,6,7)) ) ) )
length(l2)
str(l2)

l2[6]
str(l2[6])
l2[[6]]
str(l2[[6]])    ## compare the both carefuly

l2[[6]][1] ; str(l2[[6]][1])
l2[[6]][1][1]          ## the same
l2[[6]][1][1][1]        ## the same
l2[[6]][1][1][1][1]      ## the same ...
## You cannot go inside the container to get its content using [];

## you need [[]]
l2[[6]][[1]] ; str(l2[[6]][[1]])
l2[[6]][[1]]  ## this is content - the numeric in this case
l2[[6]][[1]][1]
l2[[6]][[1]][2]

#######################################—•°
save.image()

##############################################################################—•°
## 1.4. Data frames
###############################################################################—•°

(df <- data.frame( sample(letters[1:3],7,replace=TRUE), sample(7)+10, sample(c(T,F),7,replace=TRUE), runif(7) ))
## Notice the ugly names of the columns — don't care for a while.
## Now we may refer to the given column by its numeric positin in data.frame.

#######################################—•°
## Data frame is a list
## with all the columns having the same length.
#######################################—•°

class(df)
typeof(df)
str(df)

dim(df)  ## data frame is a list but have dimensions

(undf <- unclass(df))
class(undf)
length(undf)
str(undf)

df[1]         ## the first element of the list, what in case of data.frame is the first column
class(df[1])  ##!!! sublist of a list is still a list, thus sub-data.frame of a data.frame is a data.frame !!!
dim(df[1])

df[1:2]
dim(df[1:2])

df[[1]]
class(df[[1]]) ## now its simply vector because we took a content of a list element
               ## "factor" is a default class for character vectors within data.frame;
               ## it is statistical term meaning non-numerical variables;
               ## distinct values of a factor are called "levels"; more on this later.
dim(df[[1]])

df[[1]][3]
df[[2]][1]
df[[2]][1:4]

## because data frame has all elements (columns) of the same length you may treat it as matrix
df[,1]  ## the first column BUT it is different from:
df[1]
## because we haven't lost dimensionality in the latter case while we've lost it in the former.
df[,1,drop=FALSE]

df[,1:2]

#######################################—•°
## selecting rows
df[1:2,]
## selecting rows and columns
df[1:3,c(2,4)]
...

## random sample from the set of records
df[sample(ncol(df),4),]

#######################################—•°
save.image()

###################################################################################################—•°
## 2. Referencing elements by logicals
###################################################################################################—•°

## You may use logical vector to access elements of a vector (both atomic and generic i.e. a list).
## When you use logicals to access the elements of a vector it must have exactly the same length as this vector.
## If is shorter then will be recycled to the proper length.
##
## Every TRUE gives back corresponding element of a vector,
## while every FALSE means that corresponding element will not be returned.

###############################################################################—•°
## 2.1. Vectors (atomic) without dimensions
###############################################################################—•°

nn

nn[c(T,T,F,F, T,T,F,F, T,T)]
nn[c(T,T,F,F)]               ## the same beacause it is recycled

nn[rep(T,length(nn))]        ## all elements
nn[T]                        ## all elements

nn[F]                        ## empty vector, but we know at least that it is integer

nn[c(T,F)]  ## all even indices
nn[c(F,T)]  ## all odd indices
nn[c(T,F,T)]

nn[rep(c(T,F),each=2)]
(1:10)[rep(c(T,F),each=2)]

## notice the difference between logical and 0-1 vector when used as indices
nn[T]  ## this is replicated
nn[1]  ## this is not
nn[F]  ## nothig
nn[0]  ## the same :)

nn[c(T,F)]   ## replicated
nn[c(1,0)]   ##
nn[c(F,T)]   ## replicated
nn[c(0,1)]   ##

## suppose we have two vectors of the same length
(nn2 <- sample(1:10,20,replace=TRUE))
(nn3 <- sample(letters[1:4],20,replace=TRUE))
## we'd like to get elements of one vector for which the corresponding elements of the second satisfy some condition:
nn2==1
nn3[nn2==1]
nn3[nn2<5]
nn2[nn3=="a"]
## counting elements satisfying condition
sum(nn2<5)
## summing elements of one vector given condition for the second
sum(nn2[nn3=="a"])

sum(sample(1:10,20,replace=TRUE)<5)

#######################################—•°
save.image()

###############################################################################—•°
## 2.2. Vectors (atomic) with dimensions (arrays, tables, matrices)
###############################################################################—•°

mm
mm[c(T,F,F,T,T,F),]
mm[c(T,F),]
mm[c(F,T),]

mm[,c(F,T)]

## the reminder of division (also called "modulo")
mm%%2   ## 0, 1

mm%%2==1          ## all odd elements (returned as matrix)
mm[ mm%%2==1 ]    ## and their values

mm%%2==0          ## all even elements
mm[ mm%%2==0 ]    ## and their values

(mm2 <- matrix(sample(letters[1:3],24,replace=TRUE),nrow=6))

mm[mm2=="a"]
mm2[mm%%2==0]   ## all elements of mm2 having even indices
mm2[mm%%2==1]   ## all elements of mm2 having odd indices

#######################################—•°
## The upper triangular of the matrix
## — all the elements which are above the diagonal (together with it if you wish).
##
## Before you go down to work, learn about
##    outer(vector1,vector2,function)
## where function() is binary (needs two arguments) and is applied to each combination of elements of vector1 and vector2
outer(letters[1:3],1:3,paste0)
outer(letters[1:3],1:3,"paste0")   ## the same
outer(1:4,1:3,paste)
##
outer(1:4,1:3,"*")                 ## for binary operators you MUST use ""
outer(1:4,1:3,"+")
outer(1:4,1:3,"/")
outer(1:4,1:3,"^")
outer(1:4,1:3,"<")
##
outer(1:4,1:3,"==")
outer(1:4,1:3,"<=")

## now you should know what to do :)
## 1. write a procedure for a specific matrix, say mm;
## 2. write a function which generalises the procedure for any matrix.

#######################################—•°
save.image()

###############################################################################—•°
## 2.3. Lists
###############################################################################—•°

l0
l0[T]  ## recycling!
l0[c(T,F)]

## if you use [[]] with logicals then it works this way
l0[[T]]  ## content of just the FIRST element
l0[[F]]  ## ERROR
l0[[c(T,F)]]   ## ERROR
## so it's rather useless...


l2
l2[[6]][c(T,F,T)]

l2[[6]][c(F,F,T)]
l2[[6]][[c(F,F,T)]]    ## ERROR
l2[[6]][3]
l2[[6]][[3]]
l2[[6]][[3]][c(T,F)]    ## it's not a content
l2[[6]][[3]][[c(T,F)]]  ## ERROR

l2[[6]][[3]][[T]]       ## content of the first el. of the 3d el. of the 6th element of l2

#######################################—•°
save.image()

###############################################################################—•°
## 2.4. Data frames
###############################################################################—•°

df
df[T]
df[c(T,F)]   ## recycling results in 1st and 3d columns (elements of the list df)
df[,c(T,F)]  ## the same
## BUT
df[,c(F,T,F,F)]   ## only the secod column without dimensions, like
df[,2]            ## unlike
df[2]             ## which is like
df[c(F,T,F,F)]

###################—•°
## logicals are useful in selecting rows from data:

df[ df[,1] == "a"  , ]
df[ df[,1] == "b"  , ]

df[ df[,4] <= .5  , ]
df[ df[,3] , ]  ## 3d column is already logical

df[ df[,2] <= df[,4]*10+10 , ]

## THIS IS INTERESTING
df[F,]                ## empty data frame BUT the structure retained, i.e. the same set of columns and their names
## May be very useful !!!

#######################################—•°
save.image()

###################################################################################################—•°
## 3. Referencing elements by names
###################################################################################################—•°

###############################################################################—•°
## 3.0. REMARK on "" and ''
###############################################################################—•°
## Using "" (quotation mark) and '' (apostrophe) are completely interchangable!
## There's (almost) no difference between them.
## You may also use "" within '' and vice versa:
"to jest 'dziwne' jakieœ"
noquote("to jest 'dziwne' jakieœ")
cat("to jest 'dziwne' jakieœ"); cat("\n")
##
'a to ju¿ nie takie "dziwne" chyba'               ## notice \ (escape) at each " —
noquote('a to ju¿ nie takie "dziwne" chyba')
cat('a to ju¿ nie takie "dziwne" chyba'); cat('\n')
## if you wish to use "" within "" you must escape it
"musisz "uciec" mnie!"        ## ERROR
"musisz \"uciec\" mnie!"      ## OK
noquote("musisz \"uciec\" mnie!")
cat("musisz \"uciec\" mnie!"); cat("\n")
##
## When using "" within '' you don't have to escape it because it is done automaticaly.
## When using '' within "" you don't have to escape it at all — quotation marks are in this sense stronger then ''.
## And this is probably the only difference between them.
##
'musisz 'uciec' mnie!'        ## ERROR
'musisz \'uciec\' mnie!'      ## OK       ## notice that the outermost '' are changed for ""
noquote('musisz \'uciec\' mnie!')
cat('musisz \'uciec\' mnie!'); cat("\n")
#######################################—•°
## You may use "" or '' — whatever you wish — there are only slight differences
## when nesting one within the other.
###############################################################################—•°

###############################################################################—•°
## 3.1. Vectors (atomic) without dimensions
###############################################################################—•°

## Elements of vector can have names:
nn
names(nn)
attributes(nn)

(nn.names <- paste("name",seq_along(nn),sep="_"))
names(nn) <- nn.names
nn
names(nn)

## you may remove names:
names(nn) <- NULL
nn

   #######################################—•°
   ## You may have already noticed that the expression
   ##    some_property(obj) <- NULL
   ## is the way for deleting/removing any specific property of an object.
   ## This is also the way for removing specific elements of a list
   l2
   l2[3] <- NULL
   l2
   ## of a data frame
   df
   df[4] <- NULL
   df
   ################
   ## BUT NOT of a vector (atomic)
   xx
   dim(xx) <- NULL
   xx
   xx[1] <- NULL
   ## so that NOT for matrices
   mm[6,] <- NULL
   mm[,4] <- NULL
   ## and NOT for data frames indexed as matrices
   df[7,] <- NULL
   ################
      ##!!! WITH EXCEPTION OF COLUMNS !!!
      df[,3] <- NULL  ## THIS WORKS!!! ... :)
   ## Hence you CAN remove by  <- NULL
   ##  • columns of data frame, in both manners
   ##    df[k] <- NULL  or  df[,k] <- NULL
   ## BUT NOT
   ##  • rows of data frame
   ##  • rows or columns of an array
   ##  • in general — elements of atomic vector.
   #######################################—•°

## give names again
names(nn) <- nn.names
nn

## names of a vector are one of attributes of the vector
attributes(nn)       ## all attributes (but only one is present)
attr(nn,"names")     ## attribute called "names"

## notice that names are simply character vector
typeof(names(nn))

## names may be used to reference to elements of a vector
nn["name_1"]
nn[c("name_1","name_4")]

(names.sample <- sample(paste("name",1:3,sep="_"),20,replace=TRUE))
nn[names.sample]

#######################################—•°
## some useful application of names — lookup table
## i.e. converting one type of values into another
(ff <- sample(c("f","m","u"),20,replace=T))        ## some abbreviations (code)
(lookup <- c(m = "Male", f = "Female", u = NA))    ## and their meanings
lookup[ff]                                         ## uncoded
unname(lookup[ff])

(lookup2 <- c(m = 0, f = 1, u = NA))    ## or different code
lookup2[ff]                             ## uncoded
unname(lookup2[ff])                     ## as numbers
typeof(lookup2[ff])

(lookup3 <- c(m = 0L, f = 1L, u = NA))  ##!!!  L  gives integers rather then double  !!!
lookup3[ff]                             ## uncoded
unname(lookup3[ff])                     ## as numbers
typeof(lookup3[ff])                     ## integer

(lookup4 <- c(m = F, f = T, u = NA))    ## another possibility
lookup4[ff]                             ## uncoded
unname(lookup4[ff])                     ## as logical
typeof(lookup4[ff])



#######################################—•°
save.image()

###############################################################################—•°
## 3.2. Vectors (atomic) with dimensions (arrays, tables, matrices)
###############################################################################—•°

mm
class(mm)
names(mm)

## in case of matrices we use
colnames(mm)
rownames(mm)

colnames(mm) <- paste("col",1:ncol(mm),sep="_")
mm
colnames(mm)
attributes(mm)
attr(mm,"colnames")  ## NULL
attr(mm,"dimnames")  ## list of length 2
attr(mm,"dimnames")[[2]]   ## these are colnames

rownames(mm) <- paste("row",1:nrow(mm),sep="_")
mm
rownames(mm)
attributes(mm)
attr(mm,"rownames")  ## NULL
attr(mm,"dimnames")  ## list of length 2
attr(mm,"dimnames")[[1]]   ## these are rownames

## You may also give names to dimensions
names(attr(mm,"dimnames"))
names(attr(mm,"dimnames")) <- c("rows","columns")  ## the order is important!
names(attr(mm,"dimnames"))
attr(mm,"dimnames")
mm

## can you give names() to every element of matrix/array ?
(names(mm) <- paste0("el_",seq_along(mm)))
mm
attributes(mm)  ##

   ## let's do some experiment
   mm2 <- mm
   attributes(mm2)
   dim(mm2) <- NULL
   mm2
   attributes(mm2)     ## all attributes disapeared...

   class(mm)
   unclass(mm)
   class(unclass(mm))  ## hmm...  R is strange sometimes!

## Thus you can give names() to the matrix but it is useless.

#######################################—•°
save.image()

###############################################################################—•°
## 3.3. Lists
###############################################################################—•°

l0
names(l0) <- c("1k","1_2_3","first_letter","true or false","square")
l0
## Notice that if the name begins with a number then it is taken with `` (backticks).
## In general names of elements and object names cannot begin with a number.
## Backticks are very important: they play similar role to "" and '' but you may create non-standard names with them
## (and do some other things).

## [] and [[]] works the same way with names as with numbers
l0["1k"]    ## is a sublist of list consisting of only its first element (container)
l0[["1k"]]  ## is a content

l0[c("1k","true or false")]      ## is sensible
l0[[c("1k","true or false")]]    ## is nonsense   ERROR!

attributes(l0)
names(l0)

## names can be given at the moment of creating a list
l1 <- list(
     "first_entry" = 1:3
   , "entry_2" = letters[1:4]
   , "the last entry" = date()
)
l1
## notice the `` (backticks) around the last name — it contains space.

## "" are not necessary in this context
## (except nonstandard names — beginning with number or containing space or special character)
l1 <- list(
     first_entry = 1:3
   , entry_2 = letters[1:4]
   , "the last entry" = date()
)
l1


###############################################################################—•°
## 3.4. Data frames
###############################################################################—•°

(df <- data.frame( sample(letters[1:3],7,replace=TRUE), sample(7)+10, sample(c(T,F),7,replace=TRUE), runif(7) ))

names(df)
colnames(df)
   names(df)  ## the same
rownames(df)
attributes(df)

## In case of data frames rownames and colnames always exist — they are given automaticaly.
## For rows these are number of each row (but all names are charachters so these numbers are also characters,
## NOT inegers).
rownames(df); typeof(rownames(df))
as.integer(rownames(df))   ## now they are numbers

## colnames are taken from names of vectors of wich they are created, or if they were creaed via some formula
## (e.g. sample(x)) then the call to this formula is used as a name (while all "(" and ")"  are transformed to ".").
##
## In case if data frames  colnames  and  names  are synonyms.
##
## Notice that colnames() are written to the "names" attribute, while rownames() to the "row.names" attribute.
attr(df,"names")
attr(df,"row.names")
   typeof(attr(df,"row.names")) ## integers !!!
   ## BUT remember that
   rownames(df); typeof(rownames(df))
   ## another strange thing...

v1 <- sample(7)
v2 <- sample(letters[1:3],7,replace=TRUE)
v3 <- runif(7)

## (col)names taken from vector names
df2 <- data.frame(v1,v2,v3)
df2

## (col)names given directly at the moment of creating data frame
df3 <- data.frame( "vec1" = v1 , "vec2" = v2 , "vec3" = v3 )
df3
## You may not use "" around standard names
df3 <- data.frame( vec1 = v1 , vec2 = v2 , vec3 = v3 , "last column" = sample(c(T,F),7,replace=T))
df3
## We had to use "" around the last name (it contains a space) but the space was changed to . Pity...
## (col)names of data frames are NORMALISED — all special characters are replaced by .


## changing (col)names manually
names(df3) <- c("aa","bb","cc")
df3

## changing rownames manually
rownames(df3) <- paste0("row_",rownames(df3))
df3

#######################################—•°
## When working with big data frames then it is generally much safer
## to operate on (col)names rather then on integer positions of columns.
## Position may change, but really important is the fact that using names is more informative
## — it is easier to write and read code using names (if you are only consistent with using them).
#######################################—•°

df2[2]
df2[,2]
df2[[2]]
## in the same manner you may use names of columns
names(df2)
df2["v2"]
df2[["v2"]]
df2[,"v2"]
##
df2[c("v1","v3")]
df2[[c("v1","v3")]]    ## ERROR of course

## choosing rows
rownames(df2)
df2[1,]
df2["1",]
df2[1,"v2"]
df2[1,"v2",drop=FALSE]
df2["1","v2",drop=FALSE]

df2[1:2,"v2"]
df2[1:2,"v2",drop=FALSE]
df2["1:2","v2",drop=FALSE]          ## NA; there's no rowname "1:2"
df2[c("1","2"),"v2",drop=FALSE]     ## OK
df2[c("1","2","3","4","5"),"v2",drop=FALSE]    ## OK but that's very incovienient
df2[as.character(1:4),"v2",drop=FALSE]         ## little better

## There's no gain of using numbers as characters.
## But rownames may not be simply numbers.

rownames(df2) <- paste0("row_",sample(nrow(df2)))
df2
df2[1:3,]
df2[1,,drop=FALSE]
df2[2,,drop=FALSE]
df2["row_5",,drop=FALSE]

##
...

#######################################—•°
save.image()

###############################################################################—•°
## 3.5. Using $ operator with names
###############################################################################—•°

## For lists (hence also data frames) there is another way of addressing elements.
df2
df2$v1
## This is variant of using names, however not as character strings but in a form of language element called "name"...
## (R language consists of a number of elements having types like "name", "call", "expression", "function",
## "environment", ...)
## Notice that this is the same as
df2[,"v1"]
df2[["v1"]]
## hence we get directly to the content of a list's element.
## And we don't have to use "" what is convienient.

l0
l0$first_letter
## how to use non-standard names (beginning with number or having space or some special character like /, [, ], ...)?
## You CAN USE "" (or '') together with $ :
l0$"true or false"
l0$"1_2_3"
## but you can also use `` (backticks)
l0$`true or false`
l0$`1_2_3`


###############################################################################—•°
## EXAMPLE 3.1
###############################################################################—•°

colinfo <- function(datfram,colname){
   variable <- datfram[,colname]
   list(
        var_name = colname
      , length = length(variable)
      , typeof = typeof(variable)
      , summary = summary(variable)
      , object.size = object.size(variable)
   )
}

colinfo(df2,"v1")
colinfo(df2,"v2")
colinfo(df2,"v3")

## Notice that tere is no way of using $name within the function body as you don't know in advance what is the name.
## Thus referencing via $name is possible only when the name is fixed.

## Notice that output is a list, hence you may reference to its part in all the ways described above:
colinfo(df2,"v1")
colinfo(df2,"v1")$object.size
colinfo(df2,"v1")$"object.size"
colinfo(df2,"v1")["object.size"]
colinfo(df2,"v1")[["object.size"]]
colinfo(df2,"v1")[5]
colinfo(df2,"v1")[[5]]

colinfo(df2,1)
## Works too, but the entry "var_name" of the result returnes just the number
## (numeric position of the column in the data frame).
## How to mend it?

colinfo <- function(datfram,colname){
   datfram.names <- names(datfram)
   names(datfram.names) <- datfram.names    #!!!
   ##
   variable <- datfram[,colname]
   list(
        var_name = datfram.names[colname]   ## now it will work for  colname  either numeric or character
      , length = length(variable)
      , typeof = typeof(variable)
      , summary = summary(variable)
      , object.size = object.size(variable)
   )
}

colinfo(df2,1)     ## almost good but the name repeated (this is the name of the element of datfram.names)

## this is simple to correct
colinfo <- function(datfram,colname){
   datfram.names <- names(datfram)
   names(datfram.names) <- datfram.names    #!!!
   ##
   variable <- datfram[,colname]
   list(
        var_name = unname(datfram.names[colname])   ## unname()
      , length = length(variable)
      , typeof = typeof(variable)
      , summary = summary(variable)
      , object.size = object.size(variable)
   )
}

colinfo(df2,1)       ## that's OK!
colinfo(df2,"v1")    ## the same :)   OK!!!


#######################################—•°
## This is an example of how functions are built
## — by trials and errors!
#######################################—•°


#######################################—•°
## Write a function which prints colinfo() for all columns of a given data frame.

###############################################################################—•°
## 3.6. unname()
###############################################################################—•°
nn
unname(nn)
mm
unname(mm)
l0
unname(l0)
df
unname(df)   ## ooooh... This is danger — no names for variables!
df2
unname(df2) ## rownames remained!
            ## If they were removed they would have been created immediatly again in the form of integers 1, 2, ...


#######################################—•°
save.image()

###################################################################################################—•°