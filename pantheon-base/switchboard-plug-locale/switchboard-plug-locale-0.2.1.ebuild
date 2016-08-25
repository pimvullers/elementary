# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION=0.24

inherit vala gnome2-utils cmake-utils

DESCRIPTION="Adjust Locale settings using Switchboard."
HOMEPAGE="https://launchpad.net/switchboard-plug-locale"
SRC_URI="https://launchpad.net/${PN}/loki/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="nls"

RDEPEND="
	app-i18n/ibus[vala]
	dev-libs/glib:2
	gnome-base/gnome-desktop:3
	>=pantheon-base/switchboard-2
	sys-auth/polkit
	sys-apps/accountsservice
	x11-libs/granite
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

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
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
