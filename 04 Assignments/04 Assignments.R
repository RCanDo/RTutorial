########################################################################################################################—•°
## R for complete beginners (by A.K.)
## start:2017-02-24; last:2017-02-25
########################################################################################################################—•°
########################################################################################################################—•°

########################################################################################################################—•°
## 04. Assigning and subassigning
########################################################################################################################—•°

rm(list=ls())   ## clearing environment

setwd("D:/ROBOCZY/R/TutorialAK/04 Assignments/")
load(".RData")  ## if you have saved environment earlier and you want to restore it

###################################################################################################—•°
## 1. Basic assignment expressions
###################################################################################################—•°

###############################################################################—•°
## 1.1 <-, =
###############################################################################—•°

## We've already made assignments, you do it every time you create a new object:
a <- sqrt(2)
a
## or little shorter
b = sqrt(3)
b
## i.e. <- and = are the operators of assignment.
## It is recommended to use <- rather then = at least within functions you will share with other users.
## It is beacause = is also used to set values of functions parameters when you call them, e.g.
sample(7,4,replace=TRUE)
##
## Notice that the following
plot(1:10,sample(5,10,replace=TRUE),type="b")
## is the same as
plot(x=1:10,y=sample(5,10,replace=TRUE),type="b")
## Does x and y exist in the environment?
x
y
   ## By the way — for checking existence of object use exists()
   exists("x")
   exists("y")
   ## this way you don't get error when object doesn't exists and you can use it
   ## in conditional statments like if...else... or switch().

## Compare with:
plot(x<-1:10,y<-sample(5,10,replace=TRUE),type="b")
## what is exactly the same as the previous plot but now
x
y
## we've created two vectors "on the fly" i.e. while executing some function (but not as a result of this function).
## So <- and = are not identical in meaning. Although it's hard to find other differences this one is crucial.

#######################################—•°
## You should be aware of the fact that <- is just a shorthand for
##   assign("name",value)
## See the ch. 2. below in this file.
#######################################—•°

###############################################################################—•°
## 1.2. Adding, removing and changing values of vectors.
###############################################################################—•°

## Now we are more intersted in adding and changing values to vectors and lists.
## This is possible with <- (or =).
ls()
a
length(a)
a[2] <- sqrt(3)
a
a[5] <- sqrt(7)
a     ## we have ommited indices 4, 5 while creating 5th element thus they are set to NA
      ## — more important is the fact that they are added automaticaly.

## removing element
a[5] <- NULL  ## ERROR!  You cannot do it with atomic vectors (but i's possible with lists).

## Thus the only way of removing elements from atomic vector is to recreate the whole vector
a <- a[-5]
a

a[3] <- sqrt(5)
a

a[4:6] <- sqrt(c(6,7,8))
a

## Notice that if there is not enough values passed to fill the indicated space then
a[7:15] <- 7:10
## THE RULE OF RECYCLILNG WORKS.

## You can always delete some values by NA
a[a>3] <- NA
a
## but respective entries of a vector are still present.
## Removing them is possible only by recreating the whole vector
a <- a[!is.na(a)]
a

   ####################################—•°
   ## Checking for NA, NaN, Inf, NULL and existence of an object.
   ####################################—•°
   ## As in other languages, e.g. SQL, checking for unknown values is done in a different way
   ## then comparing with known value.
   ## In SQL you use  x IS NULL, in R  is.na(value)
   x <- 2
   is.na(x)
   ##
   x <- NA
   is.na(x)
   ##
   ## BUT there are other types of unknown values
   x <- 2/0   ## we'd have ERROR in SQL!  R is wiser — it's infinity!
   is.na(x)
   x
   is.finite(x)
   ##
   x <- log(-1)  ## NaN (Not a Number) in R; in SQL ERROR...
   x
   is.nan(x)
   is.na(x)      ## NaN is a special type of NA
   x <- NA
   is.nan(x)     ## while NA is not a NaN (in general)
   ##
   x <- NULL
   x
   is.null(x)
   ##
   exists("x")    ##!!! it is NULL but still exists!!!
   rm(x)
   exists("x")
   ####################################—•°

