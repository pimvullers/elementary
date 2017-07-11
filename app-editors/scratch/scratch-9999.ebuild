# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit fdo-mime gnome2-utils vala cmake-utils git-r3

DESCRIPTION="Scratch is a text editor written for the Pantheon desktop"
HOMEPAGE="https://launchpad.net/scratch"
EGIT_REPO_URI="https://github.com/elementary/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls contractor files pastebin spell terminal webkit zeitgeist"

RDEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/libgee:0.8
	dev-libs/libpeas[gtk]
	x11-libs/gtk+:3
	x11-libs/gtksourceview:3.0
	>=x11-libs/granite-0.3
	$(vala_depend)
	contractor? ( dev-libs/contractor:0 )
	pastebin? ( net-libs/libsoup:2.4 )
	spell? ( app-text/gtkspell:3 )
	webkit? ( net-libs/webkit-gtk:3 )
	terminal? ( || ( x11-libs/vte:2.91 x11-libs/vte:2.90 ) )
	zeitgeist? ( gnome-extra/zeitgeist )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( COPYING )
}

src_prepare() {
	eapply "${FILESDIR}/${PN}-2.4.1-translations.patch"
	eapply_user

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
		-DWITH_CONTRACTOR="$(usex contractor)"
		-DUSE_ZEITGEIST="$(usex zeitgeist)"
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
