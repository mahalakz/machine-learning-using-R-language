#install.packages("quadtree")

library(quadtree)
library(raster)

data(habitat)
rast <- habitat
plot(rast, main = "sample raster")

#Use Expand method
#select the row or column with large value
dim(rast) # not a power of 2

qt <- quadtree(rast, .15, adj_type = "expand")
plot(qt, border_lwd = .3, main = "expand raster dimensions")

#use resample method gives rectangular raster
qt <- quadtree(rast, .15, adj_type = "resample", resample_n_side = 128,
               resample_pad_nas = FALSE)
plot(qt, border_lwd = .3, main = "resample (without NA padding)")


#if required square form
qt <- quadtree(rast, .15, adj_type = "resample", resample_n_side = 128)
plot(qt, border_lwd = .3, main = "resample (with NA padding)")

#with no adjustment no of column will not get divide with 2
qt <- quadtree(rast, .15, adj_type = "none")
plot(qt, main = "adj_type = 'none'")

#method for splitting the quadrant
#range: difference between max and min value with in quadrant
#sd: find sd of value
#cv: calculate coefficient of variation

qt_range <- quadtree(rast, .1, split_method = "range")
qt_sd <- quadtree(rast, .1, split_method = "sd")
qt_cv <- quadtree(rast, .1, split_method = "cv")

par(mfrow = c(1, 3), mar = c(0,0,3,0))
plot(qt_range, crop = TRUE, na_col = NULL, zlim = c(0, 1), border_lwd = .3,
     axes = FALSE, legend = FALSE, main = "split_method = 'range'")
plot(qt_sd, crop = TRUE, na_col = NULL, zlim = c(0,1), border_lwd = .3,
     axes = FALSE, legend = FALSE, main = "split_method = 'sd'")
plot(qt_cv, crop = TRUE, na_col = NULL, zlim = c(0,1), border_lwd = .3,
     axes = FALSE, legend = FALSE, main = "split_method = 'cv'")

#Combine method
#Four methods to aggregate cell values are provided - "mean", "median", "min", and "max" 

qt_mean <- quadtree(rast, .1, "sd", combine_method = "mean")
qt_median <- quadtree(rast, .1, "sd", combine_method = "median")
qt_min <- quadtree(rast, .1, "sd", combine_method = "min")
qt_max <- quadtree(rast, .1, "sd", combine_method = "max")

par(mfrow = c(2, 2), mar = c(.5, .5, .5, .5))
plot(qt_mean, crop = TRUE, na_col = NULL, axes = FALSE, legend = TRUE,
     border_lwd = .3, zlim = c(0,1), main = "mean")
plot(qt_median, crop = TRUE, na_col = NULL, axes = FALSE, legend = TRUE,
     border_lwd = .3, zlim = c(0,1), main = "median")
plot(qt_min, crop = TRUE, na_col = NULL, axes = FALSE, legend = TRUE,
     border_lwd = .3, zlim = c(0,1), main = "min")
plot(qt_max, crop = TRUE, na_col = NULL, axes = FALSE, legend = TRUE,
     border_lwd = .3, zlim = c(0,1), main = "max")


#Custom methods
#Splitting functions
#Custom functions can be written to apply more complex rules to splitting and combining.
split_fun <- function(vals, args) {
  return(any(vals < args$threshold))
}

qt <- quadtree(rast, split_method = "custom", split_fun = split_fun,
               split_args = list(threshold = .8))
plot(qt, crop = TRUE, na_col = NULL, border_lwd = .3,
     main = "custom splitting function")


#Binary Quadtree: Custom quad function.
cmb_fun <- function(vals, args) {
  if (any(is.na(vals))) {
    return(NA)
  }
  if (mean(vals) < args$threshold) {
    return(0)
  } else {
    return(1)
  }
}
qt <- quadtree(rast, .1, combine_method = "custom", combine_fun = cmb_fun,
               combine_args = list(threshold = .5))
plot(qt, crop = TRUE, na_col = NULL, border_lwd = .3,
     main = "custom combine function")



#User another quad tree as template and create quad tree
data(habitat_roads)
template <- habitat_roads

# use a custom function so that a quadrant is split if it contains any 1's
split_if_one <- function(vals, args) {
  if(any(vals == 1, na.rm = TRUE)) return(TRUE)
  return(FALSE)
}
qt_template <- quadtree(template, split_method = "custom",
                        split_fun = split_if_one)

# now use the template to create a quadtree from 'rast'
qt <- quadtree(rast, template_quadtree = qt_template)

par(mfrow = c(1, 3), mar = c(0,0,3,0))
plot(template, axes = FALSE, box = FALSE, legend = FALSE,
     main = "template raster")
plot(qt_template, crop = TRUE, na_col = NULL, border_lwd = .3 ,axes = FALSE,
     legend = FALSE, main = "template quadtree")
plot(qt, crop = TRUE, na_col = NULL, border_lwd = .3, axes = FALSE,
     legend = FALSE, main = "quadtree created using template")


#max cell length and min cell length
qt_max_cell <- quadtree(rast, .15, max_cell_length = 1000)
qt_min_cell <- quadtree(rast, .15, min_cell_length = 1000)

par(mfrow = c(1, 2))
plot(qt_max_cell, crop = TRUE, na_col = NULL, border_lwd = .3, legend = FALSE,
     main = "max_cell_length = 1000")
plot(qt_min_cell, crop = TRUE, na_col = NULL, border_lwd = .3, legend = FALSE,
     main = "min_cell_length = 1000")

#split any na or all
qt_any <- quadtree(rast, .15, split_if_any_na = FALSE)
qt_all <- quadtree(rast, .15, split_if_all_na = TRUE)

par(mfrow = c(1, 2))
plot(qt_any, border_lwd = .3, legend = FALSE, main = "split_if_any_na = FALSE")
plot(qt_all, border_lwd = .3, legend = FALSE, main = "split_if_all_na = TRUE")


