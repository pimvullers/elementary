# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.24

inherit fdo-mime gnome2-utils vala cmake-utils bzr

DESCRIPTION="Noise is the official music player of elementary OS"
HOMEPAGE="https://launchpad.net/noise"
EBZR_REPO_URI="lp:noise"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="mpris ipod lastfm nls plugins upnp"

REQUIRED_USE="upnp? ( plugins )"

RDEPEND="
	dev-db/sqlheavy
	dev-libs/glib:2
	dev-libs/libgee:0.8
	dev-libs/libpeas[gtk]
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	media-libs/taglib
	plugins? ( 
	  upnp? ( || ( 
		( >=net-libs/gupnp-0.20	>=net-libs/gupnp-av-0.12 ) 
		net-libs/gupnp-vala 
	  ) )
	  ipod? ( media-libs/libgpod )
	  lastfm? (
		dev-libs/json-glib
		dev-libs/libxml2:2
		net-libs/libsoup:2.4
	  )
	  mpris? ( 
		dev-libs/libdbusmenu
		>=dev-libs/libindicate-0.5.90 
	  )
	)
	x11-libs/gtk+:3
	x11-libs/granite
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

REQUIRED_USE="
	ipod? ( plugins ) 
	upnp? ( plugins )
	lastfm? ( plugins )
	mpris? ( plugins )"

DOCS=( AUTHORS NEWS README )

src_prepare() {
	epatch_user

	# Disable generation of the translations (if needed)
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	# Disable building of plugins (if needed)
	use plugins || sed -i '/add_subdirectory (plugins)/d' CMakeLists.txt

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

