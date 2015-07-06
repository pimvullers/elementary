# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.26

inherit fdo-mime gnome2-utils vala cmake-utils versionator

DESCRIPTION="A simple, powerful, sexy file manager for the Pantheon desktop"
HOMEPAGE="http://launchpad.net/pantheon-files"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-2).x/${PV}/+download/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="+gvfs nls"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/dbus-glib
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	gnome-extra/zeitgeist
	>=x11-libs/granite-0.3
	>=x11-libs/gtk+-3.0.3:3
	>=x11-libs/libnotify-0.7.2
	>=x11-libs/pango-1.1.2
	gvfs? ( gnome-base/gvfs )"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS COPYING HACKING README )

src_prepare() {
	epatch_user

	# Disable generation of the translations (if needed)
	use nls || sed -i -e '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DICON_UPDATE=OFF
		-DUSE_UNITY=OFF
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
