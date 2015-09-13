# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.26

inherit fdo-mime gnome2-utils vala cmake-utils bzr

DESCRIPTION="Noise is the official music player of elementary OS"
HOMEPAGE="https://launchpad.net/noise"
EBZR_REPO_URI="lp:noise"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="mpris ipod lastfm libnotify nls zeitgeist"

RDEPEND="
	dev-db/sqlheavy
	dev-libs/glib:2
	dev-libs/libgee:0.8
	dev-libs/libpeas[gtk]
	gnome-extra/libgda
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/taglib
	libnotify? ( x11-libs/libnotify )
	ipod? ( media-libs/libgpod )
	lastfm? (
	  dev-libs/json-glib
	  dev-libs/libxml2:2
	  net-libs/libsoup:2.4
	)
	mpris? ( 
	  dev-libs/libdbusmenu
	  dev-libs/libindicate
	)
	zeitgeist? ( gnome-extra/zeitgeist )
	x11-libs/gtk+:3
	x11-libs/granite"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README )

src_prepare() {
	epatch_user

	# Disable generation of the translations (if needed)
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	# Disable building of plugins (if needed)
	use lastfm || sed -i '/add_subdirectory (LastFM)/d' plugins/CMakeLists.txt
	use mpris || sed -i '/add_subdirectory (MPRIS)/d' plugins/CMakeLists.txt
	use zeitgeist || sed -i '/add_subdirectory (Zeitgeist)/d' plugins/CMakeLists.txt
	use ipod || sed -i '/add_subdirectory (iPod)/d' plugins/Devices/CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare	
}

src_configure() {
	local mycmakeargs=(
		-DICON_UPDATE=OFF
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
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

