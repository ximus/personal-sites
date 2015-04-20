---
title: Using sub-Ghz radios, a laser and an xport to connect my home gate to the internet
description: Notes on how I used sub-Ghz radios, a laser and an xport to connect my home gate to the internet
image: "http://maximeliron.com/images/gate-flow.png"
layout: notes
kind: article
---

# Portail Notes
What you'll learn about here is how I used sub-Ghz radios, a laser and an xport to connect my home gate to the internet.

## Problem
![Illustration of the gate communication problem](../images/gate-illustration.png)

We just installed an automatic gate at home. It is far from the house and we didn't install an intercom. Those who live here can get in using a remote. And if you are a guest, there is a code you can dial if you know it.

*However, for security reasons, the code dial is disabled at night*. Now when a guest is trying to enter or leave during nightime, we have to walk out to the gate and let them through with our remotes, which is annoying.

As a solution, I tasked myself to link the gate to the internet for remote control. We will be able to open it from anywhere and friends and family will be able to let themselves in.

## Disclaimer
These notes are from a personal educational project exploring electronics. Though some effort has been invested in formatting for clarity, my note taking was sporatic.

The main objective of this endeavour was to learn electronics. Desing decisions were optimized for learning experience first, technical effiency come in second, so expect technically sub-optimal decisions.

## System Design

Visitors interact with a web client which communicates with an endpoint located at my house acting as gateway, which in turn communicates with a module located near the gate that interfaces with the gate.

This overview of the request flow gives a wide angle view:

![Illustration of the gate communication problem](../images/gate-flow.png)

### Web Stack

#### Client: Browser app using Polymer
Rationale: experiment with web components.

Notes on using web components: Some nice definite things about using web components: scope isolation, encapsulation. But less cool: a little verbose

talk about this: "The “theming problem” — you want to be able to easily style Polymer elements from the outside, but ::shadow and /deep/ are far too painful (we agree!). We are exploring a robust system for ergonomic cross-scope styling inspired by and based on CSS Custom Properties — experimental support for cross-scope styling is included in 0.8."

#### Backend: Ruby
Basic framework
Rationale: I'm used to it, it's fun. I intially started using NodeJS as I thought some companies would appriciate that on my resume. I moved forward with not just one, but a few different NodeJS web frameworks. However I backed away from NodeJS frameworks after getting sick of having to implement my own plumbing too often. Javascript is fun in the browser but I vastly prefer Ruby's syntax and ecosystem on the server.

### Home: Internet Gateway
![Illustration of the gate communication problem](../images/gateway-diagram.png)

I'm using a [Lantronix XPort Pro](http://www.lantronix.com/device-networking/embedded-device-servers/xport-pro.html) connected to a [Wizzimote node](http://www.wizzilab.com/solutions/wizzikit/).

When I chose this design I had very little knowledge of electronics. With the confidence I now have, I would do it very differently.

Why UDP? Why not. CoAP is commonly used with UDP so I started with it. CoAP provides message delivery guarantees, which is probably all I would need from TCP.

Why UART? The XPort is designed to interface over UART. This is the channel over which network packets are relayed to and from to the CC430.

There was no opportunity to have fun and research IoT network routing as there are only two nodes. To keep things simple I am using the hardware radio packet facility provided by the CC430 chip.

<div class="side-note">
Why wizzimotes? Why Riot-OS?

