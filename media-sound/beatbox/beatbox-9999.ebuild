# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit fdo-mime gnome2-utils vala cmake-utils bzr

DESCRIPTION="A music player with focus on speed, simplicity and music discovery"
HOMEPAGE="https://launchpad.net/beat-box"
EBZR_REPO_URI="lp:beat-box"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ayatana menu nls zeitgeist"

RDEPEND="
	|| ( dev-db/sqlheavy:0.2 dev-db/sqlheavy:0.1 )
	dev-libs/glib:2
	dev-libs/json-glib
	menu? ( >=dev-libs/libdbusmenu-0.4.3 )
	dev-libs/libgee:0
	ayatana? ( >=dev-libs/libindicate-0.5.90 )
	zeitgeist? ( >=dev-libs/libzeitgeist-0.3.10 )
	dev-libs/libxml2:2
	media-libs/gstreamer
	media-libs/gst-plugins-base
	media-libs/libgpod
	media-libs/taglib
	net-libs/libsoup:2.4
	x11-libs/gtk+:3
	x11-libs/granite
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	# Disable generation of the translations (if needed)
	use nls || sed -i 's/add_subdirectory(po)//' CMakeLists.txt

	# Disable built-in gtk-update-icon-cache
	#sed -i '/ICON_UPDATE/s/ ON/ OFF/' images/CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DICON_UPDATE=OFF
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

