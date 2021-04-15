There are many ways to contribute.

# Software Testing
Currently there isn't any CI system and with the increasing number of apps there is always the need to test on different or new hardware. Pick some hardware. Try installing the system onto it.
 * Are the instructions clear enough?
 * Were there any failures during the install?
 * Do any of the apps fail?
Reporting any failures, either as issues or by any other method is very useful.

# Physical Testing
Testing of the mesh system in various environments. What's the maximum range for a given wifi adapter? What type of cantennas or reflectors work best on an ultra-low budget? Which wifi adapters have free software drivers? What are the simplest antenna designs which are quickest to make? Perhaps antenna advice or example deployment descriptions could be part of the documentation.

# Documentation
 * Improving descriptions of processes or apps
 * Fixing spelling or typos
 * Adding any documentation which might be missing
 * Better screenshots for apps
 * Translations for the website, within the *doc* subdirectory.
 * Translations of the manpages with the *man* subdirectory.

# Artwork
The project doesn't have much of this. There are some desktop backgrounds within the *img/backgrounds* subdirectory which could be improved. Cute mascots and things like that can also help to attract interest. The mesh variant of the system has desktop icons which could also be better.

# Security Auditing
Looking for any obvious security mistakes, doing pentesting on an installed test system and reporting the results would be useful. There are already many STIG tests in the *tests* subdirectory, but having more wouldn't hurt.

# Campaigning
Ensuring that the internet doesn't become far less neutral than it already is. Encouraging ISPs not to have policies which ban people from running servers. Promoting and raising awareness that self-hosting is a thing which is actually useful. All of these activities are incredibly important to allow self-hosting to remain a viable possibility. ISPs are the bottleneck, and if they implement bad government mandated policies then it may become no longer practical or legal to run your own internet systems on your own hardware in your own home.

# Adding more apps or maintaining existing ones
Typically apps are pegged to a known good commit. One useful thing is to try recent commits and see if the app installs successfully. Do any new packages need to be installed, or old ones removed? See the developer's guide for how to add new apps to the system.

# Code Audit
It's all just bash scripts and the more eyeballs on it the more likely that mistakes will be found and fixed.

# Blogging
Just blogging about the project can help to inform people that decentralised systems exist and that they don't need to be trapped in the cloud services of $bigcorp. Even if you find some aspect of the project which sucks badly, blogging about it is one way to provide feedback which could lead to future improvements being made.
