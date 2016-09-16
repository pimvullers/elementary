# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit gnome2-utils vala cmake-utils

DESCRIPTION="A fast photo booth application designed for the Pantheon desktop"
HOMEPAGE="https://launchpad.net/snap-elementary"
SRC_URI="https://launchpad.net/${PN}-elementary/freya/${PV}/+download/${PN}-photobooth-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	gnome-extra/zeitgeist
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-video/cheese
	virtual/libgudev
	x11-libs/gtk+:3
	x11-libs/granite
	x11-libs/libX11"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	S="${WORKDIR}/${PN}-photobooth-${PV}"
	DOCS=(README)
}

src_prepare() {
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

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
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

