# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pantheon DE meta package"
HOMEPAGE="https://elementary.io/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"
IUSE="accessibility archive bluetooth cups networkmanager +minimal pulseaudio upower input_devices_wacom"

#pantheon-base/switchboard-plug-security-privacy
DEPEND=""
RDEPEND="${DEPEND}
	accessibility? (
		pantheon-base/switchboard-plug-a11y
		pantheon-base/wingpanel-indicator-a11y
	)
	bluetooth? (
		pantheon-base/switchboard-plug-bluetooth
		>=pantheon-base/wingpanel-indicator-bluetooth-2.1.8
	)
	cups? (
		pantheon-base/switchboard-plug-printers
		pantheon-extra/contract-print
	)
	input_devices_wacom? (
		pantheon-base/switchboard-plug-wacom
	)
	media-fonts/inter
	!minimal? (
		pantheon-extra/pantheon-calculator
		pantheon-extra/pantheon-calendar
		pantheon-extra/pantheon-camera
		>=app-editors/pantheon-code-6.0.0
		pantheon-extra/pantheon-mail
		pantheon-extra/pantheon-music
		pantheon-extra/pantheon-photos
		pantheon-extra/pantheon-screenshot
		pantheon-extra/pantheon-tweaks
		pantheon-extra/pantheon-videos
		pantheon-extra/shortcut-overlay
	)
	networkmanager? (
		pantheon-base/switchboard-plug-network
		>=pantheon-base/wingpanel-indicator-network-2.3.0
	)
	>=pantheon-base/pantheon-files-6.0.0
	>=pantheon-base/pantheon-greeter-6.0.0
	>=pantheon-base/pantheon-shell-6.0.0[accessibility?]
	>=pantheon-base/switchboard-6.0.0
	pantheon-base/switchboard-plug-about
	pantheon-base/switchboard-plug-applications
	pantheon-base/switchboard-plug-datetime
	pantheon-base/switchboard-plug-display
	pantheon-base/switchboard-plug-keyboard
	pantheon-base/switchboard-plug-locale
	pantheon-base/switchboard-plug-mouse-touchpad
	pantheon-base/switchboard-plug-notifications
	pantheon-base/switchboard-plug-onlineaccounts
	pantheon-base/switchboard-plug-pantheon-shell
	pantheon-base/switchboard-plug-parental-controls
	pantheon-base/switchboard-plug-security-privacy
	pantheon-base/switchboard-plug-sharing
	pantheon-base/switchboard-plug-useraccounts
	pantheon-base/wingpanel
	>=pantheon-base/wingpanel-indicator-datetime-2.3.0
	>=pantheon-base/wingpanel-indicator-keyboard-2.4.0
	>=pantheon-base/wingpanel-indicator-nightlight-2.1.0
	>=pantheon-base/wingpanel-indicator-notifications-6.0.0
	>=pantheon-base/wingpanel-indicator-session-2.3.0
	pulseaudio? (
		pantheon-base/switchboard-plug-sound
		>=pantheon-base/wingpanel-indicator-sound-6.0.0
	)
	upower? (
		pantheon-base/switchboard-plug-power
		>=pantheon-base/wingpanel-indicator-power-6.1.0
	)
	virtual/notification-daemon[pantheon]
	x11-misc/lightdm
	>=x11-terms/pantheon-terminal-6.0.0
"
#	!minimal? ( pantheon-extra/pantheon-tasks )

