# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Power indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/panel-power"
SRC_URI="https://github.com/elementary/panel-power/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	gnome-base/libgtop:2
	pantheon-base/wingpanel
	virtual/libudev
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

S="${WORKDIR}/panel-power-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
