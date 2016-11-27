# handrighting

if errors when cloning:
  1. open ~/.gitconfig file
  2. delete: 
    [filter "lfs"]
      clean = git lfs clean %f
      smudge = git lfs smudge %f
      required = true
  3. rm -rf original clone
  4. try cloning again

You need to download the OpenCV framework locally, as the git clone does not have full file.

### Install OpenCV so you can compile cpp on Mac:
http://blogs.wcode.org/2014/10/howto-install-build-and-use-opencv-macosx-10-10/

### alias for cmake
alias runcmake="/Applications/CMake.app/Contents/bin/cmake ."


######
How to train data


1) cd MachineLearning
1-b) pre: if that has been run before, you need to delete the classifications.xml and images.xml files
2) runcmake
3) make
4) ./GenData
5) follow the prompts to test the data
6) ./TrainAndTest