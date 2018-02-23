########################################################################################################################—•°
## R for complete beginners (by A.K.)
## start:2017-02-18; last:2017-02-25
########################################################################################################################—•°
########################################################################################################################—•°

########################################################################################################################—•°
## 02. Basic Data Structures
########################################################################################################################—•°

ls()
rm(list=ls())
setwd("D:/ROBOCZY/R/TutorialAK/02 Basic Data Structures/")

###################################################################################################—•°
## 1. Vectors in general
###################################################################################################—•°

## Basic data structure in R is vector.
## There are two types of it
##  1. atomic — all elements of the same type (e.g. all numbers, all characters (strings), all logical);
##     atomic vectors are generally referred to as just "vectors"...
a <- c(1,2,5)
a
is.atomic(a)
is.list(a)

typeof(a)

a <- c(1,2,"b")
a                 ## all elements must be of the same type thus they were coerced to the one type
                  ## (the more flexible, in this case character, as numbers may be safely coerced to character
                  ##  while letters cannot be transformed into digits)
is.atomic(a)
is.list(a)

typeof(a)

##  2. generic — elements may be of different types; such vectors are called "lists";
##     lists are formaly vectors but no one uses "vector" if they mean list (generic vector).
l <- list(1,2,"b")
l
is.atomic(l)
is.list(l)

typeof(l)  ## list !!!

## There is also
is.vector(a)
is.vector(l)
## but its meaning is that an object is a vector not having any attributes except 'names'.
## Not very useful; in fact not useful at all :)
## Attributes are some properties of any R object, names are one of many standard attributes while user may define
## any attribute they wish to.
## We'll learn about attributes and names later.


###################################################################################################—•°
## 2. Vectors (atomic)
###################################################################################################—•°

###############################################################################—•°
## 2.1. Vectors without dimensions
###############################################################################—•°
a = 1
a
is.atomic(a)

a<-0
a
"a"=3   ##
a
## BUT
"a"
##
## you may assign anything
a<-"b"
a
a<-TRUE
a
a<-NA    ## NA (Not Availabe i.e. unknown value as NULL in SQL)
typeof(a)
a<-NULL  ##! this is not the same as NULL in SQL!!!
         ## This is rather empty space (null, void, nothing) in memory then unknown value.
a
typeof(a)

## c() - creating longer vectors
c(1,3,5)   ## just printed on the screen - you cannot do anything more with it
## it's better to assign to some name
a <- c(1,3,7)
a
## if you wish to see the output immediately use parenthesis
(a <- c(1,3,7))
a
typeof(a)
## now a is at your command
a*2
rev(a)
## you may even remove it
rm(a)  ## bye...
a      ## :(

## ...and then resurrect it
(a <- c(1,2,3,4,5) )      ## brave new a!
(a <- 1:5)
is.atomic(a)
is.list(a)

## random value
(b <- sample(5))
(b <- sample(1:5))      ## the same i.e. random order of 1:5
(b <- sample(1:5,3) )   ## only 3 elements from the set {1,2,3,4,5}
(b <- sample(1:5,7) )   ## ERROR. By default replace=FALSE what means sampling is made without replacement
(b <- sample(1:5,7,replace=TRUE))  ## some elements repeated

(dd <- sample(c("a","b","c")))
(dd <- sample(c("a","b","c"),10,replace=TRUE))
table(dd)

ll <- sample(c(T,F),10,TRUE)
table(ll)

table(dd,ll)   ## figure out what's going on here!

pp <- sample(c(-1,1),10,TRUE)
table(pp)

table(dd,ll,pp)
ftable(dd,ll,pp)   ## flat table

(dat0 <- cbind(dd,ll,pp))  ## ugly...
table(dat0)             ## ...and data not recognised as separate vectors...

   typeof(dat0)
   is.atomic(dat0)
   is.list(dat0)

(dat <- data.frame(dd,ll,pp))
(tt <- table(dat))                      ## BEAUTY !!!
(ft <- ftable(dat))

## data.frame  is the most important data object in R !!!
## It is not a vector and not a matrix. It is list of vectors all having the same length.

   typeof(dat)    ##!!! list !!!
   is.atomic(dat)
   is.list(dat)

