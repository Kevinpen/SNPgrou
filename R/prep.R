#' Prepare the data for the analysis purpose
#'
#' Transform the data to class "SNP" object, with alleles separated with "/"
#'
#' @param x, numeric data of all obeservation of alleles in single locus
#' @param delim character that separate the alleles in original data in one locus, could be empty
#'
#'
#' @return object belong to "SNP" and "factor", with attributes of alleleNames
#'
#' @examples
#'
#'
#' @export

prep<-
function(x,delim=NULL){
x<-as.character(x)
if(is.null(x)) {
  stop("No input data found.")
}

# Check whether the SNP data is legitimate, for no delimiter case
  if(all(lapply(x,nchar)==2,na.rm=TRUE)){
    if(!(all(grepl("[ACGT]",x),na.rm=TRUE))){
      stop(" Data contain non SNP data")
      }
  }

# Check whether the SNP data is legitimate, for delimiter present case
if(all(lapply(x,nchar)==3,na.rm=TRUE)){
    y<-c(substring(x,1,1),substring(x,3,3))
    if(!(all(grepl("[ACGT]",na.omit(y))))){
      stop(" Data contain non SNP data")
    }
}

# Legitmate SNP data for single locus can only be 2-3 characters
else if(all(lapply(x,nchar) > 3,na.rm=TRUE)){
  stop("SNP data exceed 3 character limit")
}

# No delimiter in data, add delimiter"/"
if (missing(delim)){
  subStr<-paste(substring(x,1,1),substring(x,2,2),sep="/")
  alleles<-unique(na.omit(c(substring(x,1,1),substring(x,2,2))))

}else if(delim==""){
  subStr<-paste(substring(x,1,1),substring(x,2,2),sep="/")
  alleles<-unique(na.omit(c(substring(x,1,1),substring(x,2,2))))

}else if (is.character(delim)) {

# Test whether the user specified delimiter contained in the data
    if (!all(grepl(delim,na.omit(as.character(x)), fixed = TRUE))){
      stop("The delimiter you specified does not contained in your data")

    }else{
# Change original deilimiter to "/"
  subStr<-gsub(delim,"/",x)
  alleles<-unique(na.omit(c(substring(x,1,1),substring(x,3,3))))
    }

}else{

# The dilim parameter is not legitimate delimiter
  stop("Please use the correct dilimiter in the data")
}

  mode(subStr) <- "character"
  result<-factor(subStr)
#create SNP class
  class(result) <- c("SNP","factor")
  attr(result, "alleleNames") <- alleles

 return(result)
}


