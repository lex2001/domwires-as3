##CrazyFM-Extensions
CrazyFM framework can be extended with different stuff.
Extension is an individual project, that has its own test build configuration.
To use extension in your project based on CrazyFM framework, all you have to do is to add extension compiled SWC or define its source path.
All extensions automatically compile if run CrazyFM global build configuration, which can be found in the root of the project.
By default, compiled SWCs of extensions can be found here:
- [crazyfm/dependencies/crazyfm/](../dependencies/crazyfm)
 
###Creating extension guidelines
The main goal is to keep framework clean, documented and tested.
That's why new extension should apply all the rules:

* Your extension must have clean well-formatted code.
* It must have unit tests.
* It should be commented and contain AsDocs.
* It should contain README.md description.
* It should contain build configuration.
* It should be added to framework global build configuration.
 
Too tough? Don't worry, you can always ask for advice and together we will try to solve all the problems and fill the gaps :) 