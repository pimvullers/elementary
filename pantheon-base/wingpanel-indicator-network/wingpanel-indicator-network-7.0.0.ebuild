# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_VERSION=0.22

inherit gnome2-utils meson vala

DESCRIPTION="Network indicator for Wingpanel"
HOMEPAGE="https://launchpad.net/wingpanel-indicator-network"
SRC_URI="https://github.com/elementary/wingpanel-indicator-network/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	gnome-extra/nm-applet
	net-misc/networkmanager
	pantheon-base/wingpanel
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

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
