logout_fb <- function(remDr){

  tryCatch({
    log_out_element <- remDr$findElement(using = "id",
                         value = "pageLoginAnchor")

    log_out_element$clickElement()

    log_out_form <- remDr$findElements(using = "class name",
                         value = "_54nc")
    log_out_form <- log_out_form[[length(log_out_form)-2]]
    log_out_form$clickElement()},
    error=function(e){warning(paste0("Error:\n", e))
                      return(found_entities[1:number_of_results])
                      remDr$close()},
    warning=function(w){warning(paste0("Warning:\n", w))
                      return(found_entities[1:number_of_results])
                      remDr$close()})
  # close remote_driver, write data, clear everything and close R
  remDr$close()
  remDr$closeServer()
}
