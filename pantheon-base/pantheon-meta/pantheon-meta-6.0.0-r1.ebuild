# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pantheon DE meta package"
HOMEPAGE="https://elementary.io/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"
IUSE="accessibility archive bluetooth cups networkmanager +minimal pulseaudio upower"

#pantheon-base/switchboard-plug-security-privacy
DEPEND=""
RDEPEND="${DEPEND}
	accessibility? (
		pantheon-base/switchboard-plug-a11y
		pantheon-base/wingpanel-indicator-a11y
	)
	bluetooth? (
		pantheon-base/switchboard-plug-bluetooth
		pantheon-base/wingpanel-indicator-bluetooth
	)
	cups? (
		pantheon-base/switchboard-plug-printers
		pantheon-extra/contract-print
	)
	!minimal? (
		pantheon-extra/pantheon-calculator
		pantheon-extra/pantheon-calendar
		pantheon-extra/pantheon-camera
		app-editors/pantheon-code
		pantheon-extra/pantheon-music
		pantheon-extra/pantheon-photos
		pantheon-extra/pantheon-screenshot
		pantheon-extra/pantheon-videos
	)
	networkmanager? (
		pantheon-base/switchboard-plug-network
		pantheon-base/wingpanel-indicator-network
	)
	>=pantheon-base/pantheon-files-6.0.0
	>=pantheon-base/pantheon-greeter-6.0.0
	>=pantheon-base/pantheon-shell-6.0.0[accessibility?]
	pantheon-base/switchboard-plug-about
	pantheon-base/switchboard-plug-applications
	pantheon-base/switchboard-plug-datetime
	pantheon-base/switchboard-plug-display
	pantheon-base/switchboard-plug-keyboard
	pantheon-base/switchboard-plug-mouse-touchpad
	pantheon-base/switchboard-plug-notifications
	pantheon-base/switchboard-plug-pantheon-shell
	pantheon-base/switchboard-plug-parental-controls
	pantheon-base/switchboard-plug-sharing
	pantheon-base/switchboard-plug-useraccounts
	pantheon-base/wingpanel-indicator-datetime
	pantheon-base/wingpanel-indicator-keyboard
	pantheon-base/wingpanel-indicator-notifications
	pantheon-base/wingpanel-indicator-session
	pulseaudio? (
		pantheon-base/switchboard-plug-sound
		pantheon-base/wingpanel-indicator-sound
	)
	upower? (
		pantheon-base/switchboard-plug-power
		pantheon-base/wingpanel-indicator-power
	)
	virtual/notification-daemon[pantheon]
	x11-misc/lightdm
	x11-terms/pantheon-terminal
"
