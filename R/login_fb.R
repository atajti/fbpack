login_fb <- function(login_name, login_password, ...){
  # this function opens a browser, and if can, logs in to Facebook.
  # returns the remoteDriver for further usage,

  #
  # Function to find out wether the user logged in already
  #
  wait_for_user_login <- function(remDr){
    startime <- Sys.time()
    login_done <- list()
    while(length(login_done)==0 | Sys.time()-startime < 5){
        tryCatch({login_done <- remDr$findElement(using = 'css selector',
                   "div._4r_y")},
            error = function(e){NULL},
            warning=function(w){NULL})
        }
    return(remDr)
  }


  # non.docker style solution:
  #
  # startServer()
  # Sys.sleep(3)
  # remDr <- remoteDriver$new(...)
  # # open browser
  # remDr$open()
  # remDr$setImplicitWaitTimeout(5000)
  # remDr$setTimeout("page load", 10000)
  
  # docker-style solution:
  #
  # check for running selenium image, if none, then stop:
  if(!any(grepl("selenium", system("docker ps", intern=TRUE)))){
    stop("No running Selenium docker image found!")
  }
  # start remote driver, depending on os type
  if(grepl("win", Sys.info()["sysname"], ignore.case=TRUE)){
    remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",
                          port = 4445L,
                          ...)
  } else if(grepl("linux", Sys.info()["sysname"], ignore.case=TRUE)){
    remDr <- remoteDriver(port = 4445L,
                          ...)
  }
  

  remDr$open()
  remDr$setImplicitWaitTimeout(5000)
  remDr$setTimeout("page load", 10000)
  # navigate to facebook.com
  remDr$navigate("http://www.facebook.com")

 
  # log in
  # tryCatch needed if something fails
  # fb gyakran kidob ha sokszor jelentkezel be: element = dim.pam.login_error_box.uiBoxRed
  tryCatch({
    if(!missing(login_name) & !missing(login_password)){
      webElem <- remDr$findElement(using = 'xpath', "//*/input[@id = 'email']")
      webElem$sendKeysToElement(list(login_name, key="tab"))
      webElem <- remDr$findElement(using = 'xpath', "//*/input[@id = 'pass']")
      webElem$sendKeysToElement(list(login_password, key="enter"))
    }},
    error=function(e){warning(paste0("Error:\n",e))
                      remDr$close()},
    warning=function(w){warning(paste0("Warning:\n",w))})

  Sys.sleep(0.5)
  # check if we have logged in too often
  tryCatch({often_login <-remDr$findElement("css selector",
                                            "dim.pam.login_error_box.uiBoxRed")},
    error = function(e){NULL},
    warning=function(w){NULL})
  if("often_login" %in% ls()){
    message("waiting 15 minutess before new login...\n")
    Sys.sleep(15*60)
    message("Done, logging in...\n")
    tryCatch({
      if(!missing(login_name) & !missing(login_password)){
        webElem <- remDr$findElement(using = 'xpath', "//*/input[@id = 'email']")
        webElem$sendKeysToElement(list(login_name, key="tab"))
        webElem <- remDr$findElement(using = 'xpath', "//*/input[@id = 'pass']")
        webElem$sendKeysToElement(list(login_password, key="enter"))
      }},
      error=function(e){warning(paste0("Error:\n",e))
                        remDr$close()},
      warning=function(w){warning(paste0("Warning:\n",w))})
  }
  
  remDr <- wait_for_user_login(remDr)
  return(remDr)
}
