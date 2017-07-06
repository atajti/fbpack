get_user_friends <- function(user, remDr){
  # returns a character vector, IDs and profile names of other users
  #  who can be displayed on the users Friends page.


  #
  # Function to find out wether the user logged in already
  #
  wait_for_user_login <- function(remDr){
    startime <- Sys.time()
    login_done <- list()
    while(length(login_done)==0 | Sys.time()-startime < 5){
        tryCatch({login_done <- remDr$findElement(using = 'id',
                   "pagelet_bluebar")},
            error = function(e){NULL},
            warning=function(w){NULL})
        }
    return(remDr)
  }

  #
  # get displayed friends
  #
  
  get_friend_list <- function(remDr){
    # remDr shoud be at facebook.com/<username>/friends
    user_friends <- remDr$findElements(using = 'xpath',
                      "//*/a[@class = '_5q6s _8o _8t lfloat _ohe']")
    f_links <- sapply(user_friends, function(friend){
      friend$getElementAttribute("href")
      })
    return(unlist(f_links))
  }



  #
  # Function to scan all friends of a user, for later use.
  #

  scan_all_friends <- function(remDr, txt_progress=NULL){
    s0 <- NULL
    s1 <- get_friend_list(remDr)

    while(!identical(s0,s1)){
      s0 <- s1
      # scroll:
      for(i in 1:30){
        tryCatch(remDr$executeScript("window.scrollBy(0,2000)"),
                 error = function(e){NULL},
                 warning=function(w){NULL})
      }
      Sys.sleep(.5)
      # wait until page loads. check it in every second.
      # This won't work as FB loads pix etc. after state is "comleted"
      # while(!(unlist(remDr$executeScript("return document.readyState")) ==
      #         "complete")){
      #   message(unlist(remDr$executeScript("return document.readyState")))
      #   Sys.wait(1)
      # }
      
      Sys.sleep(2)
      #system("ping 8.8.8.8 -c 1")

      s1 <- get_friend_list(remDr)
      # if a txt Progress Bar object is given, update it
      if(!is.null(txt_progress)){
        setTxtProgressBar(txt_progress, length(s1))
      } else {
        message(paste("Collected", length(s1), "friends"))
      }
      gc()
    }
    return(s1)
  }

  #
  # open facebook, log in
  #


  # remDr <- remoteDriver$new(...)

  # docker-style solution:
  #
  # check for running selenium image, if none, then stop:
  # if(!any(grepl("selenium", system("docker ps", intern=TRUE)))){
  #   stop("No running Selenium docker image found!")
  # }
  # start remote driver, depending on os type
  # if(grepl("win", Sys.info()["sysname"], ignore.case=TRUE)){
  #   remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",
  #                         port = 4445L,
  #                         ...)
  # } else if(grepl("linux", Sys.info()["sysname"], ignore.case=TRUE)){
  #   remDr <- remoteDriver(port = 4445L,
  #                         ...)
  # }


  # open browser
  # remDr$open()
  # remDr$setImplicitWaitTimeout(5000)
  # remDr$setTimeout("page load", 10000)
  # # navigate to facebook.com
  # remDr$navigate("http://www.facebook.com")

  # # log in
  # if(!missing(login_name) & !missing(login_password)){
  #   webElem <- remDr$findElement(using = 'xpath', "//*/input[@id = 'email']")
  #   webElem$sendKeysToElement(list(login_name, key="tab"))
  #   webElem <- remDr$findElement(using = 'xpath', "//*/input[@id = 'pass']")
  #   webElem$sendKeysToElement(list(login_password, key="enter"))
  # }
  
  # remDr <- wait_for_user_login(remDr)

  #
  # collect friends profile ID
  # 

  # go to user's friends
  if(is.na(suppressWarnings(as.numeric(user)))){
    remDr$navigate(paste0("http://facebook.com/", user, "/friends"))
    } else {
    remDr$navigate(paste0("https://facebook.com/profile.php?id=", user,
                          "&sk=friends"))
    }

  # scan friends
  message("Scanning friends of user ", user, " @ ", Sys.time())
  ego_friends <- scan_all_friends(remDr) 
  f_list <- unname(sapply(ego_friends, function(link){
    ifelse(grepl("profile.php?", link, fixed=TRUE),
      strsplit(substring(link, 41), split="&", fixed=TRUE)[[1]][1],
      strsplit(strsplit(link, split="/")[[1]][4],
               split="?",
               fixed=TRUE)[[1]][1])
      }))

  #
  # log out and close browser
  #

  # log_out_element <- remDr$findElement(using = "id",
  #                      value = "pageLoginAnchor")
  # log_out_element$clickElement()

  # log_out_form <- remDr$findElements(using = "class name",
  #                      value = "_54nc")
  # log_out_form <- log_out_form[[length(log_out_form)-2]]
  # log_out_form$clickElement()

  # # close remote_driver
  # remDr$close()
  #remDr$closeServer()

  #
  # return data
  # 
  return(list(friend_list=f_list, remote_driver=remDr))


}