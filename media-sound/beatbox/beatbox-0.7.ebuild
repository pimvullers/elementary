# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.14

inherit fdo-mime gnome2-utils vala cmake-utils

DESCRIPTION="A music player with focus on speed, simplicity and music discovery"
HOMEPAGE="https://launchpad.net/beat-box"
SRC_URI="https://launchpad.net/beat-box/trunk/0.3/+download/${PN}_0.1-0%7Er507%2Bpkg15%7Eprecise1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ayatana menu nls zeitgeist"

RDEPEND="
	dev-db/sqlheavy:0.1
	dev-libs/glib:2
	dev-libs/json-glib
	menu? ( >=dev-libs/libdbusmenu-0.4.3 )
	dev-libs/libgee:0
	ayatana? ( >=dev-libs/libindicate-0.5.90 )
	zeitgeist? ( >=dev-libs/libzeitgeist-0.3.10 )
	dev-libs/libxml2:2
	media-libs/clutter-gtk:1.0
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

src_unpack() {
	default_src_unpack

	mv "${WORKDIR}/recipe-{debupstream}-0~r{revno}+pkg{revno:packaging}" "${S}"
}

src_prepare() {
	# Disable generation of the translations (if needed)
	use nls || sed -i 's/add_subdirectory(po)//' CMakeLists.txt

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

