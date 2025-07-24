# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Switchboard plug to setup bluetooth devices"
HOMEPAGE="https://github.com/elementary/switchboard-plug-bluetooth"
SRC_URI="https://github.com/elementary/switchboard-plug-bluetooth/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	pantheon-base/switchboard:3
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

S="${WORKDIR}/settings-bluetooth-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
