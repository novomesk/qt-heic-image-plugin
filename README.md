# qt-heic-image-plugin
Qt plug-in to allow Qt and KDE based applications to read/write HEIF/HEIC images. 

Requirements:
* Qt 5.14
* [libheif](https://github.com/strukturag/libheif) 1.10.0 optionally with
  * libde265 decoder - HEIC support
  * x265 encoder (built with 8bit and 10bit support)
  * openh264 decoder - AVCI support
  * x264 encoder
  * openjpeg - HEJ2 support

Code for download and compilation:
```
git clone --depth 1 https://github.com/novomesk/qt-heic-image-plugin.git
cd qt-heic-image-plugin
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
```
Code for installation (run as root):

`make install`