## Obviously you may remove elements immediately, without replacing them with NA first
a[7:15] <- 7:10
a
a <- a[a<3]
a

#######################################—•°
## combining (concatenating) vectors
a
b <- 11:14
c(a,b)
## but you may change a this way
a<-c(a,b)
a
## how to return to the previuos state of a?
idx <- 1:(length(a)-length(b))
a <- a[idx]
## or
idx <- (length(a)-length(b)+1):length(a)  ## it doesn't work if you run the previous
a<-a[-idx]
a

#######################################—•°
## Changing the values of existing elements is simple:
a[1] <- 1
a
a[1:2] <- 1
a
a[1:2] <- 2:3
a
a[1:5] <- c(3,5)   ## recycling rule
a

## assignment to all elements but one
a[-1] <- sqrt(c(3,5,6))
a
## all but two
a[-c(1,3)] <- c(2,4:6)^2

## If you try to do assgnments with more elements then there is place you have chosen for them
a[-c(1,3)] <- a^2   ## NOT Error, only Warning, but what has happend here?
a
##! So things which are possible may be sometimes very confusing and it's better to avoid such situations!
##
## KEEP CONTROL OF WHAT'S GOING ON! Especially when indexing and assigning.



#######################################—•°
## How it works for vectors with dimensions i.e. arrays/matrices/tables ?
##
## Check it alone! It's a straightforward generalisation. Have fun! :)
...

#######################################—•°
save.image()

###############################################################################—•°
## 1.2. Adding, removing and changing values of lists.
###############################################################################—•°

ll <- list( first = "a"
         , second = 1:5
         , third = matrix(1:12,nrow=3)
         , fourth = letters[1:4]
         )
ll

## adding element
ll["fourth"] = function(x)sqrt(x)   ## ERROR!
## You cannot replace list's element (a container) with a function.
## You may only put a function into a container (if it not exists will be created on the fly)
ll[["fourth"]] = function(x)sqrt(x)
ll

ll[["fifth"]] = function(x)x^(1/3)
ll

## Try with a simple vector
ll[["fifth"]] = 11:15     ## OK
ll
## but if you use []
ll["fifth"] = 11:15    ## NOT ERROR...
ll                     ## but only first element of a vector was taken!
## It's certainly not what you'd expect!
## So again:
## KEEP CONTROL OF WHAT'S GOING ON! Especially when indexing and assigning.
## A counsel for the beginners:
## Don't trust yourself — always check on a simple example before using non-trivial assignments.
##

## Do something even more tricky

( datfram <- data.frame( v1=sample(7), v2=sample(letters[1:2],7,replace=T), v3=runif(7) ) )

ll["sixth"] <- datfram
ll        ## ????
## We wanted to add data.frame as the 6th element of the list but we've got added only its first column...
## Why?

## Try again, but remove the 6th first.
## With lists, you may use <-NULL to get rid of an element of the list
ll["sixth"] <- NULL
ll

## Remember that data.fame is a list!
## Hence using [] we attempted to add/replace one container (6th) with 3 (length(datfram)).
## But we wanted to put the whole data frame into one container (train of 3 wagons into one wagon),
## thus we need to use [[]]
ll[["sixth"]] <- datfram
ll
## Now it's OK! You must use [[]] in such situations.

ll["sixth"] <- NULL
ll

## see the following
c(ll,datfram)
## Every element (column) of a datfram was added to the list as a separate element of this list
## — the two lists were joined/combined — two trains joined into one.

## compare with
(lldf <- list(ll,datfram))
str(lldf)

   ## Read carefully, think it over and REMEMBER the difference between
   c(list1,list2)
   ## and
   list(list1,list2)


