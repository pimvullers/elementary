# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit fdo-mime gnome2-utils vala cmake-utils

DESCRIPTION="Scratch is a text editor written for the Pantheon desktop"
HOMEPAGE="https://launchpad.net/scratch"
SRC_URI="https://launchpad.net/${PN}/1.x/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls devhelp files pastebin terminal"

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
	devhelp? ( <dev-util/devhelp-3.5 )
	pastebin? ( net-libs/libsoup )
	terminal? ( x11-libs/vte:2.90 )"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( COPYING README )
	S="${WORKDIR}/${PN}"
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

	# Disable tests
	sed -i -e 's/add_subdirectory(core-tests)//' scratchcore/CMakeLists.txt

	# Fix devhelp dependency in scratchcore (bug #1040924)
	epatch "${FILESDIR}/${P}-devhelp.patch"
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

