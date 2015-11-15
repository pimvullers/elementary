# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit fdo-mime gnome2-utils vala cmake-utils bzr

DESCRIPTION="Beautiful, fast, and simple note taking app in the style of
elementary"
HOMEPAGE="https://launchpad.net/footnote"
EBZR_REPO_URI="lp:footnote"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	dev-db/sqlheavy:0.1
	x11-libs/granite
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

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
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