#######################################—•°
## removing elements of the list
ll["first"] <- NULL
ll
ll[1] <- NULL
ll
## moreover
ll[["third"]] <- NULL
ll

## thus in this context [] and [[]] works in the same way.
## but using [] you may remove more then one element
ll[1:2] <- NULL
ll

## At the end we have a data frame but within a container.
## Get rid of it:
unlist(ll)    ## ooops...
## unlist() destroys the whole structure — not only outer list (typeof(ll)) but also inner list (typof(datfram)).
## It's better to write simply:
ll[[1]]

## How to remove column of a data frame?
ll[[1]][2] <- NULL
ll[[1]]
ll
## So we have removed column of a data frame, and by the way we heve made a double reference
## i.e. to the element of the element — we've changed the object within the object.
## But
datfram
## still exists in its original state.


#######################################—•°
## It's virtually impossible to exemplify all the possible problems you may encounter in the course of you work.
## Try now to do some experiments.
## Create lists and vectors of different types, try to combine them, put one into another, remove some parts of them
## via names, numeric positions or logicals...
## Have fun!
## If you are lazy don't worry — sooner or later you will come across all these problems :)
## If you only stay with R...

#######################################—•°
save.image()


###################################################################################################—•°
## 2. assign(), get(), exists()
###################################################################################################—•°

## You should be aware of the fact that <- is just a shorthand for
assign("d",sqrt(5))
d
## The reverse of assign() is get()
get("d")
## what is the same as
d
## but you use "" i.e. a character with name of an object in need — this is very useful within functions when
## you don't know in advance what is the name of desired object.
## This is exactly the same situation as with accessing lists elements — you may use
##    list$element  or  list[["element"]].
## In the latter case you may use variable with the name of element in need while in the former you must know in advance
## what is the name of desired element (see the example of the function at the end of file 03).

## More about assign(), get(), exists() in the file about functions and environments.
## If you already know that there are things in R like environments
## which are organized in a specific way and some of them (package environments) may be listed with
search()
## then you should also know that all these 3 functions (and many other, e.g. ls())
## have options 'pos' or 'where' or 'envir' indicating in which environment to look for an object with a given name
## or where to create it. Check it with help.
## (In Tinn-R try using Ctrl+d within brackets of the function to see all options of the function.)

###############################################################################—•°
## EXAMPLE 2.1
## Nontheles we may write a simple functions which present the usefulness of get() and assign(),
## i.e. using names of objects through character variable
## rather then directly pure names (in a sense of language element).

ls_print <- function(){
   for( nam in ls(pos=1) ){   ## pos=1 means the first position on the search() list
                              ## i.e. .GlobalEnv i.e. the working environment.
                              ## Thus we want names of all objects BUT only from .GlobalEnv
      cat(nam,"\n")        ## adding new line
      print( get(nam, pos=1, inherits=FALSE) )  ## pos=1 as above,
                           ## inherits=FALSE means that get() WILL NOT search for an object with the given name
                           ## anywhere beyond environment given in pos (.GlobalEnv in this case).
                           ## Default for inherits is TRUE thus lookup for an object is made
                           ## through the whole search() path (in the same order).
   }
}
## Notice also that we had to use print() to have anything printed on the screen beacuse in general
## only output of the function is printed i.e. last line of the body or a statement within return().

ls_print()
#######################################—•°
## Could you write this function without get()?
## You may not know BUT the answer is: NO! :)
#######################################—•°

## It's very easy to generalize the function to print all objects from any environment on the search() path.

ls_print <- function(pos=1){   ## by default we want environment with pos=1 i.e. .GlobalEnv
   for( nam in ls(pos=pos) ){
      cat(nam,"\n") ; print( get(nam, pos=pos, inherits=FALSE) ) ; cat("\n")
   }
}

ls_print()
ls_print(1)    ## the same — pos=1 is default
ls_print(2)    ## all staff within pos=2 i.e.
   search()[2]  ## from  "package:TinnRcom"
