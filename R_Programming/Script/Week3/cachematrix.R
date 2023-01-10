## The following functions create an inverse of a matrix by the caching method
## to avoid the use of intensive computations multiple times.
## This method inverses the matrix once, thus this cached matrix can be used on
## future calls.

## This function creates 4 functions that:
## 1st sets the value of the matrix, 2nd gets the value of that matrix, 
## 3rd sets the value of the inverse matrix, and 4th gets the value of that
## inverse matrix.

makeCacheMatrix <- function(x = matrix()) {
        i <- NULL
        set <- function(y) {
                x <<- y
                i <<- NULL
        }
        get <- function() {
                x
        }
        setinv <- function(inverse){
                i <<- inverse
        }
        getinv <- function() {
                i
        }
        list(set = set, 
             get = get,
             setinv = setinv,
             getinv = getinv)    
}


## This function computes the inverse of cached matrix returned by 
## makeCacheMatrix. If the inverse exists and the matrix has not been changed, 
## the inverse is pulled from the cache instead of performing
## the computation again.

cacheSolve <- function(x, ...) {
        i <- x$getinv()
        if (!is.null(i)) {
                message("getting cached matrix")
                return(i)
        }
        data <- x$get()
        i <- solve(data, ...)
        x$setinv(i)
        i
}


