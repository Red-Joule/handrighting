# handrighting

## To build and run the app

1. Use Mac OS X
2. Install XCode 7.3
3. Install OpenCV 2.4 with opencv_contrib extras (follow instructions below) (install dependencies as needed)
  ### Install OpenCV so you can compile cpp on Mac:
  http://blogs.wcode.org/2014/10/howto-install-build-and-use-opencv-macosx-10-10/

4. Load handwriting as a new project in XCode
5. Run in simulator

OR 

1. Download .ipa located in the folder handrighting_2016-12-11_17-47-47
2. Open up iTunes on your computer, and navigate to the "Apps" section
3. Drag and drop the .ipa file into the "Library"
4. Plug your iPhone into your computer
5. Go to the Device's>Apps section in iTunes, and click "Install" next to handrighting, and then click "Apply"
6. The app should be running on your iPhone now
(https://www.youtube.com/watch?v=Dib1HSTk1dA)


## To run the testbench
1. in terminal, cd into MachineLearning 
2. run 'make' so that you have the ./TrainAndTest binary file in MachineLearning
3. make sure you have python 3+ installed on your computer
4. run 'python testbench.py' 
