# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit gnome2-utils cmake-utils bzr

DESCRIPTION="The Date and Time Indicator - A very, very simple clock"
HOMEPAGE="https://launchpad.net/indicator-datetime"
EBZR_REPO_URI="lp:indicator-datetime"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls"

RDEPEND="
	>=dev-libs/glib-2.36:2
	dev-libs/libical
	dev-libs/properties-cpp
	gnome-extra/evolution-data-server
	media-libs/libcanberra
	net-libs/libaccounts-glib
	>=x11-libs/libnotify-0.7.6"
DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user

	eapply -p0 "${FILESDIR}/${P}-drop-ubuntu.patch"

	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cp ${FILESDIR}/GSettings.cmake cmake/
	sed -i 's/UseGSettings/GSettings/' data/CMakeLists.txt

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
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
