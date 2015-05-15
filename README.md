# fbpack
R package for user frienly Facebook scraping

## Purpose
Facebook provides programmatically collectable data through its API,
and R has a package (RFacebook) which can connect to it. Why did I start this project?

First, when I tried it in november, 2014, the RFacebook package did not worked as I expected. One of the reasons
was that since it then-last update, Facebook modified its API rules: one could not collect information about
friendships which are available for the user through the browser when logged in. This gave me the motivation,
but I lacked tools. At the Budapest R meetup in january, I saw the demonstration of the RSelenium package.

The RSelenium packge connects R to the Selenium Web Driver, which allows the user to navigate and use a browser
programmatically as a real person. This became an opportunity to simulate a user browsing Facebook,
and gather the data displayed in the browser.

## Instaling
Installing the package can be done with Hadley Wickham's devtools package:
```{r "package installation"}
if(!require(devtools)){
  install.packages(devtools)
}
devtools::install_github("atajti/fbpack")
```
Also, the Selenium Web Driver should be on the computer. The RSelenium package takes care of this if one runs the
`RSeleium::checkForServer()` function.

## Usage
The Selenium server have to be started as all of the functions use it.
```{r "package usage"}
library(fbpack)
startServer()
```

After the `startServer()` function called, one should wait a few seconds for Selenium to start. After that,
`fbpack`'s two function(`search_fb()`, `get_user_friends()`) should run properly. For further information,
see `?search_fb` and `?ger_user_friends`, or contact me.

## Draw backs, TO DOs
The package is still under development. Its biggest problem the **dependence on a stable internet connection**,
as timeouts can break the functions. To enhance its capabilities, an additional argument will appear in the functions
to handtune the browser. 

These functions are still perform poorly in **terms** of speed and **memory-efficiency**. The first issue is hard -
at least for me - as the stability and speed of loading is limiting wait times as well as robustness.
The second problem is the reason why every call opens a new browser instead of continuing in the opened one.
The Firefox browserconsumes much memory after a certain time and page load count. The most efficient solution I
found is to create a command line R script, and calling it from an other R session, each time start and close the
Selenium server and clean the memory. This workaround also slows the workflow.

Another issue is password **encryption**. In future versions, I plan to introduce interactive login, because the
functions need the password as unencrypted strings. This solution would need functions which are working without
new browsers, or some solutions to store and use cookies in an R session. Another solution would be the encryprion
of the password string, but I could not find any function for this task.



