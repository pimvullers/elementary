# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.22

inherit gnome2-utils meson vala

DESCRIPTION="Power indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-power"
SRC_URI="https://github.com/elementary/wingpanel-indicator-power/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	gnome-base/libgtop:2
	pantheon-base/wingpanel
	virtual/libudev
	x11-libs/bamf
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
