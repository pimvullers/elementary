# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.24

inherit fdo-mime gnome2-utils vala cmake-utils

DESCRIPTION="Stylish top panel that holds indicators and spawns an application launcher"
HOMEPAGE="https://launchpad.net/wingpanel"
SRC_URI="https://launchpad.net/${PN}/2.x/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="accessibility bluetooth keyboard network power sound nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	x11-libs/granite
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-wm/gala"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"
PDEPEND="
	pantheon-base/wingpanel-indicator-datetime
	pantheon-base/wingpanel-indicator-notifications
	pantheon-base/wingpanel-indicator-session
	accessibility? ( pantheon-base/wingpanel-indicator-accessibility )
	bluetooth? ( pantheon-base/wingpanel-indicator-bluetooth )
	keyboard? ( pantheon-base/wingpanel-indicator-keyboard )
	network? ( pantheon-base/wingpanel-indicator-network )
	power? ( pantheon-base/wingpanel-indicator-power )
	sound? ( pantheon-base/wingpanel-indicator-sound )"

src_prepare() {
	eapply_user

	use nls || sed -i '/add_subdirectory(po)/d' CMakeLists.txt || die

	# respect appropriate libdir for gala plugins
	[[ $(get_libdir) == lib ]] || \
		sed -e "s|/lib|/$(get_libdir)|g" \
			-i wingpanel-interface/CMakeLists.txt || die

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE=${VALAC}
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
