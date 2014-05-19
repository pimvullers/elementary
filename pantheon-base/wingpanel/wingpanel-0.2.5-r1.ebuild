# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit fdo-mime gnome2-utils vala cmake-utils

DESCRIPTION="Stylish top panel that holds indicators and spawns an application launcher"
HOMEPAGE="https://launchpad.net/wingpanel"
SRC_URI="https://launchpad.net/${PN}/0.2.x/${PV}/+download/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bluetooth power sound nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0
	dev-libs/libindicator:3
	x11-libs/gtk+:3
	<x11-libs/granite-0.3
	x11-libs/libX11"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"
PDEPEND="
	<x11-misc/indicator-datetime-13.10.0_p20131023
	<x11-misc/indicator-session-12.10.5_p20131125
	bluetooth? ( <net-misc/indicator-bluetooth-0.0.6_p20131029 )
	power? ( <sys-power/indicator-power-12.10.6_p20131129 )
	sound? ( <media-sound/indicator-sound-12.10.2_p20131125 )	"

DOCS=( "${S}/AUTHORS" "${S}/COPYING" "${S}/COPYRIGHT" )

src_prepare() {
	epatch "${FILESDIR}/${P}-indicator-vapi.patch"
	epatch "${FILESDIR}/${P}-indicator-arrow.patch"
	epatch_user

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
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update
}

