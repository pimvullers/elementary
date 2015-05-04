# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.22

inherit fdo-mime gnome2-utils vala cmake-utils bzr

DESCRIPTION="Scratch is a text editor written for the Pantheon desktop"
HOMEPAGE="https://launchpad.net/scratch"
EBZR_REPO_URI="lp:scratch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls contractor files pastebin spell terminal webkit zeitgeist"

RDEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/libgee:0.8
	dev-libs/libpeas
	gnome-base/gconf:2
	x11-libs/gtk+:3
	x11-libs/gtksourceview:3.0
	>=x11-libs/granite-0.3
	$(vala_depend)
	contractor? ( dev-libs/contractor )
	pastebin? ( net-libs/libsoup )
	spell? ( app-text/gtkspell:3 )
	webkit? ( net-libs/webkit-gtk:3 )
	terminal? ( x11-libs/vte:2.90 )
	zeitgeist? ( gnome-extra/zeitgeist )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( COPYING README )
}

src_prepare() {
	epatch_user

	# Translations
	use nls || sed -i -e 's/add_subdirectory (po)//' CMakeLists.txt

	# Plugins
	use files || \
      sed -i -e 's/add_subdirectory (filemanager)//' plugins/CMakeLists.txt
	use pastebin || \
	  sed -i -e 's/add_subdirectory (pastebin)//' plugins/CMakeLists.txt
	use spell || \
	  sed -i -e 's/add_subdirectory (spell)//' plugins/CMakeLists.txt
	use terminal || \
	  sed -i -e 's/add_subdirectory (terminal)//' plugins/CMakeLists.txt
	use terminal || \
	  sed -i -e 's/add_subdirectory (vim-emulation)//' plugins/CMakeLists.txt
	use webkit || \
	  sed -i -e 's/add_subdirectory (browser-preview)//' plugins/CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
		$(cmake-utils_use_with contractor CONTRACTOR)
		$(cmake-utils_use_use zeitgeist ZEITGEIST)
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
