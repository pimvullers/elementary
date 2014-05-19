# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit gnome2-utils vala cmake-utils

DESCRIPTION="A lightweight and stylish app launcher for Pantheon and other DEs"
HOMEPAGE="http://launchpad.net/slingshot"
SRC_URI="http://launchpad.net/${PN}/0.x/${PV}/+download/${PN}-launcher-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls -zeitgeist"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0
	gnome-base/gnome-menus:3
	<x11-libs/granite-0.3
	>=x11-libs/gtk+-3.2:3
	zeitgeist? ( gnome-extra/zeitgeist )"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${PN}-launcher-${PV}"
DOCS=( "${S}/AUTHORS" "${S}/COPYING" )

src_prepare() {
	epatch "${FILESDIR}/${P}-zeitgeist-2.patch"
	epatch "${FILESDIR}/${P}-optional.patch"
	epatch "${FILESDIR}/${P}-gnome-menus-3.patch"
	epatch_user

	use nls || sed -i -e '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DICONCACHE_UPDATE=OFF
		-DUSE_UNITY=OFF
		-DVALA_EXECUTABLE="${VALAC}"
		$(cmake-utils_use_use zeitgeist ZEITGEIST)
	)
	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
