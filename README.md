# Roadar

An experiment to see if Bluetooth Beacons could revolutionise safety for cyclists.

I am a software developer and spent some time thinking about this problem a year or so ago.

Here I simply share an idea with the world created with the best of my knowledge at the time. Better that it's here than forgotton and never aired, it might lead to something or help give someone a better idea one day. Please feel free to share it with whomever you think might find it of interest!

## The Problem

2014 had approximately 21,287 recorded cyclists casualties in the UK alone, 113 deaths, 17, 773 seriously injured colliding with cars on UK roads.

Looking at the problem purely from a technology perspective, as that is my remit, the question I asked was: "What can we do about this with what we have today?"

Then I thought of the end game, apart from something lofty like telepathy, what could the solution be from a technology standpoint?

What is the best possible thing achievable that beats: 'Line of sight between a human driver and human on a bicycle (or motorbike) at a given moment in time.'

From there, I think plenty of people would arrive at the concept of: Drivers, vehicles and cyclists need to know exactly where they are in relation to each other at all times. Distance, speed and direction.

Obviously that comes with plenty of challenges, not least: Coming up with a way for cyclists and drivers to communicate their location in real time. It needs to be insanely easy to use, it needs to be cheap for everyone, it needs to not get in anyones way, annoy or distract. It really needs to not use the internet as it's not available everywhere and not everyone can afford it, it needs low (if any) dependence on batteries. Anything that needs to be in a vehicle needs to be external to the vehicle, a standalone device as something built-in to cars is too much of a leap and puts a decade of lobbying in the way. So that makes things interesting at least!

## The Solution

Providing cyclists and motorists the best warning they could get that they are near each other, how far and in what direction. Finding a way to alert/remind drivers "Hey, there is a bike pulling up behind you, just be aware. Oh hey, a bike is moving up on your left blindspot." even to a cyclist as well if needed: "Watch out, there is a HGV about to overtake you.", Early warnings on country lanes etc, you get the idea. 

That would be cool right? Enter Bluetooth and Smartphone apps. 

Smartphones came to mind, mainly because I make apps but also because, coupled with Bluetooth Beacons, it's almost everything we need that people have today.

Note: We clearly don't want drivers looking at apps running on their phone instead of keeping an eye out for cyclists on the road. This experience would have to be designed so that it did not require, or encourage, drivers staring at screens, certainly not anymore than their dashboard etc. In this experiment, the phone is simply our quickest route to running custom software and hardware in the car. People already have smartphones, in an ideal world as mentioned below, this would be another device offering a seamless experience, with minimal cognitive impairment to driver. That would be very important.

Bluetooth is low energy, can have a range of ~150 meters and the technology is improving and getting cheaper all the while.

So, keeping the explanation pretty simple. We would have a little device on a bike (or someones person) transmitting their location and presence in realtime to the world around them.

Now we have all these cyclists transmitting their movements around on Bluetooth, here is where smartphones come in. A smartphone app (like this demo project) can be used to both transmit and receive, in the role of either a cyclist or a driver. So in the interim, that gives us the means to put the early warning system, the software brains and the other Bluetooth communication part of the equation in the car. Today. That is cyclists, cycling down the road as they do everyday, effortlessly making drivers and vehicles aware of their presence. Awesome.

Imagine if it existed. Imagine if all a cyclist needed was a cheap little piece of kit, a Bluetooth transmitter and some other bits attached (low energy, up to 150 meter range, maybe need charging now and then) and motorists had an app that monitored all the cyclists near by in real time. It would be cheap and affordable for everyone. With enough marketing to maybe reach a tipping point and get everyone using it. If it worked, if enough people get on board with it, one day it could, maybe, account for saving some lives and be cheap enough and easy enough for everyone to use, everywhere. 

Fast forward a decade, it could be built into the dashboard of every new car made; or a standalone device people stick on their dashboard enforced by law; a little transmitter and some help included with every new bike sold.

## Conclusions

This demo achieves enough to see that it is possible.

This demo app uses motion chips on iOS devices to detect movement and broadcast your presence to other apps.
If you are in the driver mode you will see X number of cyclists and be alerted when one is very close.
If you are a cyclist you can see how many drivers are being notified of your presence in the vicinity.

