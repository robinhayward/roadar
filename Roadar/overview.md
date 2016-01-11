RoadarApp
-

An application that shows cyclists locations around you on the road using iBeacons.

Can act as the same for cars and cyclists, toggle your state based on selection and/or core motion
Radar/warning mode for cyclists and drivers
* Track radar locations that are heavy with cyclists, warn time of day/location is busy with cyclists

* User downloads the app and registers with an email
* User enables the app to awake on cycle or drive
* User puts the app in cycle or drive mode


# Cycle mode

* Application transmits its position as an iBeacon with a registered UUID.
* Uses Core Motion to detect when a user is cycling or no longer cycling


# Driver Mode

* Application shows proximity of cyclists using the app
* Application has varying types of alerts for when a cyclists it around
* Uses Core Motion to detect when a user is driving or no longer driving


## Challenges

* Preventing anyone using the app when not cycling and messing up the experience for the driver (CoreMotion)


### Marketing

* Send out free stickers to put in your car to say you have the app running
* Send out free arm bands for cyclists to say they have the app running
