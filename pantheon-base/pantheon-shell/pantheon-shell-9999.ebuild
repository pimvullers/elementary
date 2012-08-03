# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit bzr

DESCRIPTION="Elementary's desktop environment"
HOMEPAGE="http://www.elementaryos.org/ http://launchpad.net/elementaryos/"
EBZR_REPO_URI="lp:~elementary-os/elementaryos/pantheon-xsession-settings"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libnotify lightdm"

CDEPEND="
	lightdm? ( x11-misc/lightdm pantheon-base/pantheon-greeter )"
RDEPEND="${CDEPEND}
	gnome-base/gnome-session
	gnome-base/gnome-settings-daemon
	pantheon-base/cerbere
	pantheon-base/plank
	pantheon-base/slingshot
	pantheon-base/wingpanel
	x11-wm/gala
	libnotify? ( x11-misc/notify-osd )"
DEPEND="${CDEPEND}"

src_prepare() {
	# Use gnome as fallback instead of ubuntu
	sed -i 's/ubuntu/gnome/' debian/pantheon.session
}

src_install() {
	insinto /usr/share/gnome-session/sessions
	doins debian/pantheon.session

	insinto /usr/share/xsessions
	doins debian/pantheon.desktop
}

pkg_postinst() {
	if [ $(use lightdm) && -x /usr/lib/lightdm/lightdm-set-defaults ]; then
		/usr/lib/lightdm/lightdm-set-defaults --keep-old --session=pantheon
	fi
}

pkg_postrm() {
	if [ $(use lightdm) && -x /usr/lib/lightdm/lightdm-set-defaults ]; then
		/usr/lib/lightdm/lightdm-set-defaults --remove --session=pantheon
	fi
}

