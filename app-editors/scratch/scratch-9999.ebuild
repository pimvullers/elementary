# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit fdo-mime gnome2-utils vala cmake-utils bzr

DESCRIPTION="Scratch is a text editor written for the Pantheon desktop"
HOMEPAGE="https://launchpad.net/scratch"
EBZR_REPO_URI="lp:scratch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls devhelp files pastebin spell terminal webkit"

RDEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/libgee:0
	dev-libs/libpeas
	gnome-base/gconf:2
	>=x11-libs/gtk+-3.4:3
	x11-libs/gtksourceview:3.0
	x11-libs/granite
	dev-libs/libzeitgeist
	files? ( || ( pantheon-base/pantheon-files pantheon-base/marlin ) )
	devhelp? ( dev-util/devhelp )
	pastebin? ( net-libs/libsoup )
	spell? ( app-text/gtkspell:3 )
	webkit? ( net-libs/webkit-gtk:3 )
	terminal? ( x11-libs/vte:2.90 )"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( COPYING README )
}

src_prepare() {
	# Translations
	use nls || sed -i -e 's/add_subdirectory(po)//' CMakeLists.txt

	# Plugins
	use devhelp || \
	  sed -i -e 's/add_subdirectory (devhelp)//' plugins/CMakeLists.txt
	use files || \
      sed -i -e 's/add_subdirectory (filemanager)//' plugins/CMakeLists.txt
	use pastebin || \
	  sed -i -e 's/add_subdirectory (pastebin)//' plugins/CMakeLists.txt
	use terminal || \
	  sed -i -e 's/add_subdirectory (terminal)//' plugins/CMakeLists.txt
	use spell || \
	  sed -i -e 's/add_subdirectory (spell-check)//' plugins/CMakeLists.txt
	use webkit || \
	  sed -i -e 's/add_subdirectory (browser-preview)//' plugins/CMakeLists.txt

	# Disable tests
	sed -i -e 's/add_subdirectory(core-tests)//' scratchcore/CMakeLists.txt

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

