# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Switchboard plug to setup bluetooth devices"
HOMEPAGE="https://github.com/elementary/switchboard-plug-bluetooth"
SRC_URI="https://github.com/elementary/switchboard-plug-bluetooth/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="amd64"

RDEPEND="
	!pantheon-base/switchboard-plug-bluetooth:0
	dev-libs/glib:2
	dev-libs/granite:0
	pantheon-base/switchboard:2
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
