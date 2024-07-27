# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Control system power consumption using Switchboard."
HOMEPAGE="https://github.com/elementary/switchboard-plug-power"
SRC_URI="https://github.com/elementary/switchboard-plug-power/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	!pantheon-base/switchboard-plug-power:0
	pantheon-base/switchboard-plug-power-helper
	dev-libs/glib:2
	dev-libs/granite:0
	pantheon-base/switchboard:2
	sys-apps/dbus
	sys-auth/polkit
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}

src_install() {
	meson_src_install
	rm -r ${ED}/usr/libexec
	rm -r ${ED}/usr/share/dbus-1
}
