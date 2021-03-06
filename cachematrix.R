## makeCacheMatrix() is a function that accepts a matrix argument saved in the variable x
## There are 4 functions in it to 
## a. set the matrix 
## b. get the matrix
## c. set the inverse of the matrix
## d. get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {

    ## First initialize inv to NULL to ensure that if get_inverse() is called before
    ## the inverse is calculated, that the correct inverse matrix is returned
    ## This initializes the inverse matrix to a NULL matrix and the cached inverse matrix
    ## is not valid at this initial stage.
    inv <- NULL
    
    ## This function sets the matrix x to a user-defined matrix y. 
    ## The <<- operator is used because we are interested in modifying x and inv in the
    ## environment where makeCacheMatrix is called, and not in the local environment where
    ## the set function is defined.
    ## inv must be set to NULL after x is modified because then the cached vector is no longer valid.
    set <- function(y){
        x <<- y
        inv <<- NULL        
    }
    
    ## The get() function returns the matrix x 
    get <- function() x
    
    ## The set_inverse() function takes the inverse matrix as an argument and sets inv to inverse
    ## in the first environment in which inv was defined, ie in the environment of makeCacheMatrix.
    ## This is because we want to modify the previous value of inv with the new value of the inverse matrix.
    set_inverse <- function(inverse) inv <<-  inverse
   
    ## The get_inverse() function returns the matrix inverse of x.
    get_inverse <- function() inv
    
    ## The functions of set, get, set_inverse and get_inverse are coerced into a list and returned.
    list(set = set, get = get, set_inverse = set_inverse, get_inverse = get_inverse)
    
}


## The cacheSolve() function accepts the argument x and any other arguments in the ... space
## The argument x is a matrix that was generated by the makeCacheMatrix() function.
## It gets the matrix that was cached by the makeCacheMatrix() and uses the solve() function to
## calculate the matrix inverse of x.  This calculated is set and cached into x by the x$set_inverse()
## function.  The function calls and returns the matrix inverse using the x$get_inverse() function.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'

    ## Retrieve the matrix inverse through the function x$get_inverse() and assign it to inv.
    inv <- x$get_inverse()
    
    ## Check if inv is a NULL matrix, ie no inverse has yet been calculated.  If inv is not a NULL matrix,
    ## ie, an inverse has been calculated before, then generate a diagnostic message "getting cached data"
    ## and return the inv matrix.
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    
    ## If no matrix has yet been calculated, get the matrix x using the x$get() function and assign to mat
    ## Solve for the matrix inverse using the solve() function and assign to inv.
    mat <- x$get()
    inv <- solve(mat,...)
    
    # Set the matrix inverse using the x$set_inverse() function using inv as an argument.
    x$set_inverse(inv)
    
    # Call the calculated matrix inverse using the x$get_inverse() function and return its value.
    x$get_inverse()

}
