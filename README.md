# Elementary OS experience for Gentoo

## Installing the overlay

### Manually

To install this overlay using Portage's built-in repos.conf mechanism, be sure the repos.conf directory exists:
> `mkdir -p /etc/portage/repos.conf`

Then get the elementary.conf file from the base of this repository:
> `wget https://raw.githubusercontent.com/pimvullers/elementary/master/elementary.conf -O /etc/portage/repos.conf/elementary.conf`

Finallty use `emaint` to sync the repo:
> `emaint sync -r elementary`

### Using eselect

To install this overlay using eselect ([app-eselect/eselect-repository](https://packages.gentoo.org/packages/app-eselect/eselect-repository)) run the following command:
> `eselect repository enable elementary`

Then use `emaint` to sync the repo:
> `emaint sync -r elementary`

### Using Layman

To install this overlay using Layman ([app-portage/layman](https://packages.gentoo.org/packages/app-portage/layman)) run the following command:
> `layman -a elementary`

To keep your checkout of the elementary overlay up-to-date run:
> `layman -s elementary`

Alternatively, to update all overlays managed by layman run:
> `layman -S`

## Installing the Pantheon desktop environment

Just install the meta package to pull in all required packages (you can tweak using USE flags):
> `emerge -va pantheon-meta`

## Reporting bugs/issues

For installation issues, and Gentoo integration problems, please use this repository's [issues page](https://github.com/pimvullers/elementary/issues).

For other issues, please report them in the [upstream repositories](https://github.com/elementary/).
