# Console Image Browser (cib) - An interactive wrapper for viewing images in the terminal

Console Image Browser is a small script wrapper around the [Terminal Image Viewer](https://github.com/stefanhaustein/TerminalImageViewer) and [catimg](https://github.com/posva/catimg/) utilities that lets you quickly view and browse through images on the command-line.

![cib](https://user-images.githubusercontent.com/9295750/62556313-72297400-b829-11e9-8339-4b934dac4a10.gif)

## Requirements

* image_size gem for printing image dimensions
  * install with: `gem install image_size`
* Terminal Image Viewer
  * available from: https://github.com/stefanhaustein/TerminalImageViewer
  * make sure that the command `tiv` is in your path
* catimg
  * available directly from most package managers or [compile from source](https://github.com/posva/catimg/)

## Supported formats

* JPG, PNG, TIF, BMP: via Terminal Image Viewer
* GIF: via catimg

Note: Terminal Image Viewer is also nominally capable of handling (non-animated) GIFs, but in practice the conversion tends to lock up the terminal, so the much faster catimg is used instead. However, due to the nature of animated GIFs, it is only possible to view them by specifying a single filename directly, as they cannot be included in the regular browsing interface.

## Installation

Make sure you have installed Terminal Image Viewer (and imgcat if you would like to view animated GIFs) and the other requirements. Download or clone the repository. Open the project directory in a terminal and type

    ./cib.rb

Console Image Browser can be run from its own folder without any special installation (see [invocation](#invocation) section below for details, or if desired it can also be added to your path by copying `cib.rb` to the relevant directory.

## Usage

To run Console Image Browser in any directory, just type:

    /path/to/cib

This will start the program and begin browsing all images in the folder (if any). _Note: The following examples will assume that you are entering commands from within the project directory._

The directory to browse can also be specified as an argument:

    ./cib.rb ~/Pictures

A single image can be viewed directly by specifying an image file instead of a directory:

    ./cib.rb ~/image.jpg

Animated GIF files can be viewed in the terminal by specifying them directly in the same way as above:

    ./cib.rb ~/image.gif

Once you have opened a directory of images to browse, navigation is controlled using a series of hotkeys, which are outlined in the [section below](#usage).

### Navigation

The following keys can be used to browse and view information about the images within the program:

* `n` or `right` or `down` or `PgDn`: Next image
* `p` or `left` or `up` or `PgUp`: Previous image
* `home`: First image
* `end`: Last image
* `b`: Browse all images in list / folder
* `1`-`0`: Quick access to the first 10 images in the folder or list (note that 0 represents the 10th image)
* `i`: Display some brief information about the image (namely, the filename, size, and dimensions)

## To do

Possible additional features for future development:

* Display online images given an image URL
* Browse all images on a page given a website URL
* Support for additional image formats
* Open image in default image viewer
* Show EXIF metadata

PRs, suggestions, and other contributions are welcome!

## Credits

This scripts relies heavily on [Terminal Image Viewer](https://github.com/stefanhaustein/TerminalImageViewer) by Stefan Haustein and [catimg](https://github.com/posva/catimg/) by Eduardo San Martin Morote.

Example images in demo are by [Luc Viatour](https://commons.wikimedia.org/wiki/User:Lviatour) from Wikimedia Commons.

## License

MIT.
