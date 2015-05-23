\name{search_fb}
\alias{search_fb}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Search for profile links on Facebook
}
\description{
This function provides an interface for Facebook search.
}
\usage{
search_fb(x, login_name, login_password, type = c("all", "users", "pages", "places", "groups", "apps", "events"), number_of_results = 5, attributes, ...)
}

\arguments{
  \item{x}{
one length character vector (or one to be coerced): the search string. slashes should be avoided.
}
  \item{login_name}{
optional, one length character vector, containing the string which should be used for login. Either profile name, phone nuber or e-mail address. If not supplied, the user can log in in the browser.
}
  \item{login_password}{
optional, one length character vector, containing the password. If not supplied, the user can log in in the browser.
}
  \item{type}{
one length charactr vector, one of "all", "users", "pages", "places", "groups", "apps", "events", defaults to "all". Entity tipe, to filter search on Facebook.
}
  \item{number_of_results}{
one length numeric vector, maximum number of profiles one wants as result.
}
  \item{attributes}{
optional, named list or vector with search filter to be used in case of user search. Filters I encountered are \code{Location}, \code{Workplace}, \code{Education}, \code{Mutual friends}.
}
  \item{...}{
optiional arguments passed to \code{remoteDriver} to handtune browser.
}
}
\details{
The function searches for a given string with a given type. Ordering and quality of the results depends on Facebook's algorithm.

\code{location}, \code{education} and \code{workplace} are typed into the search fields, and if there is any, the first offered string will be chosen.

Interactive login is supported, if either \code{user_login} or \code{user_password} is missing, the function will wait until the user logs in.

The attributes argument must be a named list or vector, with names chosen from
the given list, or any other filter type which occurs on Facebook.
}
\value{
Character vector with the links of the entities.
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Andras Tajti
}
\note{
%%  ~~further notes~~
}

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
## NOT RUN
# search_fb("R (programming language)", your_login_name, your_password)
## END NOT RUN
}