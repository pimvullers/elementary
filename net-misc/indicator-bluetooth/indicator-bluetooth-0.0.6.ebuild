# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils

DESCRIPTION="The bluetooth menu"
HOMEPAGE="https://launchpad.net/indicator-bluetooth"
SRC_URI="http://launchpad.net/${PN}/13.04/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libdbusmenu:3[gtk]
	dev-libs/libindicator:3
	>=net-wireless/gnome-bluetooth-3
	x11-libs/gtk+:3
	x11-libs/libido"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
 	local myeconfargs=(
 		$(use_enable nls)
 	)

 	autotools-utils_src_configure
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

