To install this overlay using Layman (app-portage/layman, http://layman.sourceforge.net) run the following command:

    layman -a elementary

Updating is easy, just run:

    layman -s elementary

or to update all overlays managed by layman:

    layman -S

Otherwise, if you do not want to use layman, clone this repository by running the following command:

    git clone git://github.com/pimvullers/elementary.git

and add the path to the PORTDIR_OVERLAY variable in your make.conf file. To update just run 

    git pull

in the directory that has just been created.
