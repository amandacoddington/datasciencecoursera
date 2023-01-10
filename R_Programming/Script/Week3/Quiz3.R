### Week 3 Quiz

## No. 1
        # looking at 'iris' data set
        library(datasets)
        data(iris)
        
        # description of iris
        ?iris
        
        # find the mean of 'Sepal.Length' for the species *virginica*
        s <- split(iris, iris$Species)
        sapply(s, function(x) {
                colMeans(x[, c('Sepal.Length', 'Sepal.Width')], na.rm = FALSE)
        })

        
## No. 2
        # what R code returns a vector of the means of the variables
        # 'Sepal.Length', 'Sepal.Width', 'Petal.Length' & 'Petal.Width'
        apply(iris[, 1:4], 2, mean)
        
        
## No. 3
        # load & description of 'mtcars' data set
        library(datasets)
        data(mtcars)
        ?mtcars
        
        # how can you calc the avg mpg by number of cylinders in the car (cyl)
        sapply(split(mtcars$mpg, mtcars$cyl), mean)
        tapply(mtcars$mpg, mtcars$cyl, mean) # can NOT swap mpg and cyl wont work
        with(mtcars, tapply(mpg, cyl, mean))
        
        
## No. 4
        # what is the absolute difference b/w average horsepower of 4-cyl cars
        # and the average horsepower of 8-cyl cars?
        s <- split(mtcars$hp, mtcars$cyl)
        sapply(s, mean)
        209.21429 - 82.63636
        
        
## No. 5
        # if you run debug(ls) what happens when you next call ls()?
        debug(ls)
        ls()
                # execution of ls will suspend at the beginning of the function
                # and you will be in the browser