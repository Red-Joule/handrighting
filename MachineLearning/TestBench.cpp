#include <iostream>
#include <sstream>
#include <string>
#include <dirent.h>

using std::cout;
using std::endl; 
using std::string;

int main(int argc, char const *argv[]) 
{

    // string test_image_location = "test_images";

    DIR *dir;
    struct dirent *ent;
    if ((dir = opendir ("test_images")) != NULL) {
      /* print all the files and directories within directory */
      while ((ent = readdir (dir)) != NULL) {
        string fname = ent->d_name;
        char str[]="1776ad";
        int year;
        year = atoi(str);
        printf ("The year that followed %d was %d.\n",year,year+1);
      }
      closedir (dir);
    } else {
      /* could not open directory */
      perror ("");
      return EXIT_FAILURE;
    }   
    return 0;
}