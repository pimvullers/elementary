# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit gnome2-utils vala cmake-utils bzr

DESCRIPTION="Awesome RSS reader"
HOMEPAGE="https://launchpad.net/feedler"
EBZR_REPO_URI="lp:feedler"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-db/sqlheavy:0.1
	>=dev-libs/libindicate-0.6.90:3
	dev-libs/libdbusmenu[gtk]
	dev-libs/libxml2
	dev-libs/libunity
	net-libs/libsoup
	net-libs/webkit-gtk:3
	x11-libs/granite
    x11-libs/gtk+:3
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING )
}

src_prepare() {
	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
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

