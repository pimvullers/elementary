# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bzr

DESCRIPTION="Elementary's desktop environment"
HOMEPAGE="http://www.elementaryos.org/ http://launchpad.net/elementaryos/"
EBZR_REPO_URI="lp:~elementary-os/elementaryos/pantheon-xsession-settings-luna"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+lightdm +screensaver"

CDEPEND="
	lightdm? ( >=pantheon-base/pantheon-greeter-1.0 )"
RDEPEND="${CDEPEND}
	>=gnome-base/gnome-session-3.0
	<gnome-base/gnome-session-3.10
	>=gnome-base/gnome-settings-daemon-3.0
	<gnome-base/gnome-settings-daemon-3.10
	>=pantheon-base/cerbere-0.2
	pantheon-base/plank
	>=pantheon-base/slingshot-0.7
	>=pantheon-base/wingpanel-0.2
	pantheon-base/pantheon-settings
	x11-themes/elementary-theme
	x11-wm/gala
	screensaver? ( || ( x11-misc/light-locker gnome-extra/gnome-screensaver x11-misc/xscreensaver ) )"
DEPEND="${CDEPEND}"

src_prepare() {
	# Use gnome as fallback instead of ubuntu and mutter instead of gala
	sed -i -e 's/ubuntu/gnome/' -e 's/gala/mutter/' debian/pantheon.session

	# Use gnome-session wrapper that sets XDG_CURRENT_DESKTOP
	sed -i 's/gnome-session --session=pantheon/pantheon-session/' debian/pantheon.desktop

	# Correct paths
	sed -i 's#/usr/lib/[^/]*/#/usr/libexec/#' autostart/*
}

src_install() {
	insinto /usr/share/gnome-session/sessions
	doins debian/pantheon.session

	insinto /usr/share/xsessions
	doins debian/pantheon.desktop

	insinto /etc/xdg/autostart
	doins autostart/*

	insinto /usr/share/gconf
	doins gconf/*

	insinto /usr/share/pantheon
	doins -r applications

	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}/Pantheon"

	dobin "${FILESDIR}/pantheon-session"
}

pkg_postinst() {
	use lightdm && \
	  /usr/libexec/lightdm/lightdm-set-defaults --keep-old --session=pantheon
}

pkg_postrm() {
	use lightdm && \
	  /usr/libexec/lightdm/lightdm-set-defaults --remove --session=pantheon
}
