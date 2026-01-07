# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Control system power consumption using Switchboard."
HOMEPAGE="https://github.com/elementary/settings-power"
SRC_URI="https://github.com/elementary/settings-power/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/settings-power-${PV}"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	!pantheon-base/switchboard-plug-power:0
	dev-libs/glib:2
	dev-libs/granite:7
	pantheon-base/switchboard:3
	sys-apps/dbus
	sys-auth/polkit
	gui-libs/gtk:4
	gui-libs/libadwaita:1
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
}
