// Links against the installed opencv_world and runs a few core/imgproc calls.
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <cstdio>

int main()
{
  cv::Mat img(64, 64, CV_8UC3, cv::Scalar(0, 128, 255));
  cv::Mat hsv, blur;
  cv::cvtColor(img, hsv, cv::COLOR_BGR2HSV);
  cv::GaussianBlur(hsv, blur, cv::Size(5, 5), 0);
  std::printf("OpenCV %s, pixel %d %d %d\n", CV_VERSION,
              blur.at<cv::Vec3b>(32, 32)[0], blur.at<cv::Vec3b>(32, 32)[1], blur.at<cv::Vec3b>(32, 32)[2]);
  return blur.size() == img.size() ? 0 : 1;
}
