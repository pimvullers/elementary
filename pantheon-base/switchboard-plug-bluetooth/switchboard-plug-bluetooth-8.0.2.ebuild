# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Switchboard plug to setup bluetooth devices"
HOMEPAGE="https://github.com/elementary/settings-bluetooth"
SRC_URI="https://github.com/elementary/settings-bluetooth/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/settings-bluetooth-${PV}"

LICENSE="LGPL-2.1"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	pantheon-base/switchboard:3
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	>=pantheon-base/bluetooth-daemon-1.1.0
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