Wizzimotes are modules intended to explore the [DASH7](http://www.dash7-alliance.org/) IoT network stack. They are low power and come with a an SDK that includes a lightweight OS layer comprised of a [HAL](http://en.wikipedia.org/wiki/HAL_%28software%29), process management (using pthreads) and DASH7 radio lib. I initially started developing using these tools and exploring this code was very educative; it's well written and efficient.

At some point I came accross [Riot-OS](http://www.riot-os.org/). I decided to switch over to Riot:

* Riot is open source and open to the public (Wizzlab's code wasn't). That means more contributors, and codebase likely more representative of industry coding standards.
* Riot was in line with my hardware: it already had support for the wizzimote's CC430 MCU and its 2Kb of RAM
* Riot was in line with my project goal: this is it's current slogan: "The friendly Operating System for the Internet of Things"
* Riot was great opportunity to learn more about emebeded development. My main project goal was educational, I got to learn tons by digging into Riot.
</div>

### Gate: Control and Observation
![Illustration of the gate communication problem](../images/gate-diagram.png)

Located near the gate is a second Wizzimote. This guy is made up of alot more code than its gateway brother.

Its responsibilities include:

* Listen for and respond to network requests like "get gate status" or "open gate"
* Open or close the gate
* Report gate position
* Degrade gracefully upon laser obstruction (think car obstructing as it drives through)
* Degrade gracefully upon laser failure

[Post sample request/responses]

mention this: decision to embed postion guestimation and obstruction management into sensor node rather providing a friendly, soothed telemetry reading rather than provide a raw reading and have clients work out provide their own gate domain knowledge.


## Testing: the mock gate

I built a fake gate for testing purposes.

I went travelling before finishing this project. I continued to development from abroad, but being away meant I didn't have access to the gate any longer. I had to find a way to test my prototype. Sensing yet another opportunity to learn electronics, I decided to build a mock gate in my room.

I gathered the following parts:

* An [Intel Edison](http://www.intel.com/content/www/us/en/do-it-yourself/edison.html)
* A [Sparkfun Motor block](https://www.sparkfun.com/products/13043) (breakout to a [TB6612FNG](https://www.sparkfun.com/datasheets/Robotics/TB6612FNG.pdf) chip)
* A [Sparkfun Base block](https://www.sparkfun.com/products/13045)
* A [Sparkfun GPIO block](https://www.sparkfun.com/products/13038)
* A unipolar stepper motor. (I didn't yet know the what unipolar meant when I got it)
* A basic [XY-MK-5V](http://www.plexishop.it/en/review/product/list/id/3688/category/313/) radio transmitter
* What seems like a bike rack, found on the street, to provide a structure

## Notes on learning electronics
* Negative to ground?
* http://microrobotics.co.uk/doc/pdf/D003_4-20mA_Inputs_App_Note.pdf
* oscilloscope use was cruicial for certitude, productivity


### PCB
<!-- insert bullet point of success points -->
* spongex better than metal sponge, use metal sponge for first pass on failed board
* double/triple print
* * dont use coton swabs, too many fibers get stuck around

#### useful:
* https://web.archive.org/web/20080827214718/http://www.mrdwab.com/john/How-to-make-PCBs.html
* http://www.instructables.com/id/Toner-transfer-no-soak-high-quality-double-sided/?ALLSTEPS
* http://www.msarnoff.org/pcb/

#### Coating
* http://www.electronics-project-design.com/ConformalCoating.html


## Assembly
Access to a workshop helped, pictures [LINK] are the best record.

## Notes on learning firmware development
http://homepages.inf.ed.ac.uk/dts/pm/Papers/nasa-c-style.pdf

## Notes on using the xport (spin this)
* fun with linux serial stack and how a what a linux driver looks like
* apis not so great, termio vs termios vs tty_ioctl, ...
* SDK well orgarnized, setup worked well, documentation pretty good.

## Notes on how Riot OS works (spin this)
* add explenations as to how riot works, diagrams. ex network layer, threads, processes


@@@ GET BACK TO THIS
- using stat tools was great to charactirize signal.
- shows histogram screenshots, console
- Code todo: add message signing to gate requests

## Photos
There was some photographic record, [check it out](https://picasaweb.google.com/104618138749013524886/GateProject?authuser=0&feat=directlink)

<% content_for :footer do %>
  <br>
	<div data-google-album-id="6135261418453095361">
    <p>Loading images ...</p>
    <p>
      Images are hosted on Google Picassa. If you can read this then it may be blocked by your privacy blocker
    </p>
  </div>
<% end  %>