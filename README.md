# shiny-app
Storage for web components written in R and compiled using ShinyApp

This app is currently deployed via my private ShinyApp server, but can be deployed freely on any ShinyApp server. ShinyApp can also be spun up on a private server and deployed there. Documentation for this can be found at:

https://docs.rstudio.com/shinyapps.io/

This app is written in R. It is made up of three components: an app.R file, which is the compiled app; a ui.R file, which is the visual element from the app.R file, and the server.R file, which gives instructions for the app should run. The app.R file should read as an exact copy of the ui.R file and the server.R file. When uploaded to a ShinyApp server, any images should be stored in a separate 'www' subfolder and referenced locally in the ui.R and app.R files.

This app draws user data from the coprocure.us website via our AWS endpoint at https://cncx06eah4.execute-api.us-east-1.amazonaws.com/production/dashboard, processes it in JSON, and displays it over time in a line graph. Using radio buttons, the user can toggle between the three recorded types of user activity.
