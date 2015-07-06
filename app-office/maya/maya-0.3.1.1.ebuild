# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.24
VALA_MAX_API_VERSION=0.26

inherit fdo-mime gnome2-utils vala cmake-utils

DESCRIPTION="Slim, lightweight, GCal-syncing GTK+ Calendar application"
HOMEPAGE="http://launchpad.net/maya"
SRC_URI="http://launchpad.net/${PN}/freya/${PV}/+download/${PN}-calendar-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="nls"

RDEPEND="
	dev-libs/folks
	dev-libs/glib:2
	dev-libs/libgee:0.8
	dev-libs/libical
	gnome-base/gconf:2
	<gnome-extra/evolution-data-server-3.16
	media-libs/clutter
	media-libs/libchamplain
	net-libs/libsoup:2.4
	sci-geosciences/geocode-glib
	x11-libs/gtk+:3
	x11-libs/granite"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	S="${WORKDIR}/${PN}-calendar-${PV}"
	DOCS=( AUTHORS COPYING COPYRIGHT )
}

src_prepare() {
	use nls || sed -i '/add_subdirectory(po)/d' CMakeLists.txt

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
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_schemas_update
}
