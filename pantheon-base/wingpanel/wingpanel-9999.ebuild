# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="A super sexy space-saving top panel"
HOMEPAGE="https://launchpad.net/wingpanel"
EBZR_REPO_URI="lp:wingpanel"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND="
	>=dev-libs/glib-2.28.0:2
	>=dev-libs/libgee-0.5.0
	>=dev-libs/libindicator-0.3.92
	>=x11-libs/gtk+-3.0.0:3
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS="AUTHORS COPYING COPYRIGHT"
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DINDICATORDIR="$(pkg-config --variable=indicatordir indicator3-0.4)"
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
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
	gnome2_schemas_update --uninstall
}