###############################################################################—•°
## 2.2. Vector with dimensions
###############################################################################—•°

#######################################—•°
## Matrices

(m1 <- matrix(1:12,nrow=3))
   matrix(1:12,ncol=4)       ## the same

   is.atomic(m1)
   is.list(m1)

(m2 <- matrix(1:12,nrow=3,byrow=T))

dim(m1)      ## 2 dim
dim(a)       ## NULL dim
dim(tt)      ## 3 dim

   is.atomic(tt)

#######################################—•°
## Arrays
(a1 <- array(1:24,dim=c(3,4,2)))  ## rows, columns, pages
typeof(a1)
dim(a1)
   is.atomic(a1)
   is.list(a1)

###############################################################################—•°
## 2.3. Basic properties of vectors & other objects
###############################################################################—•°

typeof(a)
length(a)
dim(a)
nrow(a)
ncol(a)
#
names(a)
colnames(a)
rownames(a)
#
attributes(a)
str(a)
summary(a)

## do it for all objects already created ...

## ... especially for  dat0 and dat  and again compare the result of table() for both

## checking types/classes
is.numeric(a)
   is.integer(a)
   is.double(a)   ## real numbers == double precision
is.character(a)
is.logical(a)     ## logical vectors described below
is.data.frame(a)
is.table(a)
is.array(a)

is.vector(a)   ##!!! it means something different then you might think; more on this later on;
is.atomic(a)
is.list(a)
## is.that.all(???)

...

#######################################—•°
## R is procedural language BUT it is also object oriented i.e. objects may be of some "class(es)".
##
a
class(a)    ## class()
typeof(a)
str(a)
b
class(b) ; typeof(b) ; str(b)
dd
class(dd) ; typeof(dd)
...


class(dat0) ; typeof(dat0)
is.atomic(dat0)
is.list(dat0)
str(dat0)
attributes(dat0)

class(dat) ; typeof(dat)
is.atomic(dat)
is.list(dat)
str(dat)
attributes(dat)

class(tt) ; typeof(tt)
is.atomic(tt)
is.list(tt)
str(tt)
attributes(tt)

class(m1) ; typeof(m1)
is.atomic(m1)
is.list(m1)
str(m1)
attributes(m1)

class(a1) ; typeof(a1)
is.atomic(a1)
is.list(a1)
str(a1)
attributes(a1)

## The class of an object influences the bahaviour of the functions operating on them.

summary(dat0)
summary(dat)
summary(tt)
summary(m1)
summary(a1)


#######################################—•°
## unclass() - removing class of an object
(dat.uc <- unclass(dat))  ## data.frame reduced to list (more about lists later on)
length(dat.uc)

summary(unclass(dat0))
summary(unclass(dat))
summary(unclass(tt))
summary(unclass(m1))
summary(unclass(a1))

## check all other properties
...

###############################################################################—•°
## 2.4. Data frames vs matrices/arrays/tables
###############################################################################—•°

## array (matrix, table) is a vector with additional attribute "dim"
m1
attr(m1,"dim")

a1
attr(a1,"dim")

tt
attr(tt,"dim")

length(m1)  ## it is simply number of elements of m1
...

## array and table may have many dimensions while matrix only 2
mt <- m1
dim(mt)
class(mt)
## we may change dimensions by changing value of a "dim" attribute
dim(mt) <- c(2,2,3)
mt
class(mt)    ##! it's no longer a "matrix" - mattrix may have only 2 dimensions

## Thus array is the most general class while matrix is its special subclass (only 2 dimensions).
## The purpose of having this special class is that on the set of matrices
## there are defined some mathematical operations like multiplication or addition
m1
t(m1)  ## transposition
m1%*%t(m1) ## multiplication of matrices (not always possible!)
##  more on this later...

## addition
m1 + m1
m1 + t(m1)    ## ERROR !!! why?

## addition is also possible for arrays
...

##!!! all elements of array must be of the same type  !!!
(ms <- matrix(c(1,2,"a","b"),ncol=2))
class(ms); typeof(ms)

## different way of creating matrices:
xx <- 1:4
yy <- 5:8
(mxy.c <- cbind(xx,yy))   ## column bind
class(mxy.c) ; typeof(mxy.c)
## or
(mxy.r <- rbind(xx,yy))   ## row bind
class(mxy.r)

