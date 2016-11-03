## Getting Pantheon

### Via Layman

To install this overlay using Layman ([app-portage/layman](https://packages.gentoo.org/packages/app-portage/layman)) run the following command: `layman -a elementary`

To keep your checkout of the elementary overlay up-to-date run: `layman -s elementary`

Alternatively, to update all overlays managed by layman run: `layman -S`

### Via Portage's repos.conf

To install this overlay using Portage's built in repos.conf, be sure the repos.conf directory exists: `mkdir -p /etc/portage/repos.conf`

Then wget the elementary.conf file in the base of the repository: `wget https://raw.githubusercontent.com/pimvullers/elementary/master/elementary.conf -O /etc/portage/repos.conf/elementary.conf`

Then use `emaint` to sync the repo: `emaint sync -r elementary`

## Want to chat?

We have opened the [#gentoo-pantheon](https://webchat.freenode.net/?channels=gentoo-pantheon) channel on the Freenode IRC network. This is NOT a place to report issues (go [here](https://github.com/pimvullers/elementary/issues) for that), but it is a place for community to gather and discussion to take place.
