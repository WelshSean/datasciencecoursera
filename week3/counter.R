new_counter <- function() {
    i <- 0
    function() {
        i <<- i + 1
        i
    }
}


# counter_one <- new_counter()
# counter_two <- new_counter()

# counter_one()
# #> [1] 1
# counter_one()
# #> [1] 2
# counter_two()
# #> [1] 1