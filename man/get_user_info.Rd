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
get_user_info(user, login_name, login_password, ...)
}

\arguments{
  \item{user}{
one length character or numeric, containing the Facebook profile ID.
}
  \item{login_name}{
optional, one length character vector, containing the string which should be used for login. Either profile name, phone nuber or e-mail address. If not supplied, the user can log in in the browser.
}
  \item{login_password}{
optional, one length character vector, containing the password. If not supplied, the user can log in in the browser.
}
  \item{...}{
optiional arguments passed to \code{remoteDriver} to handtune browser.
}
}
\details{
The function loads the user's profile, and steps through each sections, downloading information shown on the site. The function returns subsections, each containing every item as a character string to make post-download search possible. It also downloads messages telling that the information is missing (the user can be asked for that), but links, pictures and other object will not become part of the result.

Interactive login is supported, if either \code{user_login} or \code{user_password} is missing, the function will wait until the user logs in.

Soon the function (and others) will be updated to handle more than one length character and numeric vectors within one call.
}
\value{
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
