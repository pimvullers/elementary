# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils autotools-utils

DESCRIPTION="The Power Indicator"
HOMEPAGE="http://launchpad.net/indicator-power"
SRC_URI="http://launchpad.net/${PN}/12.10/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libindicator:3
	gnome-base/gnome-settings-daemon
	sys-power/upower
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}/${P}-elementaryos.patch"
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

