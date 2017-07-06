\name{get_user_friends}
\alias{get_user_friends}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Collecting profile names or IDs from the friends of the target user.
}
\description{
A function to scan a user's friends' profile name. 
}
\usage{
get_user_friends(user, remDr)
}

\arguments{
  \item{user}{
one length character vector, the profile address of the target user, for example: "atajti" 
}
  \item{remDr}{
  remote driver, a.k.a. the browser to manipulate, result e.g. \code{login_fb}
}
}
\details{
The function opens a browser through RSelenium, so be sure that \code{startServer} has been called a few seconds earlier - the server start needs some seconds. This inconvenience will be elliminated later.

If either \code{login_name} or \code{login_password} missing, the function will wait until the user does not log in.
}
\value{
  \item{friend_list}{
  A character vector with profile names/ids of the users who are allowed to see among the user's friends. These values can be used as the \code{user} argument of this function.
  }
  \item{remote_driver}{
    The browser to pass to other functions, like \code{logout_fb}
  }
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Andras Tajti <atajti@gmail.com>
}
\note{
RSelenium options will be added later to give direct control to the user abovee RSelenium.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
## NOT RUN
# get_user_friends("a_user_profile_name", "your_login_name", "your_login_password")
## END NOT RUN
}