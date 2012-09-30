# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="Scratch is a text editor written for the Pantheon desktop"
HOMEPAGE="https://launchpad.net/scratch"
EBZR_REPO_URI="lp:scratch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls plugins"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0
	dev-libs/libpeas
	gnome-base/gconf:2
	plugins? ( 
		|| ( pantheon-base/pantheon-files pantheon-base/marlin ) 
		dev-util/devhelp
	)
	>=x11-libs/gtk+-3.4:3
	x11-libs/gtksourceview:3.0
	x11-libs/granite
	dev-libs/libzeitgeist
	plugins? ( x11-libs/vte:2.90 )"
DEPEND="${RDEPEND}
	dev-lang/vala:0.18
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( COPYING README )
}

src_prepare() {
	use nls || sed -i -e 's/add_subdirectory(po)//' CMakeLists.txt
	use plugins || sed -i -e 's/add_subdirectory(plugins)//' CMakeLists.txt
	use plugins || sed -i -e 's/;vte-2.90//' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.18)"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
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

