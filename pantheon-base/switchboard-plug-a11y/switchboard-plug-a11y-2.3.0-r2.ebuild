# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Switchboard Universal Access Plug"
HOMEPAGE="https://github.com/elementary/switchboard-plug-a11y"
SRC_URI="https://github.com/elementary/switchboard-plug-a11y/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	!pantheon-base/switchboard-plug-a11y:0
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
