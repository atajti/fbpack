\name{get_user_info}
\alias{get_user_info}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Download profile data
}
\description{
This function provides a way to get informations provided by the user on his/her Facebook profile.
}
\usage{
get_user_info(user,remDr)
}

\arguments{
  \item{user}{
one length character or numeric, containing the Facebook profile ID.
}
  \item{remDr}{
  remote driver, a.k.a. the browser to manipulate, result e.g. \code{login_fb}
}
}
\details{
The function loads the user's profile, and steps through each sections, downloading information shown on the site. The function returns subsections, each containing every item as a character string to make post-download search possible. It also downloads messages telling that the information is missing (the user can be asked for that), but links, pictures and other object will not become part of the result.

Interactive login is supported, if either \code{user_login} or \code{user_password} is missing, the function will wait until the user logs in.

Soon the function (and others) will be updated to handle more than one length character and numeric vectors within one call.
}
\value{
  \item{user_info}{
  A list with items corresponding to valid sections an the users "about" page:
    \item{Overview}{section not yet used}
    \item{Work and Education}{Contains subsections as a list}
    \item{Places He/She/You Lived}{}
    \item{Contact and Basic Info}{}
    \item{Family and Relationships}{}
    \item{Details About}{}
    \item{Life Events}{}
  
    Names depends on the language the user set for Facebook.
  }
  \item{remote_driver}{
    The browser to pass to other functions, like \code{logout_fb}
  }
}
\author{
Andras Tajti
}
\note{
The language of results depends on the login user's settings
}

\examples{
## NOT RUN
# get_user_info("Facebook_user", your_login_name, your_password)
## END NOT RUN
}
