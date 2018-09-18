CUDA Stream Compaction
======================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 2**

* Yan Wu
  * [LinkedIn](https://www.linkedin.com/in/yan-wu-a71270159/)
* Tested on: Windows 10 Education, i7-8750H @ 2.2GHz 16GB, GTX 1060 6GB (Personal Laptop)

### Project Description

This project let us implement a few different versions of the Scan (Prefix Sum) algorithm. 
1. Implementing a CPU version of the algorithm. 
2. Writing a few GPU implementations: "naive" and "work-efficient." 
3. Using some of these to implement GPU stream compaction.

* [Algorithm Slides:](https://docs.google.com/presentation/d/1ETVONA7QDM-WqsEj4qVOGD6Kura5I6E9yqH-7krnwZ0/edit#slide=id.p126)
* Algorithm Demonstration:
  * Naive Inclusive Scan:<br />
  <img src="img/figure-39-2.jpg" width="70%">
  * Work Efficient Scan (up-sweep): <br />
  <img src="img/upSweep.PNG" width="70%">
  * Work Efficient Scan (down-sweep): <br />
  <img src="img/downSweep.PNG" width="70%">
  
### Result and Performance Analysis

* A sample of outcomes:
  * Scan Test: <br />
  <img src="img/scanTestsSample.PNG" width = "70%"> <br />
  * Stream Compaction Test: <br />
    <img src="img/CompactTestsSample.PNG" width = "70%">

Include analysis, etc. (Remember, this is public, so don't put
anything here that you don't want to share with the world.)

