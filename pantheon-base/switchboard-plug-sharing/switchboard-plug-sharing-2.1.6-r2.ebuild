# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.20

inherit meson vala

DESCRIPTION="Switchboard Sharing Plug"
HOMEPAGE="https://github.com/elementary/switchboard-plug-sharing"
SRC_URI="https://github.com/elementary/switchboard-plug-sharing/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="amd64"

RDEPEND="
	!pantheon-base/switchboard-plug-sharing:0
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
