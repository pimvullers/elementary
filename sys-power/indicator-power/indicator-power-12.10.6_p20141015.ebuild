# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils cmake-utils

DESCRIPTION="The Power Indicator"
HOMEPAGE="http://launchpad.net/indicator-power"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/indicator-power_12.10.6+14.10.20141015.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="nls static-libs"

RDEPEND="
	>=dev-libs/glib-2.36:2
	>=virtual/libgudev-204
	>=x11-libs/libnotify-0.7.6"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/indicator-power-12.10.6+14.10.20141015"

src_prepare() {
	epatch "${FILESDIR}/${PN}-12.10.6_p20141015-drop-url-dispatcher.patch"
	epatch "${FILESDIR}/${PN}-12.10.6_p20141015-drop-upstart.patch"
	epatch "${FILESDIR}/${PN}-12.10.6_p20141015-drop-gsettings-compile.patch"

	use nls || sed -i -e '/add_subdirectory(po)/d' CMakeLists.txt

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-Denable_tests=OFF
		-Denable_lcov=OFF
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