## As you see this function is not very useful because if you print all from the entire environment you are lost...
## It's hard to find anything and even realize how many objects are in the environment.
## E.g. bodies of functions are printed while we'd like to know only basic informations about an object.

## The more useful is printing only summary()
ls_summary <- function(pos=1){
   for( nam in ls(pos=pos) ){
      cat(nam,"\n") ; print( summary(get(nam, pos=pos, inherits=FALSE)) ) ; cat("\n")
   }
}

ls_summary()
ls_summary(1)    ## the same — pos=1 is default
   ## ooops... ERROR for function ls_print() — you cannot get the summary from function (closure)...

## We MUST use if...else... statement
ls_summary <- function(pos=1){
   for( nam in ls(pos=pos) ){
      cat(nam,"\n")
      obj <- get(nam, pos=pos, inherits=FALSE)
      if(is.function(obj)){
         print( typeof(obj) )    ## for functions we'll get only their type (i.e. always "closure")
      }else{
         print( summary(obj) )
      }
      cat("\n")
   }
}

ls_summary()      ## typeof() == "closure"  means this is function.
                  ## hat is closure? See the ongoing chapter about functions :)
ls_summary(1)
ls_summary(2)

search()
ls_summary("package:datasets")   ## WOW!!! The name of environment may be used too! :)
## but the output is still huge — there is quite a number of data frames in "package:datasets" and some of them are big.

## do another function
ls_str <- function(pos=1){
   for( nam in ls(pos=pos) ){
      cat(nam,"\n")
      obj <- get(nam, pos=pos, inherits=FALSE)
      if(is.function(obj)){
         print( typeof(obj) )
      }else{
         print( str(obj) )
      }
      cat("\n")
   }
}

ls_str()
ls_str("package:datasets")    ## much better

## but
ls.str()
ls.str(pos="package:datasets")   ## our function is little prettier as it separates objects with empty line


###############################################################################—•°
## EXAMPLE 1.2
## Let's do the function which for given data frame returns all its columns to environment as separate vectors
## under their names.

## 1.2.1
variables_from_df <- function(datfram,pos=1){
   for(nam in names(iris)){
      assign(nam,iris[[nam]],pos=pos)
   }
   message("The following variables were returned to environment (pos=",pos,
   "):\n",paste(names(iris),collapse=", "),"\n",sep="")
}

summary(iris) ; head(iris)  ## 'iris' data resides in "package:datasets"

variables_from_df(iris)
Sepal.Length
Sepal.Width
Species
ls_str()

#######################################—•°
## Could you write this function without assign()?
## Again: NO! :)
#######################################—•°

## do it again
variables_from_df(iris)
## There is no message that objects with the same names as columns of data frame already exists in the environment.
## Thus the objects from env. are overwritten with variables from data frame what is rather dangerous!
## You may accidentally overwrite important data in the env.
## Let's do something interactive

## 1.2.2
variables_from_df <- function(datfram,pos=1){
   returned <- character(0)
   for(nam in names(iris)){
      if(exists(nam,where=pos)){       ## in exists() there is 'where' option which means the same as 'pos'
         rl <- readline(prompt=paste0(nam," already exists. Overwrite it? [0/1]: "))  ## always character
         # print(rl)
         # print(as.numeric(rl))    ## you may uncomment it to see what rl is
         if( as.numeric(rl) ){      ## remember that 0 is interpreted as FALSE while 1 as TRUE
                                    ## CHECK how other numbers are interpreted by  as.logical(number)
            assign(nam,iris[[nam]],pos=pos)
            returned <- c(returned,nam)
         }
      }else{
         assign(nam,iris[[nam]],pos=pos)
         returned <- c(returned,nam)
      }
   }
   message("The following variables were returned to environment (pos=",pos,
   "):\n",paste(returned,collapse=", "),"\n",sep="")
}

