# Roadar
An experiment to see if Bluetooth Beacons could revolutionise safety for cyclists. 

The idea behind this was to see if an app on smart phones using low energy bluetooth could be used to alert/remind motorists that cyclists are in the vicinity and in which direction.

I got this basically working after hacking around some but currently the beacon tech does not seem to be quite up to it yet. Perhaps with fresh ideas and perspective it might get further.

Imagine if it existed? Imagine if all a cyclist needed was a cheap little bluetooth transmitter (low energy, upto 150 meter range, maybe need charging now and then) and motorists had an app then showed all the cyclists near by in real time. If the tech worked, it would be cheap and affordable for everyone, apps could later be built into cars. With enough marketing to maybe reach a tipping point and get everyone using it. If it worked, if enough people get on board with it, one day it could maybe, just maybe, account for saving some lives and be cheap enough and easy enough for everyone.

It was worth a shot anyway!

## Using it

Install the app on some phones, on one app select yourself as a `Cyclist` on the other as a `Driver`. Make sure Bluetooth is turned on, move around, you should get alerts and see the UI light up with X number of cyclists around and how close they are.

## What is the problem this is trying to solve?

Making the roads safer for cycling. Providing cyclists and motorists the best warning they could get that they are near each other, how far and in what direction. Finding a way to alert/remind drivers "Hey, there is a bike pulling up behind you, just be aware. Oh hey, the bike is moving up on your left."

That would be cool right? But not everyone has a smartphone and an internet connection and endless battery to name just a few hurdles. Enter Bluetooth, low energy, small data being shared over distances of around ~150 meters or more is possible. Inexpensive enough for everyone to buy a little bit of kit that clips on their bike or fits in the pocket (as well as an app on a phone), inexpensive enough to break, lose and just go buy a new one. Maybe they get built with unique codes in so it's not even worth stealing but that's another conversation.

So then you have all these cyclists transmitting there movements around on Bluetooth, enter smartphones, an app like this one can be used to both transmit and receive, in the role of either a cyclist or a driver. Drivers have the app flash up and beep wth alerts an updates of vulnerable road users in their vicnity. Fast foward a decade, it could be built into the dashboard of every new car made; a little transmitter and setup help included with every new bike sold. 

Cycle safety utopia? It's an idea anyway, feel free to run with it or ask me anything. It would be cool to somehow maybe see it in the world one day, or something completely different and better (maybe driverless cars can detect most of the motion themselves in the distant future). Something that actually solves the problem of cyclists and motor vehicles colliding daily, especially on Europe's intricate road networks; is something worth exploring.

## Why can't we all use this now?

It's not impossible for us to do so, there just a few limitations with how smartphones act as transmitters/receivers at the moment. They data they can send is very limited and it's also difficult to work out who is who in the beacon realm of a given area, but I expect with more thought that can be solved. I add smartphones as a limitation but I guess the receivers could be dropped on the dashboard of cars as a separate little device until phones are better at beacon things and/or cars this kind of tech built in. I also didn't manage to figure out a method of getting the heading/direction of travel a particpant was travelling.

## Is this physically possible today?

Yes. Off the top of my head, you would need to design and manufacturer the transmitters. The receivers could be crude smartphone ones with limited features but people probably wouldn't use them, so it might be an idea to make standalone little receivers too, that communicate with a little screen, some lights/sounds. Cyclists buy the transmitter (or the goverment give them out) motorists buy the receiver.

Simply put, if by some miracle everyone had this tomorrow, the number of Road Traffic Accidents involving cyclists would have to be massively reduced by the end of the year. A fair sample of that number being peoples lives; saved.

## Code

The code is from a year or so ago now, iOS 8, Objective-C stuff and for a pretty hacky prototype so not production ready but does the job pretty much as a test.

## Some Screenshots

![Screenshot](https://raw.githubusercontent.com/robinhayward/Roadar/master/Screenshots/Screenshot4.png)

![Screenshot](https://raw.githubusercontent.com/robinhayward/Roadar/master/Screenshots/Screenshot3.png)

![Screenshot](https://raw.githubusercontent.com/robinhayward/Roadar/master/Screenshots/Screenshot2.png)

![Screenshot](https://raw.githubusercontent.com/robinhayward/Roadar/master/Screenshots/Screenshot1.png)