## try to add another column but of different type
ss <- c("a","b","c","d")
(mxy.c2 <- cbind(mxy.c,ss))
class(mxy.c2) ; typeof(mxy.c2)
## all elements of matrix must of the same type...

##
## So, how to collect data of different types?
## Use data frames:
(df1 <- data.frame(xx,yy,ss))
class(df1); typeof(df1)

## now compare
length(mxy.c2)
length(df1)        ## Why?
   unclass(df1)
   typeof(unclass(df1))      ##!!! data frame is a list (having all elements of the same length) !!!
summary(mxy.c2)
   str(mxy.c2)
summary(df1)
   str(df1)        ## what is factor? for a while you may treat it as character
...  ## check all possible properties of these two objects


###############################################################################—•°
## 2.5. Types of vectors and ways of creating them
###############################################################################—•°

###########################################################—•°
## 2.5.1. Sequences
###########################################################—•°

1:3
1:3*2
1:(3*2)
1:3+1

1:3*2 - 1

1:3/2
1:(3/2)
1:(5/2)

seq(1,10,2)

d
seq_along(d)
1:length(d)

seq_len(10)      ## it's faster then 1:10 (but dont't bother - you'll never see the difference)

rep(1:3,2)
rep(1:3,each=2)
rep(1:3,length=7)
rep(1:3,each=2,length=7)
rep(1:3,each=2,length=13)
rep(1:3,length=13)

## you may give each element a distinct number of replications
rep(1:3,times=c(3,2,4))    ## 1 is replicated 3 times, 2 — 2 times and 3 — 4 times
rep(1:3,c(3,2,4))          ## the same
rep(1:3,times=c(3,2,4),length=13)  ## only length works :(

rep(letters[1:3],each=2,length=8)

seq(1,10)
seq(1,10,step=2)
seq(1,10,3)
seq(1,10,4)

seq(0,1)
seq(0,1,length=3)
seq(0,1,length=10) ## be carefull!!!
seq(0,1,length=11) ## :)
## the same as
seq(0,1,.1)
## but it's easir (and more accurate) to
seq(0,1,length=7)
## then
seq(0,1,.1666667)   ## Where's the 1.0???

   #######################################—•°
   ## RULE OF RECYCLING !!!
   ## It is extremaly important to remember it!
   #######################################—•°

   1:3 + 1
   1:3 + 1:2
   1:9 + 1:2
   1:9 + 1:5

   1:3 * 1:2
   ...

   ## matrices
   v <- 1:14
   (m3 <- matrix(v,nrow=4))  ## nrow is not a divisor of length(v) thus v was recycled to get the "proper" lenght
   ##!!! This is convienient BUT may couse problems while searching for bug in a program!

   m1 + 1     ## 1 recycled to the length(m1)
   m1 + 0:1   ## 0:1 recycled to the length(m1)
   m1 * 2
   m1 * c(-1,2)
   #######################################—•°

###########################################################—•°
## 2.5.2. Logicals
###########################################################—•°

lg <- c(T,F,T,T,F)
typeof(lg)
is.logical(lg)

as.numeric(lg)
as.logical(c(1,0,0,1,1))

b
dd

b == 5
b[b==5]
b == "5"   ## !!!  type coersion !!! (if possible)
b == "c"

b<4
b[b<4]

b!=5
b[b!=5]
!b==5   ## double =
!b=5    ## ERROR

dd
table(dd)
dd[dd=="a"]
dd[dd!="a"]

c(T,T,F,F) & c(T,F,T,F)    ## AND
c(T,T,F,F) | c(T,F,T,F)    ## OR

c(T,T,F,F) * c(T,F,T,F)    ## AND
c(T,T,F,F) + c(T,F,T,F)    ## !
(c(T,T,F,F) + c(T,F,T,F)) > 0

c(T,T,F,F) && c(T,F,T,F)    ## AND collapsed to one value (what walue?)
c(F,F,T,T) && c(F,T,F,T)
c(T,T,F,F) || c(T,F,T,F)    ## OR  collapsed to one value (what walue?)



###########################################################—•°
## 2.5.3. Strings
###########################################################—•°


