# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit fdo-mime gnome2-utils vala cmake-utils bzr

DESCRIPTION="Stylish top panel that holds indicators and spawns an application launcher"
HOMEPAGE="https://launchpad.net/wingpanel"
EBZR_REPO_URI="lp:wingpanel"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="bluetooth power sound nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	dev-libs/libindicator:3
	x11-libs/gtk+:3
	>=x11-libs/granite-0.3
	x11-libs/libido:3
	x11-libs/libX11"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"
PDEPEND="
	x11-misc/indicator-datetime
	x11-misc/indicator-session
	bluetooth? ( net-misc/indicator-bluetooth )
	power? ( sys-power/indicator-power )
	sound? ( media-sound/indicator-sound )	"

DOCS=( "${S}/AUTHORS" "${S}/COPYING" "${S}/COPYRIGHT" )

src_prepare() {
	epatch "${FILESDIR}/${P}-indicator-files.patch"
	epatch_user

	mv vapi/indicator-0.4.vapi vapi/indicator3-0.4.vapi

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

