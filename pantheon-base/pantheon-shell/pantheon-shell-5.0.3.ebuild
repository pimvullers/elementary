# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Pantheon DE shell"
HOMEPAGE="https://github.com/elementary/session-settings"
SRC_URI="https://github.com/elementary/session-settings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	gnome-base/gnome-session
	gnome-base/gnome-settings-daemon
	pantheon-base/applications-menu
	pantheon-base/cerbere
	pantheon-base/wingpanel
	pantheon-extra/dpms-helper
	pantheon-extra/pantheon-agent-polkit
	x11-misc/plank
	x11-wm/gala
"

PDEPEND="
	pantheon-base/pantheon-settings
"

S="${WORKDIR}/session-settings-${PV}"

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/pantheon.session-${PV}.patch"

	# Correct paths
	sed -i 's#/usr/lib/[^/]*/#/usr/libexec/#' autostart/*
}

src_install() {
	insinto /usr/share/gnome-session/sessions
	doins gnome-session/*

	insinto /usr/share/xsessions
	doins xsessions/*

	insinto /etc/xdg/autostart
	doins autostart/*

	insinto /usr/share/pantheon
	doins -r applications

	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}/Pantheon"

	dobin "${FILESDIR}/pantheon-session"
}