So this app almost shows a working example, however limited in features, keeping it pretty simple. The end to end experience for people could be achieved with a smartphone app like this as they have motion tracking, ability to detect direction of travel/heading and can obviously act as both bluetooth transmitters/receivers (cyclist or driver). However phones are obviously very expensive and have short battery life, while they would be OK for people in a vehicle, out on the road as a cyclist (or pedestrian?) ideally, a smaller piece of kit would be more suited anyway.

Cycle safety utopia? Who knows, it's a wonderful thought but this is all just an idea. Feel free to run with it. It would be cool to somehow see it lead to something in the world one day, or something completely different and better that comes from it. Driverless cars are coming that have motion detectors for this in the future but the early warning of vulnerable road users in the general area would still be useful as well, plus, it could be a long time until everyone in Europe has the luxury of such vehicles. Something that tangible that might help solve the problem of cyclists and motor vehicles colliding daily, especially on Europe's intricate road networks; is something worth exploring.

## Hardware

Smartphones are good for this, we love them but they are too expensive to get mass adoption, amongst the other issues discussed. So ideally, a small device for cyclists and perhaps even an optional standalone device for cars, as well as the app.
The devices could have a little screen, some lights/sounds. Cyclists buy (or the government give them out) a cheap little device with the bare bones of tech to get the job done, Device A. Motorists buy a slightly different device with all the bells and whistles for monitoring who is around, Device B.

Cyclist:  Device A, (or the burden of a smartphone running an app)

Motorist: Device B or a smartphone app.

Simply put, if by some miracle everyone had this tomorrow, the number of casualties involving cyclists on our roads would have to be massively reduced by the end of the year. A fair sample of that number being peoples lives; saved.


## Additional Notes

- Maybe we don't need anything like this and humans just need be better at looking out for each other on the roads.
- Smartphones are not what we want drivers looking at when they should be driving. Remember the phone in this example is ideally used as an interim for another device. Don't discount the capabilities of a phone here, it's too much computing power that most people have with them to ignore.
- This is just an experiment and something I see might work and improve safety. There may be better ideas from people that don't include technology or do and have thought of better things than I have, this is just my attempt.
- This could also take the stance of keeping everything powered by an app and additional devices that link with the phones via Bluetooth and the phones handle all the communications but again, that assumes everyone with a bike, has a smartphone.

## The Demo

Install the app on some phones, on one app select yourself as a `Cyclist` on the other as a `Driver`. Make sure Bluetooth is turned on, move around, you should get alerts and see the UI light up with X number of cyclists around and how close they are.

The app should detect your movement and notify other apps that you are near and moving or stationary.

A non-exhaustive list of challenges remaining with this demo:

- The science of when and how often to alert drivers of cyclists movement would obviously need lots of work to make sure people like it.
- Not a lot of data can be transmitted between Bluetooth iBeacons at the moment. This makes it hard to add tracking information for who is who and where they are etc.
- GPS has not been employed yet so it's not possible to get anything more than a signal that someone is a 'distance' away from you. Keeping in mind the best way to use this might be with an additional smaller piece of kit for cyclists etc, I was aiming to see how far I could get keeping the technologies utilized to a minimum. 
- Some kind of internet registration or device registration would be good so different users can be identified uniquely, lots ideas could be explored from that.
- Bluetooth may have latency in faster traffic conditions, something that can be overcome no doubt.
- Mixing in additional ingredients like GPS could make things more accurate but also introduce latency, cost, power issues and make it harder to create a device that isn't a phone for people to use.
- 
## Code

The code is from a year or so ago now, iOS 7/8, Objective-C stuff and for a very hacky prototype so not production ready but does the job as a test.

## Screenshots

![Screenshot](https://raw.githubusercontent.com/robinhayward/Roadar/master/Screenshots/Screenshot4.png)

![Screenshot](https://raw.githubusercontent.com/robinhayward/Roadar/master/Screenshots/Screenshot3.png)

![Screenshot](https://raw.githubusercontent.com/robinhayward/Roadar/master/Screenshots/Screenshot2.png)

![Screenshot](https://raw.githubusercontent.com/robinhayward/Roadar/master/Screenshots/Screenshot1.png)
