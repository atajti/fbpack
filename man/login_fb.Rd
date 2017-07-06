\name{login_fb}
\alias{login_fb}
\alias{logout_fb}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Open a browser and log in, log out from Facebook
}
\description{
These functions will log you in and ou t of Facebook.
}
\usage{
login_fb(login_name, login_password, ...)
logout_fb(remDr)
}

\arguments{
  \item{remDr}{
a remoteDriver object, created by (for example) \code{login_fb}
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
The login_fb function creates a remoteDriver object, in wich it is logging in with the given information. logout_fb takes that remoteDriver and logs out of Facebook, then closes the object.

Interactive login is supported, if either \code{user_login} or \code{user_password} is missing, the function will wait until the user logs in.
}
\value{
for login_fb, a remoteDriver object.For logout_fb, none.
}
\author{
Andras Tajti
}

\examples{
## NOT RUN
# login_fb(your_login_name, your_password)
## END NOT RUN
}