variables_from_df(iris)
## Almost great BUT it is up to user give a sensible answer to the command line (0 or 1 i.e. No or Yes).
## Correct it using another loop called repeat{ }

## 1.2.3
variables_from_df <- function(datfram,pos=1){
   returned <- character(0)
   for(nam in names(iris)){
      if(exists(nam,where=pos)){       ## in exists() there is 'where' option which means the same as 'pos'
         rl <- ""
         while( ! rl %in% c("0","1") ){
            rl <- readline(prompt=paste0(nam," already exists. Overwrite it? [0/1]: ")) ## always character
            ##  WHY  as.numeric( readline(prompt=paste0(nam," already exists. Overwrite it? [0/1]: ")) )
            ##  IS NOT A GOOD IDEA ??? (thus we postponed changing type of to if() )
            ##  This is really important question!
         }
         if( as.numeric(rl) ){
            assign(nam,iris[[nam]],pos=pos)
            returned <- c(returned,nam)
         }
      }else{
         assign(nam,iris[[nam]],pos=pos)
         returned <- c(returned,nam)
      }
   }
   message("The following variables were returned to environment (pos=",pos,
   "):\n",paste(returned,collapse=", "),"\n",sep="")
}

variables_from_df(iris)   ## It's OK!!!

   #######################################—•°
   ## setA %in% setB   checks which elements of setA are in setB
   setB <- letters[1:3]
   "a" %in% setB
   "d" %in% setB
   0 %in% setB
   TRUE %in% setB
   (function(x){x^2}) %in% setB  ## ERROR... This not so simple with functions,
                                 ## but it's also rather peculiar statement to check...

   ## for setA having more elements we have each element checked if it is in setB
   letters[1:2] %in% setB
   letters[1:5] %in% setB
   which(letters[1:5] %in% setB)  ## which element of setA is in setB
   any(letters[1:5] %in% setB)    ## is ANY element of setA in setB ?
   ##
   ## More on sets in separate file.
   #######################################—•°

   #######################################—•°
   ## NOTICE that there is
   in   ## used in  for(k in set){...}
   ## and
   %in% ##  used as described above.
   #######################################—•°

## So we've got a function but there is some nagging detail: the replicated code.
## We've written two times:
#         assign(nam,iris[[nam]],pos=pos)
#         returned <- c(returned,nam)
## what doesn't look well, not to say: that's ugly and bad programming practice.

## 1.2.4
variables_from_df <- function(datfram,pos=1){
   returned <- character(0)
   for(nam in names(iris)){
      doit <- TRUE
      if(exists(nam,where=pos)){       ## in exists() there is 'where' option which means the same as 'pos'
         rl <- ""
         while( ! rl %in% c("0","1") ){
            rl <- readline(prompt=paste0(nam," already exists. Overwrite it? [0/1]: ")) ## always character
         }
         doit <- as.logical(as.numeric(rl))
      }
      if(doit){
         assign(nam,iris[[nam]],pos=pos)
         returned <- c(returned,nam)
      }
   }
   message("The following variables were returned to environment (pos=",pos,
   "):\n",paste(returned,collapse=", "),"\n",sep="")
}

variables_from_df(iris)   ## It's OK!!!

## Ufff...


## Now we may wish to remove all variable from environment having the same name as variables of the given data frame:
rm_variables_from_df <- function(datfram,pos=1){
   common <- intersect(ls(pos=1),names(datfram))  ## intersect(setA,setB) reurnes common elements of both sets (vectors)
   rm(list=common,pos=pos)
   cat("The following variables where removed from environment (pos=",pos,
   "):\n",paste(common,collapse=", "),"\n")
}

rm_variables_from_df(iris)
Sepal.Length
exists("Sepal.Length")
exists("Sepal.Width")
ls_str()


###################################################################################################—•°

#######################################—•°
save.image()

###################################################################################################—•°


source("")