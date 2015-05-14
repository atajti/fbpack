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
get_user_friends(user, login_name, login_password)
}

\arguments{
  \item{user}{
one length character vector, the profile address of the target user, for example: "atajti" 
}
  \item{login_name}{
one length character vector, containing the string which should be used for login. Either profile name, phone nuber or e-mail address.
}
  \item{login_password}{
one length character vector, containing the password. Although interactive login could be acchieved to avoid storing unencrypted passwords, this version does not supports this. Will be implemented later.
}
}
\details{
The function opens a browser through RSelenium, so be sure that \code{startServer} has been called a few seconds earlier - the server start needs some seconds. This inconvenience will be elliminated later.
}
\value{
A character vector with profile names/ids of the users who are allowed to see among the user's friends. These values can be used as the \code{user} argument of this function.
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