s1 <- "hop"
s2 <- "sa"
s3 <- "SA"
paste(s1,s2)
paste(s1,s2,s3)
paste(s1,s2,s3,sep="")
paste(s1,s2,s3,sep="-")
paste(s1,s2,s3,sep="\n")

cat(paste(s1,s2,s3,sep="-"))
cat(paste(s1,s2,s3,sep="\n"))
cat("\n")
cat(paste(s1,s2,s3,sep="\n"))
cat("\n")
cat(paste(s1,s2,s3,sep="\n"));cat("\n")   ## this is the most elegant !

paste0(s1,s2)  ## default sep=""

(ss<-c(s1,s2,s3))
length(ss)
paste(ss)         ## nothing...
paste(ss,collapse="")
paste(ss,collapse=" ")

paste(ss,1:3)
paste(ss,1:3,sep="-")
paste0(ss,1:3)

## rule of recycling:
paste(ss,1:2)
paste(ss,1:4)
paste(ss,1:10)

paste(letters[1:4],1:10)

paste(paste(letters[1:4],1:10),collapse=" - ")

## and so on ...

strsplit("abracadabra",split="")
strsplit("abracadabra",split="a")
strsplit("abracadabra",split="d")

#######################################—•°
## example

## suppose we got the character vector of unknown length
sr <- rep("s",sample(5:10,1))
paste0(sr,seq_along(sr))

## we can also generate such a vector (having random length but enumerated) directly
paste0("s",1:sample(5:10,1))


###################################################################################################—•°
## 3. Lists (generic vectors)
###################################################################################################—•°

#######################################—•°
## list is a collection of anything
a
b
ss

l0 <- list(a,b,ss)
l0
length(l0)  ## how many elemnts list contains
class(l0)
typeof(l0)
str(l0)
## check other properties

l1 <- list(tt,m1,df1)
l1

#######################################—•°
## joining lists (combining) together
(l2 <- c(l0,l1))
length(l2)
   str(l2)

##!!! BUT
(l3 <- list(l0,l1))
length(l3)
   str(l3)

##!!!  READ IT ALL VERY CAREFULLY !!!

## combining list with vector
c(l0,1)     ## 1 as 4th element
list(l0,1)  ## l0 and 1 are the two elements of a list

c(l0,1:2)     ## 1 as 4th element, 2 as 5th element
list(l0,1:2)  ## l0 and 1:2 are the two elements of a list

c(l0,list(1:2))     ## 1:2 as 4th element
list(I(l0),list(1:2))  ## l0 and list(1:2) are the two elements of a list

##!!! compare once again
list(l0,1:2)            ## l0 and  1:2        are the two elements of a list
list(I(l0),list(1:2))   ## l0 and  list(1:2)  are the two elements of a list


#######################################—•°
## list() may be used to grow trees

l11<-"leaf11"
l12<-"leaf12"
l13<-"leaf13"
branch1<-list(l11,l12,l13)

l21<-"leaf21"
l22<-"leaf22"
double_leaf <- paste0("leaf2_",3:4)

sub_branch2 <- list("cherry1","cherry2")
branch2<-list(l21,l22,sub_branch2)

(tree <- list(branch1,branch2))
str(tree)

(orchard <- list(tree,tree,tree) )
str(orchard)

## What is this for?
## In general for creating data structures of arbitrary complexity.
## This is very important!
## Remember that
##    computer program  =  algorithms  +  data structures
## thus programming is not only
##    inventing algorithms
## but also
##    designing data structures
## (and lists are the basic tool for creating them).
##
## In Object-Oriented Programming data structures having common design are called "classes".
## Class of an object determines how data are processed by the function:
## different classes are treated differently by the same function and may give different output.
## We've already seen it in the example of summary().


###############################################################################—•°
## Don't forget to write results:
getwd()  ## check the working directory and
save.image()
###############################################################################—•°


###################################################################################################—•°
## The next file:
## 03. Accessing elements of lists, vectors, matrices, tables, arrays, data.frames, etc.
###################################################################################################—•°
## But before you go further...
###################################################################################################—•°

