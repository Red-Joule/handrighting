// GenData.cpp

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/ml/ml.hpp>

#include <iostream>
#include <vector>

// global variables ///////////////////////////////////////////////////////////////////////////////
const int MIN_CONTOUR_AREA = 1000;

const int RESIZED_IMAGE_WIDTH = 20;
const int RESIZED_IMAGE_HEIGHT = 30;

///////////////////////////////////////////////////////////////////////////////////////////////////
int main(int argc, char const *argv[]) 
{
    cv::Mat imgTrainingNumbers;         // input image
	cv::Mat imgTrainingNumbersDisplay;  // copy for display
    cv::Mat imgGrayscale;               // 
    cv::Mat imgBlurred;                 // declare various images
    cv::Mat imgThresh;                  //
    cv::Mat imgThreshCopy;              //
    cv::Mat imgThreshDisplay;           // copy for display

    // Take the training image filename as an input argument to facilitate training
	if(argc < 3){
		std::cout << "Enter an image filename as a parameter." << std::endl;
		std::cout << "Example: GenData training_chars.png A" << std::endl;
		return 1;
	}
    std::string training_image = argv[1];
    int training_letter_ascii = argv[2][0];
    imgTrainingNumbers = cv::imread(training_image); // read in training numbers image



    std::vector<std::vector<cv::Point> > ptContours;        // declare contours vector
    std::vector<cv::Vec4i> v4iHierarchy;                    // declare contours hierarchy

    cv::Mat matClassificationInts;      // training classifications
    cv::Mat matTrainingImagesAsFlattenedFloats; // training images

	// First, read in any existing classifications and images

	cv::FileStorage fsClassificationsInit("classifications.xml", cv::FileStorage::READ);
    if (fsClassificationsInit.isOpened() == false) {               // if the file was not opened successfully
        std::cout << "Creating new classifications.xml as one was not found." << std::endl;    // show message
    } else {
		fsClassificationsInit["classifications"] >> matClassificationInts;      // read classifications section into Mat classifications 
		fsClassificationsInit.release();                                        // close the classifications file
	}
	cv::FileStorage fsImagesInit("images.xml", cv::FileStorage::READ);
    if (fsImagesInit.isOpened() == false) {               // if the file was not opened successfully
        std::cout << "Creating new images.xml as one was not found" << std::endl;    // show message
    } else {
		fsImagesInit["images"] >> matTrainingImagesAsFlattenedFloats;      // read classifications section into Mat classifications 
		fsImagesInit.release();                                        // close the classifications file
	}


    std::vector<int> intValidChars = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                                       'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
                                       'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
                                       'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 
									   'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 
									   'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 
									   'y', 'z' };


    if (imgTrainingNumbers.empty()) {                               // if unable to open image
        std::cout << "error: image not read from file\n\n";         // show error message on command line
        return(0);                                                  // and exit program
    }

    cv::cvtColor(imgTrainingNumbers, imgGrayscale, CV_BGR2GRAY);        // convert to grayscale

    cv::GaussianBlur(imgGrayscale,              // input image
        imgBlurred,                             // output image
        cv::Size(5, 5),                         // smoothing window width and height in pixels
        0.25);                                  // sigma value, determines how much the image will be blurred, zero makes function choose the sigma value

                                                // filter image from grayscale to black and white
    cv::adaptiveThreshold(imgBlurred,           // input image
        imgThresh,                              // output image
        255,                                    // make pixels that pass the threshold full white
        cv::ADAPTIVE_THRESH_GAUSSIAN_C,         // use gaussian rather than mean, seems to give better results
        cv::THRESH_BINARY_INV,                  // invert so foreground will be white, background will be black
        11,                                     // size of a pixel neighborhood used to calculate threshold value
        2);                                     // constant subtracted from the mean or weighted mean

	imgThreshDisplay = imgThresh.clone();	
	resize(imgThreshDisplay, imgThreshDisplay, cv::Size(imgThreshDisplay.cols/3, imgThreshDisplay.rows/3));
    cv::imshow("imgThresh", imgThreshDisplay);         // show threshold image for reference

    imgThreshCopy = imgThresh.clone();          // make a copy of the thresh image, this in necessary b/c findContours modifies the image

    cv::findContours(imgThreshCopy,             // input image, make sure to use a copy since the function will modify this image in the course of finding contours
        ptContours,                             // output contours
        v4iHierarchy,                           // output hierarchy
        cv::RETR_EXTERNAL,                      // retrieve the outermost contours only
        cv::CHAIN_APPROX_SIMPLE);               // compress horizontal, vertical, and diagonal segments and leave only their end points

    bool found_one = false;
    for (int i = 0; i < ptContours.size(); i++) {                           // for each contour
        if (cv::contourArea(ptContours[i]) > MIN_CONTOUR_AREA && !found_one) {                // if contour is big enough to consider
            cv::Rect boundingRect = cv::boundingRect(ptContours[i]);                // get the bounding rect

            cv::rectangle(imgTrainingNumbers, boundingRect, cv::Scalar(0, 0, 255), 2);      // draw red rectangle around each contour as we ask user for input

            cv::Mat matROI = imgThresh(boundingRect);           // get ROI image of bounding rect

            cv::Mat matROIResized;
            cv::resize(matROI, matROIResized, cv::Size(RESIZED_IMAGE_WIDTH, RESIZED_IMAGE_HEIGHT));     // resize image, this will be more consistent for recognition and storage

            cv::imshow("matROI", matROI);                               // show ROI image for reference
            cv::imshow("matROIResized", matROIResized);                 // show resized ROI image for reference
            imgTrainingNumbersDisplay = imgTrainingNumbers.clone(); 
            resize(imgTrainingNumbersDisplay, imgTrainingNumbersDisplay, cv::Size(imgTrainingNumbersDisplay.cols/2, imgTrainingNumbersDisplay.rows/2));
            cv::imshow("imgTrainingNumbers", imgTrainingNumbersDisplay);       // show training numbers image, this will now have red rectangles drawn on it

            //WILL HAVE TO CHANGE THIS WHEN WE AUTOMATE
            // int intChar = cv::waitKey(0);           // get key press
            int intChar = training_letter_ascii;

            if (intChar == 27) {        // if esc key was pressed
                return(0);              // exit program
            } else if (std::find(intValidChars.begin(), intValidChars.end(), intChar) != intValidChars.end()) {     // else if the char is in the list of chars we are looking for . . .
                found_one = true;
                matClassificationInts.push_back(intChar);       // append classification char to integer list of chars

                cv::Mat matImageFloat;                          // now add the training image (some conversion is necessary first) . . .
                matROIResized.convertTo(matImageFloat, CV_32FC1);       // convert Mat to float

                cv::Mat matImageFlattenedFloat = matImageFloat.reshape(1, 1);       // flatten

                matTrainingImagesAsFlattenedFloats.push_back(matImageFlattenedFloat);       // add to Mat as though it was a vector, this is necessary due to the
                                                                                            // data types that KNearest.train accepts
            }   // end if
        }   // end if
    }   // end for

    std::cout << "training complete\n\n";

                // save classifications to file ///////////////////////////////////////////////////////


    cv::FileStorage fsClassifications("classifications.xml", cv::FileStorage::WRITE);           // open the classifications file

    if (fsClassifications.isOpened() == false) {                                                        // if the file was not opened successfully
        std::cout << "error, unable to open training classifications file, exiting program\n\n";        // show error message
        return(0);                                                                                      // and exit program
    }

    fsClassifications << "classifications" << matClassificationInts;        // write classifications into classifications section of classifications file
    fsClassifications.release();                                            // close the classifications file

    // save training images to file ///////////////////////////////////////////////////////

    cv::FileStorage fsTrainingImages("images.xml", cv::FileStorage::WRITE);         // open the training images file

    if (fsTrainingImages.isOpened() == false) {                                                 // if the file was not opened successfully
        std::cout << "error, unable to open training images file, exiting program\n\n";         // show error message
        return(0);                                                                              // and exit program
    }

    fsTrainingImages << "images" << matTrainingImagesAsFlattenedFloats;         // write training images into images section of images file
    fsTrainingImages.release();                                                 // close the training images file

    return(0);
}
