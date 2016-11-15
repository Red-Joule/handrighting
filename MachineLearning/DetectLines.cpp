// From http://stackoverflow.com/questions/23506105/extracting-text-opencv
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <iostream>

using namespace cv;
using namespace std;

#define OUTPUT_FOLDER_PATH      string("")
#define RECT_HEIGHT 8
#define RECT_WIDTH 8

int main(int argc, char* argv[])
{
	// Accept parameter for file name
	if(argc < 2){
		std::cout << "Enter an image filename as a parameter." << endl;
		return 1;
	}
	std::string inputFile = argv[1];
    Mat large = imread(inputFile);
    Mat rgb;

    // downsample and use it for processing
    pyrDown(large, rgb);
    Mat small;
    cvtColor(rgb, small, CV_BGR2GRAY);

    // morphological gradient
    Mat grad;
    Mat morphKernel = getStructuringElement(MORPH_ELLIPSE, Size(3, 3));
    morphologyEx(small, grad, MORPH_GRADIENT, morphKernel);

    // binarize
    Mat bw;
    threshold(grad, bw, 0.0, 255.0, THRESH_BINARY | THRESH_OTSU);

    // connect horizontally oriented regions
    Mat connected;
    morphKernel = getStructuringElement(MORPH_RECT, Size(150, 5));
    /* morphKernel = getStructuringElement(MORPH_RECT, Size(150, 1)); */
    morphologyEx(bw, connected, MORPH_CLOSE, morphKernel);

    // find contours
    Mat mask = Mat::zeros(bw.size(), CV_8UC1);
    vector<vector<Point>> contours;
    vector<Vec4i> hierarchy;
    findContours(connected, contours, hierarchy, CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE, Point(0, 0));

    // filter contours
    for(int idx = 0; idx >= 0; idx = hierarchy[idx][0])
    {
        Rect rect = boundingRect(contours[idx]);
        Mat maskROI(mask, rect);
        maskROI = Scalar(0, 0, 0);

        // fill the contour
        drawContours(mask, contours, idx, Scalar(255, 255, 255), CV_FILLED);

        // ratio of non-zero pixels in the filled region
        double r = (double)countNonZero(maskROI)/(rect.width*rect.height);

        if (r > .25 /* assume at least 45% of the area is filled if it contains text */
            && 
            (rect.height > RECT_HEIGHT && rect.width > RECT_WIDTH) /* constraints on region size */
            /* these two conditions alone are not very robust. better to use something 
            like the number of significant peaks in a horizontal projection as a third condition */
            )
        {
            rectangle(rgb, rect, Scalar(0, 255, 0), 2);
        }
    }
    imwrite(OUTPUT_FOLDER_PATH + string("rgb.jpg"), rgb);
	cv::Mat imgout = cv::imread(inputFile);
	resize(imgout, imgout, Size(imgout.cols/2,imgout.rows/2));
	namedWindow( "Display Frame",CV_WINDOW_AUTOSIZE);
	cv::imshow("output", rgb);
	int intChar = cv::waitKey(0);           // get key press

    return 0;
}
