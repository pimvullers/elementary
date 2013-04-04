# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit fdo-mime gnome2-utils vala cmake-utils bzr

DESCRIPTION="An IDE with a light GUI, based on CMake"
HOMEPAGE="https://launchpad.net/euclide"
EBZR_REPO_URI="lp:euclide"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/libgee
	dev-libs/libpeas[gtk]
	dev-libs/libxml2:2
	x11-libs/granite
	app-editors/scratch
	x11-libs/gtk+:3
	x11-libs/gtksourceview:3.0[introspection]"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-sourceview.patch"
	epatch "${FILESDIR}/${P}-scratch-text-editor.patch"

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
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

