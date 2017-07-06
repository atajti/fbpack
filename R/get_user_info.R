# get_user_info()
get_user_info <- function(user, remDr){
  #remDr <- login_fb(login_name, login_password, ...)

  # go to profile_page
  suppressWarnings({
    numeric_id <- !is.na(as.numeric(user))
    profile_address <- ifelse(!is.na(as.numeric(user)),
                              paste0("https://www.facebook.com/profile.php?id=",
                                     user,
                                     "&sk=about"),
                              paste0("https://www.facebook.com/",
                                     user,
                                     "/about"))})
  remDr$navigate(profile_address)
#  sections <- remDr$findElements("css selector", "li._47_-")
  sections <- remDr$findElements("css selector", "a._5pwr")
  
  user_info <- rep(list(NA), length(sections))
  names(user_info) <- unlist(sapply(sections,
                                    function(e){
                                        e$getElementText()
                                      })) 
  
  for(i in 2:length(sections)){
  
    remDr$navigate(unlist(sections[[i]]$getElementAttribute("href")))

    sections <- remDr$findElements("css selector", "a._5pwr")
    subsections <- remDr$findElements("css selector", "div._4qm1")

    if(length(subsections)){
      subsection_values <- rep(list(NA), length(subsections))
      subsect_names <- remDr$findElements("css selector",
                                          "span._h72.lfloat._ohe._50f8._50f7")
      names(subsection_values) <- unlist(sapply(subsect_names,
                                                function(e){e$getElementText()}))
      for(j in 1:length(subsections)){

        subsection <- subsections[[j]]
        values <- subsection$findChildElements("css selector", "div._42ef")
        values <- unlist(sapply(values, function(e){e$getElementText()}))
        subsection_values[[j]] <- values
      }
      user_info[[i]] <- subsection_values
    } else {
      user_info[[i]] <- "ez elvileg Overview"
    }
  }

  # logout_fb(remDr)
  return(list(user_info=user_info, remote_driver=remDr))
}
