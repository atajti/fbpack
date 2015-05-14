search_fb <- function(x, login_name, login_password,
                      type=c("all", "users", "pages", "places",
                             "groups", "apps", "events"),
                      number_of_results=5,
                      location, workplace, education){
  # Search on Facebook for a given character string.
  # Type can be specified, default to user
  # location, workplace, education are for type="user"
  # number_of_results is the maximum number of returned links
  # a character vector with length number_of_results, containing links.
  

  #
  # open facebook, log in
  #

  remDr <- remoteDriver(remoteServerAddr = "localhost", 
                      port = 4444,
                      browserName = "firefox")
  # open browser
  remDr$open()
  remDr$setImplicitWaitTimeout(5000)
  remDr$setTimeout("page load", 10000)
  # navigate to facebook.com
  remDr$navigate("http://www.facebook.com")

  # log in
  webElem <- remDr$findElement(using = 'xpath', "//*/input[@id = 'email']")
  webElem$sendKeysToElement(list(login_name, key="tab"))
  webElem <- remDr$findElement(using = 'xpath', "//*/input[@id = 'pass']")
  webElem$sendKeysToElement(list(login_password, key="enter"))

  # wait for login:
  # while(!exists("login_done")){
  #     tryCatch({login_done <- remDr$findElement(using = 'class',
  #                               value = "uiIconText")},
  #       #'xpath', "//*/div[@class = 'clearfix']")},
  #         error = function(e){NULL},
  #         warning=function(w){NULL})
  #     }
  Sys.sleep(2)

  #
  # navigate to search page, enter query if necessary
  #
  if(length(type)-1){
    type <- "users"
  }

  remDr$navigate(paste0("https://www.facebook.com/search/results/?q=",
                        x,
                        "&type=",
                        ifelse(length(type)==1, type, "users")))
  # if type=="user" and other attributes are given, fill them in:
  if(type[1]=="users" & any(!missing(location),
                           !missing(workplace),
                           !missing(education))){

    inp_flds <- expression(
      input_fields <- tryCatch({remDr$findElements("css selector",
                                                   "input._58al")},
        warning = function(w){paste0("Warning:\n", w, "\n Continuing search.")},
        error   = function(e){paste0("Error:\n", e, "\n Continuing search.")}))
    
    # location:
    if(!missing(location)){
      location_input <- eval(inp_flds)[[1]]
      tryCatch({ #location_input <- remDr$findElement("xpath",
                  #       "//*/input[@data-reactid = '.a1.1:$lo.1.0.0']")
        #"placeholder",
         #                           "Type the name of a town or region.")
      try(location_input$sendKeysToElement(list(location)))
      # wait 0.5s for drop-down suggestions
      Sys.sleep(.5)
      # choose first suggestion
      location_input$sendKeysToElement(list(key="down_arrow"))
      Sys.sleep(0.5)
      location_input$sendKeysToElement(list(key="up_arrow"))
      Sys.sleep(0.5)
      location_input$sendKeysToElement(list(key="tab"))
      Sys.sleep(0.5)},
        warning= function(w){warning(paste0("Location may not be used,",
          " continuing search anyhow.\n\tWarning: ", w))},
        error  = function(e){warning(paste0("An error occured at location",
          " input. Continuing search anyhow.\n\tThis is the original error",
          " message: ", e))})
    }

    # education:
    if(!missing(education)){
      education_input <- eval(inp_flds)[[3]]
      tryCatch({#education_input <- remDr$findElement("xpath",
                 #        "//*/input[@data-reactid = '.a1.1:$ed.1.0.0']")
        # "placeholder", "Type the name of a university or a school.")
      try(education_input$sendKeysToElement(list(education)))
      # wait 0.5s for drop-down suggestions
      Sys.sleep(.5)
      # choose first suggestion
      education_input$sendKeysToElement(list(key="down_arrow"))
      Sys.sleep(0.5)
      education_input$sendKeysToElement(list(key="up_arrow"))
      Sys.sleep(0.5)
      education_input$sendKeysToElement(list(key="tab"))
      Sys.sleep(0.5)},
        warning= function(w){warning(paste0("Education may not be used,",
          " continuing search anyhow.\n\tWarning: ", w))},
        error  = function(e){warning(paste0("An error occured at education",
          " input. Continuing search anyhow.\n\tThis is the original error",
          " message: ", e))})
    }

    # workplace:
    if(!missing(workplace)){
      workplace_input <- eval(inp_flds)[[2]]
      tryCatch({#workplace_input <- remDr$findElement("xpath",
                 #        "//*/input[@data-reactid = '.a1.1:$wk.1.0.0']")
        #"placeholder", "Type the name of a company.")
      try(workplace_input$sendKeysToElement(list(workplace)))
      # wait 0.5s for drop-down suggestions, cannot get around it... :(
        # TODO: evaluate suggestions
      Sys.sleep(.5)
      # choose first suggestion
      workplace_input$sendKeysToElement(list(key="down_arrow"))
      Sys.sleep(0.5)
      workplace_input$sendKeysToElement(list(key="up_arrow"))
      Sys.sleep(0.5)
      workplace_input$sendKeysToElement(list(key="tab"))
      Sys.sleep(0.5)},
        warning= function(w){warning(paste0("workplace may not be used,",
          " continuing search anyhow.\n\tWarning: ", w))},
        error  = function(e){warning(paste0("An error occured at workplace",
          " input. Continuing search anyhow.\n\tThis is the original error",
          " message: ", e))})
    }
  }

  #
  # Collect results
  #

  found_entities <- NULL
  while(length(found_entities) < number_of_results){
    # collect links
    results <- remDr$findElements("css selector", "a._8o._8s.lfloat._ohe")
    found_entities_tmp <- unlist(
      sapply(results, function(element){
        element$getElementAttribute("href")
      }))
    # sanity check:
    if(length(results) < length(found_entities_tmp)){
        warning("There may be more links than found entities!")
      }

    # tmp must be longer than the collector:
    found_entities_tmp <- found_entities_tmp[!grepl("l.php",
                                             found_entities_tmp)]
    if(length(found_entities_tmp) <= length(found_entities)){
      break
      } else {
      found_entities <- c(found_entities, found_entities_tmp)
                          
      # scroll page only if necessary
      if(length(found_entities) < number_of_results){
        for(i in 1:30){
          tryCatch({remDr$executeScript("window.scrollBy(0,2000)")},
                   error = function(e){warning(paste0("An error occured when",
                     "scrolled:\n", e))},
                   warning=function(w){warning(paste0("Warning when scrolling:\n",
                     w))})
           }
         }         
      }
   }
  #
  # Log out, close browser
  #

  log_out_element <- remDr$findElement(using = "id",
                       value = "pageLoginAnchor")
  log_out_element$clickElement()

  log_out_form <- remDr$findElements(using = "class name",
                       value = "_54nc")
  log_out_form <- log_out_form[[length(log_out_form)-2]]
  log_out_form$clickElement()
  # close remote_driver, write data, clear everything and close R
  remDr$close()

  #
  # Return data
  #

  return(found_entities[1:number_of_results])
}