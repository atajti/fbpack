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
search_fb(x, login_name, login_password, type = c("all", "users", "pages", "places", "groups", "apps", "events"), number_of_results = 5, location, workplace, education)
}

\arguments{
  \item{x}{
one length character vector (or one to be coerced): the search string. slashes should be avoided.
}
  \item{login_name}{
one length character vector, containing the string which should be used for login. Either profile name, phone nuber or e-mail address.
}
  \item{login_password}{
one length character vector, containing the password. Although interactive login could be acchieved to avoid storing unencrypted passwords, this version does not supports this. Will be implemented later.
}
  \item{type}{
one length charactr vector, one of "all", "users", "pages", "places", "groups", "apps", "events", defaults to "all". Entity tipe, to filter search on Facebook.
}
  \item{number_of_results}{
one length numeric vector, maximum number of profiles one wants as result.
}
  \item{location}{
optional, one length character vector. The name of a city, town which should be typed into the search filter, if  \code{type=="user"}.
}
  \item{workplace}{
optional, one length character vector. The name of a workplace which should be typed into the search filter, if  \code{type=="user"}.
}
  \item{education}{
optional, one length character vector. The name of a school or university which should be typed into the search filter, if  \code{type=="user"}.
}
}
\details{
The function searches for a given string with a given type. Ordering and quality of the results depends on Facebook's algorithm.

\code{location}, \code{education} and \code{workplace} are typed into the search fields, and if there is any, the first offered string will be chosen.
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