###################################################################################################—•°
## ...have some dessert: AN EXPERIMENT!
###################################################################################################—•°
sample(0:1,100,replace=TRUE)
replicate(10,sample(0:1,100,replace=TRUE))   ## sampling repeated 10 times, result returned to matrix
                                             ## - each column is one replication (experiment)

## this is more interesting
replicate(10,mean(sample(0:1,10,replace=TRUE)))
replicate(10,mean(sample(0:1,100,replace=TRUE)))
replicate(10,mean(sample(0:1,1000,replace=TRUE)))

## this is even more interesting
## standard deviation of the sample mean
sd(replicate(10,mean(sample(0:1,10,replace=TRUE))))
sd(replicate(10,mean(sample(0:1,100,replace=TRUE))))
sd(replicate(10,mean(sample(0:1,1000,replace=TRUE))))

## still to much repetition
for(k in 1:4){
   sd(replicate(10,mean(sample(0:1,10^k,replace=TRUE))))
}
## Where's result???

## use print()
for(k in 1:4){
   print(sd(replicate(10,mean(sample(0:1,10^k,replace=TRUE)))))
}

## it's better to remember result
(result <- numeric(0))
for(k in 1:4){
   result[k]<-sd(replicate(10,mean(sample(0:1,10^k,replace=TRUE))))
}
result
plot(result,xlab="power of 10 for sample size",ylab="standard deviation of the sample mean")

#######################################—•°
## Conclusion: the bigger sample the less variation of the (sample) mean.
## This is called
##    The Law Of Large Numbers (LLN)
## the basic theorem of the Statistics.
## The more data we have, the more reliable are conclusions drawn from them and so is our knowledge.
#######################################—•°

#######################################—•°
## It is very easy to parametrise this experiment to gain some flexibility.

set <- 0:1   ## set we sample from
K <- 4       ## maximum power of 10 for the sample size
nrpl <- 10    ## number of replications (repetitions of an experiment)

(result <- numeric(0))
for(k in 1:K){
   result[k]<-sd(replicate(nrpl,mean(sample(set,10^k,replace=TRUE))))
}
result
   plot(result,xlab="power of 10 for sample size",ylab="standard deviation of the sample mean")

   ####################################—•°
   ## plot() by default shows only points
   ## type = 'p' — points (default option)
   plot(result,type='p' ,xlab="power of 10 for sample size",ylab="standard deviation of the sample mean")

   ## type = 'l' — lines
   plot(result,type='l' ,xlab="power of 10 for sample size",ylab="standard deviation of the sample mean")

   ## type = 'b' — both
   plot(result,type='b' ,xlab="power of 10 for sample size",ylab="standard deviation of the sample mean")
   ####################################—•°

#######################################—•°
## But the best (most flexible) solution is to encode the experiment into the function.
## This what we mean by "programming"!
experiment <- function(nrpl,K,base=10,set=0:1){ ## base  and  set  are given default values
   (result <- numeric(0))
   for(k in 1:K){
      result[k]<-sd(replicate(nrp,mean(sample(set,base^k,replace=TRUE))))
   }
   plot(result,type='b', xlab=paste0("power of ",base," for sample size")
                       , ylab="standard deviation of the sample mean")
   title(paste0("sd for the sample mean from the set {",paste(set,collapse=", "),"}"))  ##!!!
   result   ##!!! functions return the last line of code (if there is no return(result) earlier)  !!!
}

experiment(10,4)
experiment(10,6)
experiment(10,6,5)
experiment(10,10,5)  ## it will take a moment
experiment(10,6,5,-1:1)  ## changing the set from which we sample

   ####################################—•°
   ## if you don't remember the position of the parameter then use its name
   experiment(10,6,set=-1:1)  ## changing the 'set' from which we sample, but 'base' is left default
   experiment(10,6,base=3)    ## 'base' changed but 'set' is left default
   ## you may use name of any argument and then their position doesn't matter
   experiment(base=4,nrpl=20,set=c(10,2),K=7)
   ## but if you don't use the name of an argument then you must use it in the right position:
   experiment(-1:1)   ## ERROR!!!
   ####################################—•°


## There are countless ways for generalising this experiment.
## Try yourself!!!


## AND THEN...
##
## ...do it in Excel :)

ls()
ls.str()     ## wow!

save.image() ##!!!!

###################################################################################################—•°
