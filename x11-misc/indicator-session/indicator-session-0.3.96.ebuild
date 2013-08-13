# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils

DESCRIPTION="Session indicator"
HOMEPAGE="https://launchpad.net/indicator-session"
SRC_URI="http://launchpad.net/${PN}/0.4/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls policykit static-libs"

RDEPEND="
	app-admin/packagekit-base
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libdbusmenu:3[gtk]
	dev-libs/libindicator:3
	policykit? ( sys-auth/polkit )
	virtual/udev[gudev]
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i 's/-Werror//' src/Makefile.in

	autotools-utils_src_prepare
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

