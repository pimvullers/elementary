# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils cmake-utils

DESCRIPTION="The Date and Time Indicator - A very, very simple clock"
HOMEPAGE="https://launchpad.net/indicator-datetime"
SRC_URI="http://launchpad.net/ubuntu/+archive/primary/+files/${PN}_13.10.0%2B13.10.20131023.2.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="
	app-misc/geoclue:0
	>=dev-libs/glib-2.38:2
	>=dev-libs/libdbusmenu-0.5.90:3[gtk]
	dev-libs/libical
	dev-libs/libindicator:3
	gnome-base/gconf
	>=gnome-extra/evolution-data-server-3.5.3
	x11-libs/cairo
	>=x11-libs/libnotify-0.7.6
	>=x11-libs/gtk+-3.1.4:3
	x11-libs/libido:3"
DEPEND="${RDEPEND}"

S="${WORKDIR}/indicator-datetime-13.10.0+13.10.20131023.2"

src_prepare() {
	epatch "${FILESDIR}/${P}-dont-add-empty-location-names.patch"
	epatch "${FILESDIR}/${P}-use-cmake.patch"
	epatch "${FILESDIR}/${P}-show-year.patch"
	epatch "${FILESDIR}/${P}-autostart.patch"
	epatch "${FILESDIR}/${P}-fix-empty-timezone.patch"
	epatch "${FILESDIR}/${P}-r1-drop-url-dispatcher.patch"

	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-Denable_tests=OFF
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
